import 'package:co_task_hub/components/create_team_dialog.dart';
import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_custom_button.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_textfield.dart';
import 'package:co_task_hub/constants/k_values.dart';
import 'package:co_task_hub/screens/navigation_screen.dart';
import 'package:co_task_hub/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeIntro extends StatefulWidget {
  const WelcomeIntro({super.key});

  @override
  State<WelcomeIntro> createState() => _WelcomeIntroState();
}

class _WelcomeIntroState extends State<WelcomeIntro> {
  TextEditingController teamCodeController = TextEditingController();
  var teamNameController = TextEditingController();
  var projectNameController = TextEditingController();
  var projectDescriptionController = TextEditingController();
  onCreateTeam() {
    Get.dialog(
      CreateTeamDialog(
        teamNameController: teamNameController,
        projectNameController: projectNameController,
        projectDescriptionController: projectDescriptionController,
      ),
      barrierDismissible: false,
      barrierColor: const Color(0xAF000000),
    ).then((value) {
      Get.snackbar(
        '',
        '',
        isDismissible: true,
        titleText: const KMyText('Team Created',
            color: Colors.white, weight: FontWeight.bold, size: 18),
        messageText: const KMyText(
            'Team code is copied to clipboard, share it with  your members.',
            weight: FontWeight.w400,
            color: Colors.white),
        duration: const Duration(seconds: 15),
        backgroundColor: Colors.green,
      );
      Get.offAll(() => const NavigationScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const KMyText(
          "Are you experiencing difficulties coordinating tasks, sharing files, scheduling meetings, and tracking progress effectively?",
          size: 15,
          weight: FontWeight.w400,
          color: Colors.black,
        ),
        const KVerticalSpace(),
        const KMyText(
          'We have got your back...',
          color: accentColor,
          size: 18,
          weight: FontWeight.bold,
        ),
        const KVerticalSpace(height: 30),
        KCustomButton(
          onTap: onCreateTeam,
          color: accentColor,
          child: const KMyText('Create Team', color: Colors.white),
        ),
        const KVerticalSpace(height: 30),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: accentColor.withOpacity(0.3),
              border: Border.all(color: Colors.white)),
          child: Column(
            children: [
              KTextField(
                controller: teamCodeController,
                hintText: 'Enter team code',
                color: Colors.white70,
              ),
              const SizedBox(height: 10),
              KCustomButton(
                onTap: () => FirebaseServices().joinTeam(
                  teamCode: teamCodeController.text,
                ),
                color: accentColor,
                child: const KMyText('Join Team', color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}
