import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../api_manager/dio_client.dart';
import '../../api_manager/endpoints.dart';
import '../../models/menu_model.dart';


enum MenuState { idle, loading, loaded, error }

class MenuProvider extends ChangeNotifier {
  final DioClient _client = DioClient();
  List<MenuModel> _menus = [];
  MenuState _state = MenuState.idle;
  String? _errorMessage;


  List<MenuModel> get menus => _menus;
  MenuState get state => _state;
  String? get errorMessage => _errorMessage;


  Future<void> fetchMenus() async {
    _state = MenuState.loading;
    notifyListeners();

    try {
      final Response response = await _client.get(Endpoints.menus);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = response.data;
        _menus = jsonResponse.map((json) => MenuModel.fromJson(json)).toList();
        _state = MenuState.loaded;
        notifyListeners();
      } else {
        _state = MenuState.error;
        _errorMessage = 'Failed to load menus: ${response.statusMessage}';
        notifyListeners();
      }
    } catch (e) {
      _state = MenuState.error;
      _errorMessage = 'An error occurred: ${e.toString()}';
      notifyListeners();
    }
  }
}
