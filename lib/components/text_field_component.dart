import 'package:flutter/material.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String labelText,
  required TextStyle labelStyle,
  required TextStyle textStyle,
}) {
  return TextField(
    controller: controller,
    style: textStyle,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: labelStyle,
      border: const OutlineInputBorder(),
    ),
  );
}
