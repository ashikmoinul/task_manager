import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_lists_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';

class CancelledTaskController extends GetxController {
  bool _canceledTaskInProgress = false;
  List<TaskModel> _canceledTaskList = [];
  String _errorMessage = '';

  bool get canceledTaskInProgress => _canceledTaskInProgress;

  List get canceledTaskList => _canceledTaskList;

  String get errorMessage => _errorMessage;

  @override
  void onInit() {
    super.onInit();
    getCancelledTask();
  }

  Future<bool> getCancelledTask() async {
    bool isSuccess = false;

    _canceledTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.cancelledTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseData);
      _canceledTaskList = taskListWrapperModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Get progress task failed! Try again.';
      isSuccess = false;
    }

    _canceledTaskInProgress = false;
    update();

    return isSuccess;
  }
}