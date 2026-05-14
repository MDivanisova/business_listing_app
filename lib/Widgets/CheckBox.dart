import 'package:flutter/material.dart';

Widget checkBoxWidget(BuildContext context,String label, bool value, Function(bool?) onChanged) {
  return SizedBox(
    child: Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(label),
      ],
    ),
  );
}