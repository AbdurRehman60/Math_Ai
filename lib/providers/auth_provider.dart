import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_manager/dio_client.dart';
import '../api_manager/endpoints.dart';
import '../models/user.dart';

enum AuthStatus { notLoggedIn, loggedIn, authenticating, loggedOut }

class AuthProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  AuthStatus _status = AuthStatus.notLoggedIn;
  AuthStatus get status => _status;

  UserModel? _user;
  UserModel? get user => _user;

  set status(AuthStatus value) {
    _status = value;
    notifyListeners();
  }

  // Login with Email & Password
  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> result = {'status': false, 'message': 'An unknown error occurred'};
    final loginData = {"username": email, "password": password};

    status = AuthStatus.authenticating;

    try {
      final Response response = await _client.post(Endpoints.login, data: loginData);
      final responseData = Map<String, dynamic>.from(response.data);

      if (response.statusCode == 200) {
        // print('Login response: ${response.data}');
        if (responseData.containsKey('access') && responseData.containsKey('refresh')) {
          print('Tokens received: Access token: ${responseData['access']}, Refresh token: ${responseData['refresh']}');

          const FlutterSecureStorage storage = FlutterSecureStorage();
          await storage.write(key: 'access_token', value: responseData['access']);
          await storage.write(key: 'refresh_token', value: responseData['refresh']);
          print('Tokens saved successfully');

          _user = UserModel.fromJson(responseData);
          await _saveUserSession(_user!);

          status = AuthStatus.loggedIn;
          result = {'status': true, 'message': 'Login successful'};
        } else {
          status = AuthStatus.notLoggedIn;
          result = {'status': false, 'message': 'Login failed, missing tokens'};
        }
      }
    } on Exception catch (e) {
      if (e.toString() == 'Exception: Invalid credentials') {
        // print('Login failed: Invalid credentials');
        result = {'status': false, 'message': 'Invalid username or password'};
      } else {
        // print('Login error: ${e.toString()}');
        result = {'status': false, 'message': 'An error occurred: ${e.toString()}'};
      }

      status = AuthStatus.notLoggedIn;
    }

    return result;
  }



  // Logout
  Future<void> logout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      _user = null;
      status = AuthStatus.loggedOut;
    } catch (e) {
      print("Logout error: $e");
    }
  }

  Future<void> _saveUserSession(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  Future<void> loadUserSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString('user');

    if (userData != null) {
      _user = UserModel.fromJson(jsonDecode(userData));
      status = AuthStatus.loggedIn;
    } else {
      status = AuthStatus.notLoggedIn;
    }
  }
}
