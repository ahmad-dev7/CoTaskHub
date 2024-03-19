import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

SalomonBottomBarItem kGetBottomBarItems(
    {required IconData icon,
    required String text,
    required IconData activeIcon}) {
  return SalomonBottomBarItem(
    icon: Icon(icon),
    title: KMyText(text),
    activeIcon: Icon(activeIcon),
    selectedColor: accentColor,
    unselectedColor: Colors.black54,
  );
}
