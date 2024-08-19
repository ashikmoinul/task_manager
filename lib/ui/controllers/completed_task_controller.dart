import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_lists_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';


class CompleteTaskController extends GetxController {
  bool _completeTaskInProgress = false;
  List<TaskModel> _completeTaskList = [];
  String _errorMessage = '';

  bool get completeTaskInProgress => _completeTaskInProgress;

  List get completeTaskList => _completeTaskList;

  String get errorMessage => _errorMessage;



  Future<bool> getCompleteTask() async {
    bool isSuccess = false;

    _completeTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.completedTasks);


    if (response.isSuccess) {
      isSuccess = true;
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseData);
      _completeTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage ?? 'Get new task failed! Try again.';
    }

    _completeTaskInProgress = false;
    update();

    return isSuccess;
  }
}