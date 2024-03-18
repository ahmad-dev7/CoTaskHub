import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/firebase_options.dart';
import 'package:co_task_hub/screens/home_screen.dart';
import 'package:co_task_hub/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MyController ctrl = Get.put(MyController());
    return GetMaterialApp(
      home: ctrl.box.hasData('name') ? const HomeScreen() : const LoginScreen(),
    );
  }
}
