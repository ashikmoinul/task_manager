import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';


class TaskItemController extends GetxController {
  final TaskModel taskModel;

  TaskItemController(this.taskModel);

  String _dropDownValue = '';
  String _errorMessage = "";
  final List<String> _statusList = [
    'New',
    'Progress',
    'Completed',
    'Canceled',
  ];

  String get dropDownValue => _dropDownValue;

  String get errorMessage => _errorMessage;

  List<String> get statusList => _statusList;

  @override
  void onInit() {
    super.onInit();
    _dropDownValue = taskModel.status!;
  }

  Future<bool> updateTaskStatus(String status) async {
    bool isSuccess = false;

    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.updateTaskStatus(taskModel.sId!, status),
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Get task count by status failed! Try again.';
      isSuccess = false;
    }

    return isSuccess;
  }

  Future<bool> deleteTask() async {
    bool isSuccess = false;

    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.deleteTask(taskModel.sId!),
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Get task count by status failed! Try again.';
      isSuccess = false;
    }

    return isSuccess;
  }

  void setDropDownValue(String value) {
    _dropDownValue = value;
    update();
  }
}