import 'package:co_task_hub/components/multi_task.dart';
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
  final dynamic data;
  const MyDrawer({super.key, this.data});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: double.maxFinite,
      width: MediaQuery.of(context).size.width - 100,
      color: cardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hello there
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Wrap(
              children: [
                KMyText(
                  'Hello, ${FirebaseAuth.instance.currentUser!.displayName}',
                  weight: FontWeight.w500,
                  color: Colors.black,
                  size: 18,
                ),
                const Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Divider(color: accentColor, thickness: 1),
                )),
              ],
            ),
          ),
          // Indicators
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                  Chip(
                    backgroundColor: accentColor.withOpacity(.4),
                    avatar: const Icon(
                      Icons.circle,
                      color: Colors.white,
                    ),
                    label: const KMyText('Assigned to other'),
                  ),
                  Chip(
                    backgroundColor: accentColor.withOpacity(.4),
                    avatar: Icon(
                      Icons.circle,
                      color: Colors.blue[300],
                    ),
                    label: const KMyText('Assigned to You'),
                  ),
                  Chip(
                    backgroundColor: accentColor.withOpacity(.4),
                    avatar: Icon(
                      Icons.circle,
                      color: Colors.green[300],
                    ),
                    label: const KMyText('Completed'),
                  ),
                  Chip(
                    backgroundColor: accentColor.withOpacity(.4),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: KCustomButton(
              child: const KMyText('Create or Join team'),
              onTap: () => Get.to(
                () => const MultiTask(),
              ),
            ),
          ),
          // SizedBox(
          //   height: 100,
          //   child: ListView.builder(
          //     itemCount: 5,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Container(
          //         margin: const EdgeInsets.all(10),
          //         height: 20,
          //         color: Colors.red,
          //         child: KMyText(widget.data['myTeams'][index]['codes']),
          //       );
          //     },
          //   ),
          // ),

          // Leave Team & Logout
          Column(
            children: [
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
    );
  }
}
