import 'package:flutter/material.dart';

Widget inputField (ValueChanged<String> method, String placeholder, TextInputType inputType){
  return TextField(
    onChanged: method,
    decoration: InputDecoration(
      hintText: placeholder,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.green, width: 2.0),
      ),
    ),
    keyboardType: inputType,

  );
}