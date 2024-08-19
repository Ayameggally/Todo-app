class TaskModel {
  String title;
  String descraption;
  DateTime date;
  bool isDone;

TaskModel({
  required this.title, 
  required this.descraption, 
  required this.date,
   this.isDone= false,
   });

}