import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/screens/home_screen.dart';
import 'package:co_task_hub/screens/login_screen.dart';
import 'package:co_task_hub/screens/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    navigate();

    super.initState();
  }

  navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAll(() => dataBox.isNotEmpty
        ? myController.teamData.value.teamCode != null
            ? const NavigationScreen()
            : const HomeScreen()
        : const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
