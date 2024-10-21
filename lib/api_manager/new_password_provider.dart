import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../api_manager/dio_client.dart';
import '../api_manager/endpoints.dart';

/// Enum representing the different states of the password reset process
enum ResetPasswordStatus { idle, resetting, success, failed }

class ResetPasswordProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  ResetPasswordStatus _status = ResetPasswordStatus.idle;
  ResetPasswordStatus get status => _status;

  set status(ResetPasswordStatus value) {
    _status = value;
    notifyListeners();
  }

  String? _message;
  String? get message => _message;

  Future<Map<String, dynamic>> resetPassword(String token, String identifier, bool isMobile, String newPassword) async {

    Map<String, dynamic> result = {'status': false, 'message': 'An unknown error occurred'};

    final resetData = {
      "token": token,
      "identifier": identifier,
      "isMobile": isMobile,
      "password": newPassword,
    };

    status = ResetPasswordStatus.resetting;

    try {

      final Response response = await _client.put(Endpoints.verifyOTP, data: resetData);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['status'] == "Password Reset!") {
          status = ResetPasswordStatus.success;
          _message = 'Password reset successfully';
          result = {'status': true, 'message': _message};
        } else {

          status = ResetPasswordStatus.failed;
          _message = 'Password reset failed: ${responseData['message']}';
          result = {'status': false, 'message': _message};
        }
      } else {
        status = ResetPasswordStatus.failed;
        _message = 'Password reset failed: Server error';
        result = {'status': false, 'message': _message};
      }
    } catch (e) {

      status = ResetPasswordStatus.failed;
      _message = 'An error occurred: ${e.toString()}';
      result = {'status': false, 'message': _message};
    }

    notifyListeners();
    return result;
  }
}
