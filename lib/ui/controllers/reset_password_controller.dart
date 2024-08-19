import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';


class ResetPasswordController extends GetxController {
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  Future<bool> resetPassword(String email, String otp, String password) async {
    bool isSuccess = false;

    Map<String, dynamic> requestData = {
      "email": email,
      "OTP": otp,
      "password": password,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.resetPassword,
      body: requestData,
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Reset password failed! Try again.';
      isSuccess = false;
    }

    return isSuccess;
  }
}