import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_by_status_count_wrapper_model.dart';
import 'package:task_manager/data/models/task_count_by_status_model.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager/ui/widgets/task_summary_card.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_lists_wrapper_model.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_item.dart';

// class CompletedTaskScreen extends StatefulWidget {
//   const CompletedTaskScreen({super.key});
//
//   @override
//   State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
// }
//
// class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
//
//   bool _getCompletedTasksInProgress = false;
//   bool _getTaskCountByStatusInProgress = false;
//   List<TaskModel> completedTasks = [];
//   List<TaskCountByStatusModel> taskCountByStatusList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _getTaskCountByStatus();
//     _getCompletedTasks();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: RefreshIndicator(
//         onRefresh: () async => _getCompletedTasks(),
//         child: Visibility(
//           visible: _getCompletedTasksInProgress == false,
//           replacement: const CenteredProgressIndicator(),
//           child: ListView.builder(
//             itemCount: completedTasks.length,
//             itemBuilder: (context, index) {
//               return TaskItem(
//                 taskModel: completedTasks[index], onUpdateTask: () {
//                   _getCompletedTasks();
//
//               } ,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//   Future<void> _getCompletedTasks() async {
//
//     _getCompletedTasksInProgress = true;
//     if (mounted) {
//       setState(() {});
//     }
//     NetworkResponse response = await NetworkCaller.getRequest(Urls.completedTasks);
//     if (response.isSuccess) {
//       TaskListWrapperModel taskListWrapperModel =
//       TaskListWrapperModel.fromJson(response.responseData);
//       completedTasks = taskListWrapperModel.taskList ?? [];
//     }
//     else {
//       if(mounted){
//         showSnackBarMessage(context, response.errorMessage ?? 'Get new task failed! Try again.');
//       }
//
//     }
//     _getCompletedTasksInProgress = false;
//
//     if (mounted){
//       setState(() {
//
//       });
//     }
//
//   }
//
//   Future<void> _getTaskCountByStatus() async {
//     _getTaskCountByStatusInProgress = true;
//     if (mounted) {
//       setState(() {});
//     }
//     NetworkResponse response =
//     await NetworkCaller.getRequest(Urls.taskStatusCount);
//
//     //_getTaskCountByStatusInProgress = false;
//
//     if (response.isSuccess) {
//       TaskCountByStatusWrapperModel taskListWrapperModel =
//       TaskCountByStatusWrapperModel.fromJson(response.responseData);
//       taskCountByStatusList = taskListWrapperModel.taskCountByStatusList ?? [];
//     } else {
//       if (mounted) {
//         showSnackBarMessage(
//             context,
//             response.errorMessage ??
//                 'Get task count by status failed! Try again.');
//       }
//     }
//     _getTaskCountByStatusInProgress = false;
//
//     if (mounted) {
//       setState(() {});
//     }
//   }
// }
//

// class CompletedTaskScreen extends StatefulWidget {
//   const CompletedTaskScreen({super.key});
//
//   @override
//   State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
// }
//
// class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
//   bool _getCompletedTasksInProgress = false;
//   bool _getTaskCountByStatusInProgress = false;
//   List<TaskModel> newTaskList = [];
//   List<TaskCountByStatusModel> taskCountByStatusList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _getTaskCountByStatus();
//     _getCompletedTasks();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
//         child: Column(
//           children: [
//             _buildSummarySection(),
//             const SizedBox(
//               height: 8,
//             ),
//             Expanded(
//               child: RefreshIndicator(
//                 onRefresh: () async {
//                   _getCompletedTasks();
//                   _getTaskCountByStatus();
//                 },
//                 child: Visibility(
//                   visible: _getCompletedTasksInProgress == false,
//                   replacement: const CenteredProgressIndicator(),
//                   child: ListView.builder(
//                     itemCount: newTaskList.length,
//                     itemBuilder: (context, index) {
//                       return TaskItem(
//                         taskModel: newTaskList[index], onUpdateTask: () {
//                         _getCompletedTasks();
//                         _getTaskCountByStatus();
//                       },
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _onTapAddButton,
//         backgroundColor: Colors.green,
//         foregroundColor: Colors.white,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   void _onTapAddButton() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const AddNewTaskScreen(),
//       ),
//     );
//   }
//
//   Widget _buildSummarySection() {
//     return Visibility(
//       visible: _getTaskCountByStatusInProgress == false,
//       replacement: const SizedBox(
//         height: 100,
//         child: CenteredProgressIndicator(),
//       ),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: taskCountByStatusList.map((e) {
//             return TaskSummaryCard(
//               title: (e.sId ?? 'Unknown').toUpperCase(),
//               count: e.sum.toString(),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _getCompletedTasks() async {
//     _getCompletedTasksInProgress = true;
//     if (mounted) {
//       setState(() {});
//     }
//     NetworkResponse response = await NetworkCaller.getRequest(Urls.completedTasks);
//     if (response.isSuccess) {
//       TaskListWrapperModel taskListWrapperModel =
//       TaskListWrapperModel.fromJson(response.responseData);
//       newTaskList = taskListWrapperModel.taskList ?? [];
//     } else {
//       if (mounted) {
//         showSnackBarMessage(context,
//             response.errorMessage ?? 'Get new task failed! Try again.');
//       }
//     }
//     _getCompletedTasksInProgress = false;
//
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   Future<void> _getTaskCountByStatus() async {
//     _getTaskCountByStatusInProgress = true;
//     if (mounted) {
//       setState(() {});
//     }
//     NetworkResponse response =
//     await NetworkCaller.getRequest(Urls.taskStatusCount);
//
//     //_getTaskCountByStatusInProgress = false;
//
//     if (response.isSuccess) {
//       TaskCountByStatusWrapperModel taskListWrapperModel =
//       TaskCountByStatusWrapperModel.fromJson(response.responseData);
//       taskCountByStatusList = taskListWrapperModel.taskCountByStatusList ?? [];
//     } else {
//       if (mounted) {
//         showSnackBarMessage(
//             context,
//             response.errorMessage ??
//                 'Get task count by status failed! Try again.');
//       }
//     }
//     _getTaskCountByStatusInProgress = false;
//
//     if (mounted) {
//       setState(() {});
//     }
//   }
// }

// class CompletedTaskScreen extends StatefulWidget {
//   const CompletedTaskScreen({super.key});
//
//   @override
//   State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
// }
//
// class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
//
//   bool _getCompletedTasksInProgress = false;
//   List<TaskModel> completedTasks = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _getCompletedTasks();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: RefreshIndicator(
//         onRefresh: () async => _getCompletedTasks(),
//         child: Visibility(
//           visible: _getCompletedTasksInProgress == false,
//           replacement: const CenteredProgressIndicator(),
//           child: ListView.builder(
//             itemCount: completedTasks.length,
//             itemBuilder: (context, index) {
//               return TaskItem(
//                 taskModel: completedTasks[index], onUpdateTask: () {
//                 _getCompletedTasks();
//               },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _getCompletedTasks() async {
//     _getCompletedTasksInProgress = true;
//     if (mounted) {
//       setState(() {});
//     }
//     NetworkResponse response = await NetworkCaller.getRequest(
//         Urls.completedTasks);
//     if (response.isSuccess) {
//       TaskListWrapperModel taskListWrapperModel =
//       TaskListWrapperModel.fromJson(response.responseData);
//       completedTasks = taskListWrapperModel.taskList ?? [];
//     }
//     else {
//       if (mounted) {
//         showSnackBarMessage(context,
//             response.errorMessage ?? 'Get new task cancelled! Try again.');
//       }
//     }
//     _getCompletedTasksInProgress = false;
//
//     if (mounted) {
//       setState(() {
//
//       });
//     }
//   }
//
// }
class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTasksInProgress = false;
  bool _getTaskCountByStatusInProgress = false;
  List<TaskModel> newTaskList = [];
  List<TaskCountByStatusModel> taskCountByStatusList = [];

  @override
  void initState() {
    super.initState();
    _getTaskCountByStatus();
    _getCompletedTasks();
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
                  _getCompletedTasks();
                  _getTaskCountByStatus();
                },
                child: Visibility(
                  visible: _getCompletedTasksInProgress == false,
                  replacement: const CenteredProgressIndicator(),
                  child: ListView.builder(
                    itemCount: newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: newTaskList[index], onUpdateTask: () {
                        _getCompletedTasks();
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

  Future<void> _getCompletedTasks() async {
    _getCompletedTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.completedTasks);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseData);
      newTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Get new task failed! Try again.');
      }
    }
    _getCompletedTasksInProgress = false;

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