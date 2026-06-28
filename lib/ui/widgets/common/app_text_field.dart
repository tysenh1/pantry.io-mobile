

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? placeholder;
  final bool? isMultiLine;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    this.placeholder,
    this.isMultiLine = false,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: isMultiLine! ? TextInputType.multiline : keyboardType,
      maxLines: isMultiLine! ? null : 1,
      minLines: isMultiLine! ? 4 : 1,
      decoration: InputDecoration(
        hintText: placeholder
      ),
    );
  }
}