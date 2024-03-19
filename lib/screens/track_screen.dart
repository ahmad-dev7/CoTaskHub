import 'package:co_task_hub/constants/k_custom_button.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackProgressScreen extends StatefulWidget {
  const TrackProgressScreen({super.key});

  @override
  State<TrackProgressScreen> createState() => _TrackProgressScreenState();
}

class _TrackProgressScreenState extends State<TrackProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KHorizontalPadding(
        child: Center(
          child: KCustomButton(
              color: Colors.red,
              onTap: () {
                dataBox.clear();
                Get.to(() => const LoginScreen());
              },
              child: const KMyText('Logout')),
        ),
      ),
    );
  }
}
