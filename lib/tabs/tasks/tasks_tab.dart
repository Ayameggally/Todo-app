import 'package:flutter/material.dart';
import 'package:todo3/models/task_model.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:todo3/tabs/tasks/task_item.dart';

class TasksTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<TaskModel>tasks = List.generate(
      10,
      (index)=>TaskModel(
        title: 'Task # ${index+1} title',
        descraption: 'Task # ${index+1} descraption',
          date: DateTime.now(),
        ),
    );
    return SafeArea(
      child: Column(
        children: [
          EasyInfiniteDateTimeLine(
            firstDate: DateTime.now().subtract(Duration(days: 365)), 
            focusDate: DateTime.now(), 
            lastDate: DateTime.now().add(Duration(days: 365)),
            showTimelineHeader: false,
            ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 20),
        itemBuilder: (_, index) => TaskItem(tasks[index]),
        itemCount:tasks.length,
        ),
        ),
        ],
        
      ),
    );
  }
}