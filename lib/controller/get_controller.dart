import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box dataBox;

class MyController extends GetxController {
  var themeData = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF435862),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF89AFC2),
    ),
  ).obs;
}
