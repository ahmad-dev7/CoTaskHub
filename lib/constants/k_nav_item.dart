import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';

TabItem kGetTabItem(IconData icon, String title) {
  return TabItem(
    icon,
    title,
    const Color(0xFF87B9D0),
    circleStrokeColor: Colors.white,
    labelStyle: const TextStyle(color: Colors.white),
  );
}
