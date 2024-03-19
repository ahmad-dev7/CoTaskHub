import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_custom_button.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_textfield.dart';
import 'package:co_task_hub/services/firebase_services.dart';
import 'package:flutter/material.dart';

class CreateTeamDialog extends StatelessWidget {
  final TextEditingController teamNameController;
  final TextEditingController projectNameController;
  final TextEditingController projectDescriptionController;
  const CreateTeamDialog({
    super.key,
    required this.teamNameController,
    required this.projectNameController,
    required this.projectDescriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      backgroundColor: backgroundColor,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        height: 400,
        width: MediaQuery.of(context).size.width - 50,
        child: Column(
          children: [
            const KMyText('Create Team', weight: FontWeight.bold),
            const KVerticalSpace(),
            KTextField(
              controller: teamNameController,
              hintText: 'Enter Team name',
              color: cardColor.withAlpha(255),
              capitalization: TextCapitalization.words,
            ),
            const KVerticalSpace(),
            KTextField(
              controller: projectNameController,
              hintText: 'Enter Project name',
              color: cardColor.withAlpha(255),
              capitalization: TextCapitalization.words,
            ),
            const KVerticalSpace(),
            KTextField(
              controller: projectDescriptionController,
              hintText: 'Enter project  description',
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              color: cardColor.withAlpha(255),
              capitalization: TextCapitalization.sentences,
            ),
            const KVerticalSpace(),
            KCustomButton(
              onTap: () => FirebaseServices()
                  .createTeam(
                teamName: teamNameController.text,
                projectName: projectNameController.text,
                projectDescription: projectDescriptionController.text,
              )
                  .then((value) {
                projectNameController.clear();
                teamNameController.clear();
                projectDescriptionController.clear();
                Navigator.pop(context);
              }),
              child: const KMyText('Create Team', color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
