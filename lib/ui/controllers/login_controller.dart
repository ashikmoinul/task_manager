import 'package:get/get.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';


class LoginController extends GetxController {
  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password, bool isCheckValue) async {
    bool isSuccess = false;

    Map<String, dynamic> requestData = {
      "email": email,
      "password": password,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.login,
      body: requestData,
    );

    if (response.responseData != null && response.responseData['status'] == 'success') {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.accessToken;
      await AuthController.saveUserData(loginModel.userModel!);
      await AuthController.checkAuthState;

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'login failed!';
      isSuccess = false;
    }

    return isSuccess;
  }
}