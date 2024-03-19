import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

kConfirmationDialog(
    {required String title,
    required String description,
    required Function() onYes}) {
  Get.dialog(
      AlertDialog(
        title: KMyText(title, color: Colors.black, weight: FontWeight.bold),
        content:
            KMyText(description, color: Colors.black, weight: FontWeight.w400),
        actions: [
          TextButton(
            onPressed: onYes,
            child: const KMyText('Yes', color: Colors.red, size: 16),
          ),
          const KHorizontalSpace(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: accentColor),
            onPressed: () => Get.back(),
            child: const KMyText('Cancel', color: Colors.white),
          ),
        ],
      ),
      barrierColor: const Color(0xE5000000));
}
