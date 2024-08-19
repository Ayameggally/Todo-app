import 'package:flutter/material.dart';
import 'package:todo3/app_theme.dart';

class DefaultElevatedButton extends StatelessWidget {
  DefaultElevatedButton({required this.lable,required this.onPressed});

  String lable;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
     style: ElevatedButton.styleFrom(
      fixedSize: Size(MediaQuery.of(context).size.width,25),
      ),

      onPressed: onPressed,
       child: Text(
        lable,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w400,
          color: AppTheme.white ),),
       );
  }
}