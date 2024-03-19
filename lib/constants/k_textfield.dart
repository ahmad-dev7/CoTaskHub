import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_values.dart';
import 'package:flutter/material.dart';

class KTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool? isPasswordField;
  final String hintText;
  final IconData? iconData;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final Color? color;
  final int? maxLines;

  const KTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPasswordField,
    this.iconData,
    this.keyboardType,
    this.textCapitalization,
    this.color,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      controller: controller,
      maxLines: maxLines ?? 1,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      obscureText: isPasswordField ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: iconData != null ? Icon(iconData) : null,
        prefixIconColor: accentColor,
        filled: true,
        fillColor: color ?? cardColor.withOpacity(0.5),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: color == null ? Colors.white : Colors.white38,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              color: Colors.white38,
            )),
        hintText: hintText,
        hintStyle: const TextStyle(color: hintColor, fontSize: 15),
      ),
    );
  }
}
