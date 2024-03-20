import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_task_hub/components/add_task.dart';
import 'package:co_task_hub/components/welcome_intro.dart';
import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_values.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/model/team_data_model.dart';
import 'package:co_task_hub/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _fireStore = FirebaseFirestore.instance;

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
                            onDeleted: () => '',
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
                StreamBuilder(
                  stream: _fireStore
                      .collection('teams')
                      .where(
                        'teamCode',
                        isEqualTo: myController.teamData.value.teamCode,
                      )
                      .snapshots(includeMetadataChanges: true),
                  initialData: const KMyText('Loading tasks'),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    List<TeamData> teamData = [];

                    if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      final List<DocumentSnapshot> documents =
                          snapshot.data?.docs.reversed.toList();

                      for (DocumentSnapshot document in documents) {
                        final Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        teamData.add(TeamData.fromJson(data));
                      }

                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 215,
                        width: double.maxFinite,
                        child: ListView.builder(
                          itemCount: teamData[0].tasks!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TimelineTile(
                              isFirst: index == 0,
                              isLast: index == teamData[0].tasks!.length - 1,
                              beforeLineStyle: const LineStyle(
                                color: accentColor,
                              ),
                              indicatorStyle: IndicatorStyle(
                                color: getIndicatorColor(
                                  teamData[0].tasks![index],
                                ),
                              ),
                              endChild: Container(
                                height: 150,
                                margin: const EdgeInsets.only(
                                  left: 10,
                                  bottom: 20,
                                ),
                                decoration: BoxDecoration(
                                    color: cardColor.withOpacity(0.5),
                                    borderRadius:
                                        BorderRadius.circular(radius)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ListTile(
                                      minVerticalPadding: 10,
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: KMyText(
                                          teamData[0].tasks![index].taskTitle!,
                                          size: 18,
                                          weight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: KMyText(
                                        teamData[0].tasks![index].taskDesc!,
                                      ),
                                    ),
                                    const KVerticalSpace(height: 10),
                                    if (teamData[0].tasks![index].assignedTo ==
                                            dataBox.get('name') &&
                                        teamData[0].tasks![index].isCompleted ==
                                            false)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Spacer(),
                                            InkWell(
                                              onTap: () => FirebaseServices()
                                                  .markAsCompleted(
                                                      index: index),
                                              child: const Chip(
                                                backgroundColor:
                                                    backgroundColor,
                                                label: Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const KMyText('No task created yet');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getIndicatorColor(Task task) {
    DateTime dueDate = DateTime.parse(task.dueDate!);
    if (task.isCompleted!) {
      return Colors.green;
    } else if (task.assignedTo == dataBox.get('name')) {
      return Colors.blue;
    } else if (dueDate.isBefore(DateTime.now())) {
      return Colors.red;
    } else {
      return Colors.grey[300];
    }
  }
}
