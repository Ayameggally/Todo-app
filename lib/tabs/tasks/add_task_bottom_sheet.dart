import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo3/models/task_model.dart';
import 'package:todo3/tabs/tasks/default_elevated_button.dart';
import 'package:todo3/tabs/tasks/default_text_form_field.dart';
import 'package:todo3/tabs/tasks/firebase_functions.dart';
import 'package:todo3/tabs/tasks/tasks_provider.dart';


class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
TextEditingController titleController=TextEditingController();
TextEditingController descraptionController=TextEditingController();
DateTime selectedDate = DateTime.now();
DateFormat dateFormat= DateFormat('dd/MM/yyyy');
GlobalKey<FormState>formKey=GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    TextStyle? titleMediumStyle = Theme.of(context).textTheme.titleMedium;
    return Container(
      height: MediaQuery.of(context).size.height*0.55,
      padding: EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              'Add new task',
              style: titleMediumStyle,
            ),
            SizedBox(height: 16,),
            DefaultTextFormField(
                controller: titleController, 
                hintText: 'Enter task title',
                validator: (value){
                  if(value==null||value.trim(). isEmpty){
                    return 'Title can not be embty';
                  }
                  return null;
                },
                ),
            SizedBox(height: 16,),
            DefaultTextFormField(
              controller: descraptionController,
              hintText: 'Enter task describtion',
              validator: (value){
                  if(value==null||value.trim().isEmpty){
                    return 'Description can not be embty';
                  }
                  return null;
                },
              maxLines: 5,
            ),
            SizedBox(height: 16,),
            Text(
              'Select date', 
              style: titleMediumStyle?.copyWith(fontWeight: FontWeight.w400)),
            SizedBox(height: 16,),
            InkWell(
              onTap: () async{
                DateTime? dateTime = await showDatePicker(
                  context: context, 
                  initialDate: selectedDate, 
                  firstDate: DateTime.now(), 
                  lastDate: DateTime.now().add(Duration(days: 365)),
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                   );
      
                   if(dateTime!=null){
                    selectedDate=dateTime;
                    setState(() {});
                   }
              },
              child: Text(
                dateFormat.format(selectedDate), 
                style: titleMediumStyle,
                ),
            ),
            SizedBox(height: 32,),
            DefaultElevatedButton(
              lable: 'submit', 
              onPressed: (){
                if(formKey.currentState!.validate()){
                  addTask();
                }
              }, text: 'submit',
            ),
          ],
        ),
      ),
    );
  }

  void addTask(){
    FirebaseFunctions.addTaskToFirestore(
      TaskModel(
        title: titleController.text,
        descraption: descraptionController.text,
        date: selectedDate, 
        ),
      ).timeout(
        Duration(microseconds:500 ),
         onTimeout: (){
          Navigator.of(context).pop();
          Provider.of<TasksProvider>(context,listen: false).getTaske();
          print('Task Added');
          },
      ).catchError((error){
        print('Error');
        print(error);
      });
    
  }
}
