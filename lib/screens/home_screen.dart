import 'package:co_task_hub/components/welcome_intro.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: KHorizontalPadding(
        child: Center(
          child: SingleChildScrollView(
            child: WelcomeIntro(),
          ),
        ),
      ),
    );
  }
}
