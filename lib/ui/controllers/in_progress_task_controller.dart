
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_lists_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';

class InProgressTaskController extends GetxController {
  bool _inProgressTaskInProgress = false;
  List<TaskModel> _inProgressTaskList = [];
  String _errorMessage = '';

  bool get inProgressTaskInProgress => _inProgressTaskInProgress;

  List get inProgressTaskList => _inProgressTaskList;

  String get errorMessage => _errorMessage;

  @override
  void onInit() {
    super.onInit();
    getInProgressTask();
  }

  Future<bool> getInProgressTask() async {
    bool isSuccess = false;

    _inProgressTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.progressTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseData);
      _inProgressTaskList = taskListWrapperModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Get progress task failed! Try again.';
      isSuccess = false;
    }

    _inProgressTaskInProgress = false;
    update();

    return isSuccess;
  }

}