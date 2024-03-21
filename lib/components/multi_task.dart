import 'package:co_task_hub/components/welcome_intro.dart';
import 'package:co_task_hub/constants/k_colors.dart';
import 'package:flutter/material.dart';

class MultiTask extends StatefulWidget {
  const MultiTask({super.key});

  @override
  State<MultiTask> createState() => _MultiTaskState();
}

class _MultiTaskState extends State<MultiTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: accentColor),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: WelcomeIntro(),
      ),
    );
  }
}
