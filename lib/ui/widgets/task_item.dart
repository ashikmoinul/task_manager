import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key, required this.taskModel,
  });
final TaskModel taskModel;



  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        title: Text(taskModel.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskModel.description ?? ''),
            Text( taskModel.createdDate ?? '',
              style:
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label:  Text(taskModel.status ?? 'New'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                ButtonBar(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.delete)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
