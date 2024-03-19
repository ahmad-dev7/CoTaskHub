import 'package:co_task_hub/components/add_task.dart';
import 'package:co_task_hub/components/welcome_intro.dart';
import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_values.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:flutter/material.dart';

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
        child: SingleChildScrollView(
          child: Visibility(
            visible: myController.teamData.value.teamCode != null,
            replacement: const WelcomeIntro(),
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
                      //  TODO: Add filter options here
                      const Icon(Icons.filter_list_sharp),
                      //  TODO: Add Create Task Method
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            isDismissible: false,
                            useSafeArea: true,
                            builder: (context) {
                              return const CreateTask();
                            },
                          );
                        },
                        child: Chip(
                          backgroundColor: accentColor.withBlue(200),
                          label: const KMyText(
                            'Create Task',
                            color: Colors.white,
                          ),
                          onDeleted: () => '',
                          deleteIcon: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
