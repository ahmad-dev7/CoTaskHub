import 'package:flutter/material.dart';

class KTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool? isPasswordField;
  final String hintText;

  const KTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPasswordField,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPasswordField ?? false,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}
