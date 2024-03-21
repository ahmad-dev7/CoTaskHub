import 'package:co_task_hub/components/add_task.dart';
import 'package:co_task_hub/components/task_stream_builder.dart';
import 'package:co_task_hub/components/welcome_intro.dart';
import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_values.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KHorizontalPadding(
        child: Visibility(
          visible: myController.teamData.value.teamCode != null,
          replacement: const Center(
            child: SingleChildScrollView(child: WelcomeIntro()),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const KVerticalSpace(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(radius)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => FirebaseServices().getTeamDetails(),
                        icon: const Icon(Icons.filter_list_sharp),
                      ),
                      Visibility(
                        visible: myController.teamData.value.adminEmail ==
                            dataBox.get('email'),
                        replacement: const Chip(
                          label: KMyText('Keep Working'),
                          backgroundColor: accentColor,
                        ),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              isDismissible: false,
                              useSafeArea: true,
                              builder: (context) {
                                return const CreateTask();
                              },
                            ).whenComplete(
                              () => Get.snackbar('Success', 'Task created',
                                  backgroundColor: const Color(0x944CAF4F)),
                            );
                          },
                          child: Chip(
                            backgroundColor: accentColor.withBlue(200),
                            label: const KMyText(
                              'Create Task',
                              color: Colors.white,
                            ),
                            onDeleted: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                isDismissible: false,
                                useSafeArea: true,
                                builder: (context) {
                                  return const CreateTask();
                                },
                              ).whenComplete(
                                () => Get.snackbar('Success', 'Task created',
                                    backgroundColor: const Color(0x944CAF4F)),
                              );
                            },
                            deleteIcon: const Icon(
                              Icons.add_circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const KVerticalSpace(),
                const TaskStreamBuilder()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
