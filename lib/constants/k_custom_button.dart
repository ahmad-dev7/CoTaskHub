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
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: color ?? const Color(0xFF55ABD0),
      minWidth: double.maxFinite,
      child: child,
    );
  }
}
