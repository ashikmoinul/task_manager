import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_by_status_count_wrapper_model.dart';
import 'package:task_manager/data/models/task_count_by_status_model.dart';
import 'package:task_manager/data/models/task_lists_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_item.dart';
import 'package:task_manager/ui/widgets/task_summary_card.dart';

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

// class InProgressTaskScreen extends StatefulWidget {
//   const InProgressTaskScreen({super.key});
//
//   @override
//   State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
// }
//
// class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
//
//   bool _getInProgressTasksInProgress = false;
//   List<TaskModel> inProgressTasks = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _getInProgressTasks();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: RefreshIndicator(
//         onRefresh: () async => _getInProgressTasks(),
//         child: Visibility(
//           visible: _getInProgressTasksInProgress == false,
//           replacement: const CenteredProgressIndicator(),
//           child: ListView.builder(
//             itemCount: inProgressTasks.length,
//             itemBuilder: (context, index) {
//               return TaskItem(
//                 taskModel: inProgressTasks[index], onUpdateTask: () {
//                 _getInProgressTasks();
//
//               } ,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//   Future<void> _getInProgressTasks() async {
//
//     _getInProgressTasksInProgress = true;
//     if (mounted) {
//       setState(() {});
//     }
//     NetworkResponse response = await NetworkCaller.getRequest(Urls.inProgressTasks);
//     if (response.isSuccess) {
//       TaskListWrapperModel taskListWrapperModel =
//       TaskListWrapperModel.fromJson(response.responseData);
//       inProgressTasks = taskListWrapperModel.taskList ?? [];
//     }
//     else {
//       if(mounted){
//         showSnackBarMessage(context, response.errorMessage ?? 'In progress task failed! Try again.');
//       }
//
//     }
//     _getInProgressTasksInProgress = false;
//
//     if (mounted){
//       setState(() {
//
//       });
//     }
//
//   }
// }

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _getInProgressTasksInProgress = false;
  bool _getTaskCountByStatusInProgress = false;
  List<TaskModel> newTaskList = [];
  List<TaskCountByStatusModel> taskCountByStatusList = [];

  @override
  void initState() {
    super.initState();
    _getTaskCountByStatus();
    _getInProgressTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          children: [
            _buildSummarySection(),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _getInProgressTasks();
                  _getTaskCountByStatus();
                },
                child: Visibility(
                  visible: _getInProgressTasksInProgress == false,
                  replacement: const CenteredProgressIndicator(),
                  child: ListView.builder(
                    itemCount: newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: newTaskList[index], onUpdateTask: () {
                        _getInProgressTasks();
                        _getTaskCountByStatus();
                      },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddButton,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onTapAddButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Visibility(
      visible: _getTaskCountByStatusInProgress == false,
      replacement: const SizedBox(
        height: 100,
        child: CenteredProgressIndicator(),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: taskCountByStatusList.map((e) {
            return TaskSummaryCard(
              title: (e.sId ?? 'Unknown').toUpperCase(),
              count: e.sum.toString(),
            );
          }).toList(),
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
      newTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Get In Progress task failed! Try again.');
      }
    }
    _getInProgressTasksInProgress = false;

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _getTaskCountByStatus() async {
    _getTaskCountByStatusInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
    await NetworkCaller.getRequest(Urls.taskStatusCount);

    //_getTaskCountByStatusInProgress = false;

    if (response.isSuccess) {
      TaskCountByStatusWrapperModel taskListWrapperModel =
      TaskCountByStatusWrapperModel.fromJson(response.responseData);
      taskCountByStatusList = taskListWrapperModel.taskCountByStatusList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Get task count by status failed! Try again.');
      }
    }
    _getTaskCountByStatusInProgress = false;

    if (mounted) {
      setState(() {});
    }
  }
}