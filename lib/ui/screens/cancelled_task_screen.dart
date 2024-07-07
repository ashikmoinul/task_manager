import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_lists_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_item.dart';
import '../../data/utilities/urls.dart';

// class CancelledTaskScreen extends StatefulWidget {
//   const CancelledTaskScreen({super.key});
//
//   @override
//   State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
// }
//
// class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: ListView.builder(
//         itemCount: 5,
//         itemBuilder: (context, index) {
//           // return const TaskItem();
//         },
//       ),
//     );
//   }
// }

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {

  bool _getCancelledTasksInProgress = false;
  List<TaskModel> cancelledTasks = [];

  @override
  void initState() {
    super.initState();
    _getCancelledTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: RefreshIndicator(
        onRefresh: () async => _getCancelledTasks(),
        child: Visibility(
          visible: _getCancelledTasksInProgress == false,
          replacement: const CenteredProgressIndicator(),
          child: ListView.builder(
            itemCount: cancelledTasks.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModel: cancelledTasks[index], onUpdateTask: () {
                _getCancelledTasks();

              } ,
              );
            },
          ),
        ),
      ),
    );
  }
  Future<void> _getCancelledTasks() async {

    _getCancelledTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.cancelledTasks);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseData);
      cancelledTasks = taskListWrapperModel.taskList ?? [];
    }
    else {
      if(mounted){
        showSnackBarMessage(context, response.errorMessage ?? 'Get new task cancelled! Try again.');
      }

    }
    _getCancelledTasksInProgress = false;

    if (mounted){
      setState(() {

      });
    }

  }
}