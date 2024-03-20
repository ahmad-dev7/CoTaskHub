import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_custom_button.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_textfield.dart';
import 'package:co_task_hub/services/firebase_services.dart';
import 'package:flutter/material.dart';

class CreateTeamDialog extends StatefulWidget {
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
  State<CreateTeamDialog> createState() => _CreateTeamDialogState();
}

class _CreateTeamDialogState extends State<CreateTeamDialog> {
  bool gettingData = false;
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
              controller: widget.teamNameController,
              hintText: 'Enter Team name',
              color: cardColor.withAlpha(255),
              capitalization: TextCapitalization.words,
            ),
            const KVerticalSpace(),
            KTextField(
              controller: widget.projectNameController,
              hintText: 'Enter Project name',
              color: cardColor.withAlpha(255),
              capitalization: TextCapitalization.words,
            ),
            const KVerticalSpace(),
            KTextField(
              controller: widget.projectDescriptionController,
              hintText: 'Enter project  description',
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              color: cardColor.withAlpha(255),
              capitalization: TextCapitalization.sentences,
            ),
            const KVerticalSpace(),
            KCustomButton(
              onTap: () async {
                setState(() {
                  gettingData = true;
                });
                await FirebaseServices().createTeam(
                  teamName: widget.teamNameController.text,
                  projectName: widget.projectNameController.text,
                  projectDescription: widget.projectDescriptionController.text,
                );
                widget.projectNameController.clear();
                widget.teamNameController.clear();
                widget.projectDescriptionController.clear();
                setState(() {
                  gettingData = false;
                });

                Navigator.pop(context);
              },
              child: Visibility(
                  visible: !gettingData,
                  replacement: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  child: const KMyText('Create Team', color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
