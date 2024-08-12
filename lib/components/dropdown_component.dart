import 'package:flutter/material.dart';

Widget buildDropdown<T>({
  required T? value,
  required List<T> items,
  required String hintText,
  required TextStyle labelStyle,
  required TextStyle textStyle,
  required String Function(T) itemLabelBuilder,
  required void Function(T?) handleChange,
}) {
  return InputDecorator(
    decoration: InputDecoration(
      labelText: value == null ? '' : hintText,
      labelStyle: labelStyle,
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        key: ValueKey(value),
        value: value,
        isExpanded: true,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              itemLabelBuilder(item),
              style: textStyle,
            ),
          );
        }).toList(),
        onChanged: handleChange,
        hint: Text(hintText, style: textStyle),
      ),
    ),
  );
}
