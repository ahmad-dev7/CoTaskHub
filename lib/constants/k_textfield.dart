import 'package:flutter/material.dart';

class KTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool? isPasswordField;
  final String hintText;
  final IconData? iconData;

  const KTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPasswordField,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      obscureText: isPasswordField ?? false,
      decoration: InputDecoration(
        prefixIcon: iconData != null ? Icon(iconData) : null,
        prefixIconColor: Colors.white70,
        filled: true,
        fillColor: Colors.blueGrey,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.white,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.white38,
            )),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white54,
        ),
      ),
    );
  }
}
