import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_values.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/model/team_data_model.dart';
import 'package:co_task_hub/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

final fireStore = FirebaseFirestore.instance;

class TaskStreamBuilder extends StatelessWidget {
  const TaskStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fireStore
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
                    height: 175,
                    margin: const EdgeInsets.only(
                      left: 10,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                        color: cardColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(radius)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListTile(
                          minVerticalPadding: 10,
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200,
                                child: ListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 5),
                                  title: RichText(
                                    text: TextSpan(
                                        text: 'Assigned to: ',
                                        style: const TextStyle(
                                            color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: teamData[0]
                                                  .tasks![index]
                                                  .assignedTo,
                                              style: const TextStyle(
                                                  color: accentColor,
                                                  fontWeight: FontWeight.bold))
                                        ]),
                                  ),
                                  subtitle: RichText(
                                      text: TextSpan(
                                          text: 'Due Date: ',
                                          style: const TextStyle(
                                              color: Colors.black),
                                          children: [
                                        TextSpan(
                                            text: formatDate(teamData[0]
                                                .tasks![index]
                                                .dueDate!),
                                            style: const TextStyle(
                                              color: accentColor,
                                              fontWeight: FontWeight.w500,
                                            ))
                                      ])),
                                ),
                              ),
                              if (teamData[0].tasks![index].assignedTo ==
                                      dataBox.get('name') &&
                                  teamData[0].tasks![index].isCompleted ==
                                      false)
                                InkWell(
                                  onTap: () => FirebaseServices()
                                      .markAsCompleted(index: index),
                                  child: const Chip(
                                    backgroundColor: backgroundColor,
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
    );
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  getIndicatorColor(Task task) {
    DateTime dueDate = DateTime.parse(task.dueDate!);
    if (task.isCompleted!) {
      return Colors.green;
    } else if (task.assignedTo == dataBox.get('name')) {
      return Colors.blue;
    } else if (dueDate.isAfter(DateTime.now())) {
      return Colors.red;
    } else {
      return Colors.grey[300];
    }
  }
}
