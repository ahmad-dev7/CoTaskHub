import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class TrackProgressScreen extends StatefulWidget {
  const TrackProgressScreen({super.key});

  @override
  State<TrackProgressScreen> createState() => _TrackProgressScreenState();
}

class _TrackProgressScreenState extends State<TrackProgressScreen> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return const Scaffold(
      body: KHorizontalPadding(
        child: Center(),
      ),
    );
  }
}
