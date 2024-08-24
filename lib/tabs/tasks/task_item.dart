import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo3/app_theme.dart';
import 'package:todo3/models/task_model.dart';
import 'package:todo3/tabs/tasks/edit_task.dart';
import 'package:todo3/tabs/tasks/firebase_functions.dart';

class TaskItem extends StatelessWidget {
  TaskItem (this.task);
  
 TaskModel task;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Slidable(
      startActionPane: ActionPane(motion: DrawerMotion(),
            extentRatio: 0.6,
            children: [
              SlidableAction(onPressed: (context)async{
                await FirebaseFunctions.deleteTaskFromFirestore(task.id);
              },
                icon: Icons.delete,
                backgroundColor: AppTheme.red,
                foregroundColor: AppTheme.white,
                label: 'Delete',
                flex: 1,
                borderRadius: BorderRadius.circular(15.0),
                spacing: 10,
              ),
              SlidableAction(onPressed: (context){
                Navigator.pushNamed(context, editTask.routeName,
                    arguments:TaskModel);
              },
                icon: Icons.edit,
                backgroundColor: AppTheme.primary,
                foregroundColor: AppTheme.white,
                label: 'Edit',
                borderRadius: BorderRadius.circular(15.0),
                spacing: 10,
                flex: 1,
              ),
            ]),
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
        decoration: BoxDecoration(color: AppTheme.white,
        borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(end: 8),
            height: 62,
            width: 4,
            color:task.isDone==true? AppTheme.green: theme.primaryColor,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style:task.isDone==false? theme.textTheme.headlineSmall: theme.textTheme.titleMedium
                   ?.copyWith(color: theme.primaryColor),
                  ),
                Text(
                  task.descraption,
                  style:theme.textTheme.titleSmall , 
                  ),
    
            ],
            ),
           Spacer(),
           task.isDone==true?Text("Done!",
                style:Theme.of(context).textTheme.titleMedium ,):
            GestureDetector(
              onTap: ()async{
                  task.isDone=true;
               await   FirebaseFunctions.addTaskToFirestore(task);
                },
              child: Container(
                height: 34,
                width: 69,
                decoration: BoxDecoration(
                color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(10)
                  ),
                child: Icon(
                  Icons.check,
                  color: AppTheme.white,
                  size: 32,
                  ),
                  ),
            ),
            ],
            ),
            ),
    );
  }
}