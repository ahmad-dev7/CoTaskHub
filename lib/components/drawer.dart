import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_confirmation_dialog.dart';
import 'package:co_task_hub/constants/k_custom_button.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/model/team_data_model.dart';
import 'package:co_task_hub/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        height: double.maxFinite,
        width: MediaQuery.of(context).size.width - 100,
        color: const Color(0xFFFFFFFF),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hello there
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: KMyText(
                'Hello, ${FirebaseAuth.instance.currentUser!.displayName}',
                weight: FontWeight.w500,
                size: 18,
              ),
            ),
            // Indicators
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const KMyText(
                  'Task Indicators',
                  weight: FontWeight.bold,
                  size: 20,
                  color: accentColor,
                ),
                subtitle: Wrap(
                  direction: Axis.vertical,
                  children: [
                    const Chip(
                      avatar: Icon(
                        Icons.circle,
                        color: Colors.white,
                      ),
                      label: KMyText('Assigned to other'),
                    ),
                    Chip(
                      avatar: Icon(
                        Icons.circle,
                        color: Colors.blue[300],
                      ),
                      label: const KMyText('Assigned to You'),
                    ),
                    Chip(
                      avatar: Icon(
                        Icons.circle,
                        color: Colors.green[300],
                      ),
                      label: const KMyText('Completed'),
                    ),
                    Chip(
                      avatar: Icon(
                        Icons.circle,
                        color: Colors.red[400],
                      ),
                      label: const KMyText('Delayed'),
                    ),
                  ],
                ),
              ),
            ),
            const KVerticalSpace(),
            // Webview

            // Leave Team & Logout
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: KCustomButton(
                      color: const Color(0xFF8A342E),
                      onTap: () => kConfirmationDialog(
                          onYes: () {},
                          title: 'You want to leave?',
                          description:
                              'Are your sure you want to leave this team?'),
                      child: const KMyText('Leave Team', color: Colors.white)),
                ),
                const KVerticalSpace(height: 50),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: KCustomButton(
                      color: Colors.red,
                      onTap: () => kConfirmationDialog(
                          title: 'You want to logout',
                          description: 'Are you sure you want to logout',
                          onYes: () {
                            dataBox.clear();
                            myController.teamData.value = TeamData();
                            myController.teamData.refresh();
                            Get.to(() => const LoginScreen());
                          }),
                      child: const KMyText('Logout', color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
