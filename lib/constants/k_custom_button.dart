import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_values.dart';
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
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      color: color ?? accentColor,
      minWidth: double.maxFinite,
      child: child,
    );
  }
}
