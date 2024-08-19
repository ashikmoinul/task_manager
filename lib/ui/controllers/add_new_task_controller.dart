import 'package:get/get.dart';
import 'package:task_manager/data/utilities/urls.dart';
import '../../data/models/network_response.dart';
import '../../data/network_caller/network_caller.dart';

class AddNewTaskController extends GetxController {
  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  Future<bool> addNewTask(title, description) async {
    bool isSuccess = false;

    Map<String, dynamic> requestData = {
      "title": title,
      "description": description,
      "status": "Complete",
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.createTask,
      body: requestData,
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ??  'New Completed Task add failed! Try again.';
      isSuccess = false;
    }

    return isSuccess;
  }
}