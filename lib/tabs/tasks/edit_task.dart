import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo3/app_theme.dart';
import 'package:todo3/models/task_model.dart';
import 'package:todo3/tabs/tasks/default_elevated_button.dart';
import 'package:todo3/tabs/tasks/firebase_functions.dart';


class editTask extends StatefulWidget {
  static const String routeName='/editTask';

  @override
  State<editTask> createState() => _editTaskState();
}

class _editTaskState extends State<editTask> {
  TextEditingController title=TextEditingController();

  TextEditingController desc=TextEditingController();
  var task;
  DateTime selectedTime=DateTime.now();
  DateFormat dataFormat=DateFormat('dd/MM/yyy');

  @override
  Widget build(BuildContext context) {
     task=ModalRoute.of(context)!.settings.arguments as TaskModel;
      return Scaffold(
        backgroundColor: AppTheme.backgroundLight,
     body: Container(
       margin: EdgeInsets.symmetric(vertical: 80.0,horizontal: 30),
       padding: EdgeInsets.all(24.0),
       width: 357,
       height: 619,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(15.0),
         color: AppTheme.white
       ),
       child: Column(

         children: [
           Text("Edit Task",style: Theme.of(context).textTheme.headlineSmall!.copyWith(
             fontWeight: FontWeight.bold,
             color: Colors.black
           ),),
           SizedBox(height: 70.0,),
       TextFormField(
         initialValue: task.title,
         onChanged: (value){
           task.title=value;
         },
         validator: (value){
           if(value!.isEmpty &&value == null){
             return "title must be not empty";
           }else{
             return null;
           }
         },

         decoration: InputDecoration(
           hintText: "Enter a task",
           hintStyle: TextStyle(
               color: AppTheme.black,
               fontSize: 20.0,
               fontWeight: FontWeight.w400,
               fontFamily: 'Inter'
           ),

         ),
       ),
           SizedBox(height: 20.0,),
           TextFormField(
             initialValue: task.desc,
             onChanged: (value){
               task.desc=value;
             },
             validator: (value){
               if(value!.isEmpty &&value==null){
                 return "Description must be not empty";
               }else{
                 return null;
               }
             },

             decoration: InputDecoration(
               hintText: "Enter detials",
               hintStyle: TextStyle(
                   color: AppTheme.black,
                   fontSize: 20.0,
                   fontWeight: FontWeight.w400,
                   fontFamily: 'Inter'
               ),

             ),
           ),
           SizedBox(height: 20.0,),
           Align(
               alignment: Alignment.topLeft,
               child: Text("Selected Date",style: Theme.of(context).textTheme.headlineSmall,)),
           SizedBox(height: 20.0,),
           GestureDetector(
             onTap: ()async{
             DateTime?newDate=await  chooseDate();
             },
             child: Text("${dataFormat.format(task.dateTime)}",
             style: Theme.of(context).textTheme.headlineSmall!
             .copyWith(
                 fontWeight: FontWeight.bold,
                 color: Colors.black
             ),),
           ),   SizedBox(height: 40.0,),

     ElevatedButton(
      onPressed: () async {
    await FirebaseFunctions.updateTask(task);
    Navigator.pop(context);
  },
  child: Text("Save Changes"),
)

         ],
       ),
     ),
      );

  }
  updateTask(){
    FirebaseFunctions.updateTask(
      TaskModel(
        title: title.text,
         descraption:desc.text ,
          date: selectedTime,
          ),
    );
  }

  chooseDate()async{
    DateTime? date=await showDatePicker(
      context: context,
        firstDate: DateTime.now()
        .subtract(Duration(days: 365
        )),
        initialDate: selectedTime,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        lastDate: DateTime.now().add(Duration(
            days: 365
        )));
    if(date!=null){
      selectedTime=date;
      setState(() {

      });
    }
  }
}