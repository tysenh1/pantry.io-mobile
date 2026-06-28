

import 'package:flutter/material.dart';


class AppDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? placeholder;

  const AppDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: placeholder
      ),
      items: items
    );
  }
}