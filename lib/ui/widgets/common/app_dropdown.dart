

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
    final color = items.isEmpty ? Colors.grey : Theme.of(context).colorScheme.secondary;
    return DropdownButtonFormField<T>(
      initialValue: value,
      onChanged: onChanged,
      // decoration: InputDecoration(
      //   hintText: placeholder,
      //   hintStyle: TextStyle(
      //     fontFamily: 'Inter',
      //     color: color,
      //   ),
      // ),

      hint: Text(
        placeholder ?? '',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontFamily: 'Inter',
          fontSize: 16,
          color: color,
        )
      ),
      items: items
    );
  }
}