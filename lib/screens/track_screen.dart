import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_values.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class TrackProgressScreen extends StatefulWidget {
  const TrackProgressScreen({super.key});

  @override
  State<TrackProgressScreen> createState() => _TrackProgressScreenState();
}

class _TrackProgressScreenState extends State<TrackProgressScreen> {
  String activityOf = 'Team Activity';
  String activeEmail = '';
  double barWidth = 50;
  double barMaxHeight = 275;
  int selectedTab = 0;
  @override
  void initState() {
    super.initState();
  }

  int countOverDueTasks() {
    int count = 0;
    for (var task in myController.teamData.value.tasks!) {
      DateTime dueDate = DateTime.parse(task.dueDate!);
      if (dueDate.isAfter(DateTime.now())) {
        count++;
      }
    }
    return count;
  }

  int countOnTimeTask() {
    int count = 0;
    for (var task in myController.teamData.value.tasks!) {
      DateTime dueDate = DateTime.parse(task.dueDate!);
      if (dueDate.isBefore(DateTime.now()) && task.isCompleted == false) {
        count++;
      }
    }
    return count;
  }

  int countCompletedTasks() {
    int count = 0;
    for (var task in myController.teamData.value.tasks!) {
      if (task.isCompleted!) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const KVerticalSpace(),
            const KHorizontalPadding(
              child: KMyText('Track Activities',
                  weight: FontWeight.bold, size: 17),
            ),
            const KVerticalSpace(height: 15),
            const KVerticalSpace(),
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListView.builder(
                  itemCount: myController.teamData.value.members!.length + 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () => setState(() => selectedTab = index),
                        child: Chip(
                          label: KMyText(
                            index == 0
                                ? activityOf
                                : myController
                                    .teamData.value.members![index - 1].name!,
                            weight: FontWeight.bold,
                            color: selectedTab == index
                                ? backgroundColor
                                : accentColor,
                          ),
                          backgroundColor:
                              selectedTab == index ? accentColor : cardColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const KVerticalSpace(),
            if (myController.teamData.value.tasks != null)
              KHorizontalPadding(
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  padding: const EdgeInsets.only(bottom: 10),
                  height: 350,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (var i = 0; i < 4; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: barWidth,
                              alignment: Alignment.center,
                              child: KMyText(getBarValues(i).toString(),
                                  weight: FontWeight.bold, size: 15),
                            ),
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              height: i == 0
                                  ? barMaxHeight
                                  : getBarValues(i) *
                                      barMaxHeight /
                                      getBarValues(0),
                              width: barWidth,
                              decoration: BoxDecoration(
                                color: getBarColor(i),
                                borderRadius: BorderRadius.circular(radius),
                              ),
                            ),
                            const SizedBox(height: 5),
                            KMyText(getBarTitle(i), weight: FontWeight.w500)
                          ],
                        ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  getBarColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue[300];
      case 1:
        return Colors.green[300];
      case 2:
        return Colors.yellow[300];
      case 3:
        return Colors.red[300];
    }
  }

  getBarValues(int index) {
    int totalTask = myController.teamData.value.tasks!.length;
    int completedTask = countCompletedTasks();
    int remainingTask = countOnTimeTask();
    int overDueTask = countOverDueTasks();
    switch (index) {
      // Total Task
      case 0:
        return totalTask;
      // Task Completed
      case 1:
        return completedTask;
      // Task on Time
      case 2:
        return remainingTask;
      case 3:
        return overDueTask;
    }
  }

  getBarTitle(int index) {
    switch (index) {
      case 0:
        return activityOf == 'Team Activity'
            ? 'Task\ncreated'
            : 'Task\nAssigned';
      case 1:
        return 'Task\ncompleted';
      case 2:
        return 'Task in\nprogress';
      case 3:
        return 'Task\noverdue';
    }
  }

  getTaskData(int index) {
    if (activityOf == 'Team Activity') {}
  }
}
