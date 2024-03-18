import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            KMyText('Welcome to Home ${dataBox.get('name')}'),
          ],
        ),
      )),
    );
  }
}
