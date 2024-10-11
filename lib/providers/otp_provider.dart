import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../api_manager/dio_client.dart';
import '../api_manager/endpoints.dart';

enum OTPStatus { idle, sending, sent, failed }

class OTPProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  OTPStatus _status = OTPStatus.idle;
  OTPStatus get status => _status;

  set status(OTPStatus value) {
    _status = value;
    notifyListeners();
  }

  String? _message;
  String? get message => _message;

  Future<Map<String, dynamic>> sendOTP(String identifier, bool isMobile) async {
    Map<String, dynamic> result = {
      'status': false,
      'message': 'An unknown error occurred'
    };
    final otpData = {"identifier": identifier, "isMobile": isMobile};

    status = OTPStatus.sending;

    try {
      final Response response =
          await _client.post(Endpoints.verifyOTP, data: otpData);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['status'] == "Sent the email!") {
          status = OTPStatus.sent;
          _message = responseData['status'];
          result = {'status': true, 'message': _message};
        }
        else if (responseData['message'] ==
            "No user with this email or username exists!") {
          status = OTPStatus.failed;
          _message = responseData['message'];
          result = {'status': false, 'message': _message};
        }
      } else {
        status = OTPStatus.failed;
        _message = 'Failed to send OTP';
        result = {'status': false, 'message': _message};
      }
    } catch (e) {
      status = OTPStatus.failed;
      _message = 'An error occurred: ${e.toString()}';
      result = {'status': false, 'message': _message};
    }

    notifyListeners();
    return result;
  }
}
