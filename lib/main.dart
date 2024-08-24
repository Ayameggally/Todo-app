import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo3/app_theme.dart';
import 'package:todo3/firebase_options.dart';
import 'package:todo3/home_screen.dart';
import 'package:todo3/tabs/tasks/edit_task.dart';
import 'package:todo3/tabs/tasks/tasks_provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  await FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings=
     Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp( 
    ChangeNotifierProvider( 
      create: (_) => TasksProvider()..getTaske(),
    child: ToDoRoute(),
    ));
}


  class ToDoRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName :(_) => HomeScreen(),
        editTask.routeName:(_) => editTask(), 
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      

    );
  }
}