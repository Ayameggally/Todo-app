import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo3/models/task_model.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseFunctions {
static CollectionReference <TaskModel> getTasksCollection() => 
FirebaseFirestore.instance .collection('tasks')
.withConverter(
  fromFirestore: (docSnapshot, _) => TaskModel.fromJson(docSnapshot.data()!),
   toFirestore:(taskModel, _) => taskModel.toJson(),
   );


 static Future <void>addTaskToFirestore(TaskModel task)async {
  CollectionReference<TaskModel> tasksCollection = getTasksCollection();
  DocumentReference<TaskModel> documentReference = tasksCollection.doc();
  task.id = documentReference.id;
  return documentReference.set(task);
 }
static Future<List<TaskModel>> getAllTasksFromFirestore() async{
 CollectionReference<TaskModel> tasksCollection = getTasksCollection();
 QuerySnapshot<TaskModel> querySnapshot = await tasksCollection.get();
 return querySnapshot.docs.map((doc)=> doc.data()).toList();
}
static Future<void> deleteTaskFromFirestore(String taskId)async{
   CollectionReference<TaskModel> tasksCollection = getTasksCollection();
return tasksCollection.doc(taskId).delete();
}
static Future<void>updateTask(TaskModel task)async{
    CollectionReference <TaskModel> taskCollection=getTasksCollection();
    taskCollection.doc(task.id).update(task.toJson());
  }
}