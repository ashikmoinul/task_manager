import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_lists_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

// class InProgressTaskScreen extends StatefulWidget {
//   const InProgressTaskScreen({super.key});
//
//   @override
//   State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
// }
//
// class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: 5,
//         itemBuilder: (context, index) {
//
//         },
//       ),
//     );
//   }
// }

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {

  bool _getInProgressTasksInProgress = false;
  List<TaskModel> inProgressTasks = [];

  @override
  void initState() {
    super.initState();
    _getInProgressTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: RefreshIndicator(
        onRefresh: () async => _getInProgressTasks(),
        child: Visibility(
          visible: _getInProgressTasksInProgress == false,
          replacement: const CenteredProgressIndicator(),
          child: ListView.builder(
            itemCount: inProgressTasks.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModel: inProgressTasks[index], onUpdateTask: () {
                _getInProgressTasks();

              } ,
              );
            },
          ),
        ),
      ),
    );
  }
  Future<void> _getInProgressTasks() async {

    _getInProgressTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.inProgressTasks);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseData);
      inProgressTasks = taskListWrapperModel.taskList ?? [];
    }
    else {
      if(mounted){
        showSnackBarMessage(context, response.errorMessage ?? 'In progress task failed! Try again.');
      }

    }
    _getInProgressTasksInProgress = false;

    if (mounted){
      setState(() {

      });
    }

  }
}
