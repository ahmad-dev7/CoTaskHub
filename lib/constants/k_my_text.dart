import 'package:flutter/material.dart';

class KMyText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final TextDecoration? decoration;
  const KMyText(
    this.text, {
    super.key,
    this.color,
    this.size,
    this.weight,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        decoration: decoration ?? TextDecoration.none,
        color: color ?? Colors.black,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
