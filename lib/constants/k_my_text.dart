import 'package:flutter/material.dart';

class KMyText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  const KMyText(
    this.text, {
    super.key,
    this.color,
    this.size,
    this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
