import 'package:flutter/material.dart';
import 'package:todo3/app_theme.dart';
import 'package:todo3/home_screen.dart';

void main() {
  runApp( ToDoRoute());
}


  class ToDoRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName :(_) => HomeScreen(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      

    );
  }
}