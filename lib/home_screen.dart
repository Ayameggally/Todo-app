import 'package:flutter/material.dart';
import 'package:todo3/tabs/settings/settings_tab.dart';
import 'package:todo3/tabs/tasks/add_task_bottom_sheet.dart';
import 'package:todo3/tabs/tasks/tasks_tab.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName ='/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTabIndex=0;
  List<Widget>tabs = [TasksTab(), SettingsTab(),];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:tabs[currentTabIndex] ,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        padding:EdgeInsets.zero ,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        //color: AppTheme.white,
        child: BottomNavigationBar(
          currentIndex: currentTabIndex,
          onTap: (index) {
          currentTabIndex = index;
          setState(() {
          
          });
           
          },
          items: [
            BottomNavigationBarItem(
              label: 'Tasks',
              icon: Icon(Icons.list,
              size: 32,),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings_outlined,
              size: 32,),
              ),
          ]
          ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>showModalBottomSheet(
            context: context,
             builder: (_)=>AddTaskBottomSheet(),
             ),
          child: Icon(Icons.add,size: 32,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}