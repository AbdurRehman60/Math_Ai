import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../api_manager/dio_client.dart';
import '../api_manager/endpoints.dart';

enum OTPVerifyStatus { idle, verifying, verified, failed, expired }

class VerifyOTPProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  OTPVerifyStatus _status = OTPVerifyStatus.idle;
  OTPVerifyStatus get status => _status;

  set status(OTPVerifyStatus value) {
    _status = value;
    notifyListeners();
  }

  String? _message;
  String? get message => _message;

  Future<Map<String, dynamic>> verifyOTP(String token, String identifier, bool isMobile) async {
    Map<String, dynamic> result = {'status': false, 'message': 'An unknown error occurred'};

    final verifyData = {
      "token": token,
      "identifier": identifier,
      "isMobile": isMobile,
      "isVerify": true
    };

    status = OTPVerifyStatus.verifying;

    try {
      final Response response = await _client.put(Endpoints.verifyOTP, data: verifyData);

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status'] == "Match!") {
          status = OTPVerifyStatus.verified;
          _message = 'OTP verified successfully';
          result = {'status': true, 'message': _message};
        }
        else if (responseData['message'] == "Wrong OTP!") {
          status = OTPVerifyStatus.failed;
          _message = 'Wrong OTP, please try again';
          result = {'status': false, 'message': _message};
        }
        else if (responseData['message'] == "OTP expired!") {
          status = OTPVerifyStatus.expired;
          _message = 'OTP has expired, please request a new one';
          result = {'status': false, 'message': _message};
        }
      } else {
        status = OTPVerifyStatus.failed;
        _message = 'Verification failed';
        result = {'status': false, 'message': _message};
      }
    } catch (e) {
      status = OTPVerifyStatus.failed;
      _message = 'An error occurred: ${e.toString()}';
      result = {'status': false, 'message': _message};
    }

    notifyListeners();
    return result;
  }
}
