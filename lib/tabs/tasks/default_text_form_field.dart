import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
DefaultTextFormField({required this.controller,required this.hintText,this.maxLines,this.validator});


TextEditingController controller;
String hintText;
int? maxLines;
String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        ),
        maxLines:maxLines , 
        validator: validator,
    );
  }
}