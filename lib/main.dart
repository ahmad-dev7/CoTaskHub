import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/firebase_options.dart';
import 'package:co_task_hub/screens/loading_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  await Hive.initFlutter();
  dataBox = await Hive.openBox('userData');
  myController = await Get.put(MyController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: kThemeData,
      home: const LoadingScreen(),
    );
  }
}
