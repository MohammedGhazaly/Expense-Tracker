import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.titleController,
    required this.labelString,
    this.inputMaxLength,
    this.inputType = TextInputType.text,
    this.prefexText,
  });

  final TextEditingController titleController;
  final int? inputMaxLength;
  final String labelString;
  final TextInputType inputType;
  final String? prefexText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      // onChanged: _saveTitleInput,
      controller: titleController,
      maxLength: inputMaxLength,
      keyboardType: inputType,
      decoration: InputDecoration(
        prefixText: prefexText,
        label: Text(labelString),
      ),
    );
  }
}
