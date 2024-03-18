import 'package:flutter/material.dart';

class KCustomButton extends StatelessWidget {
  final Widget child;
  final Function() onTap;
  final Color? color;
  const KCustomButton(
      {super.key, required this.child, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: 30,
      minWidth: double.maxFinite,
      color: color ?? const Color(0xFF55ABD0),
      child: child,
    );
  }
}
