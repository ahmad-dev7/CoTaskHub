import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_custom_button.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_values.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/model/team_data_model.dart';
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

  @override
  void initState() {
    super.initState();
  }

  int countOverDueTasks() {
    if (myController.teamData.value.tasks != null) {
      List<Task> overDueTasks = myController.teamData.value.tasks!
          .where(
              (task) => DateTime.parse(task.dueDate!).isBefore(DateTime.now()))
          .toList();

      return overDueTasks.length;
    } else {
      return 0;
    }
  }

  int countOnTimeTask() {
    return myController.teamData.value.tasks!.length - countOverDueTasks() + 1;
  }

  int countCompletedTasks() {
    if (myController.teamData.value.tasks != null) {
      List<Task> completedTasks = myController.teamData.value.tasks!
          .where((task) => task.isCompleted == true)
          .toList();

      return completedTasks.length;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      body: KHorizontalPadding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const KVerticalSpace(),
              const KMyText('Track Activities',
                  weight: FontWeight.bold, size: 17),
              const KVerticalSpace(height: 40),
              SizedBox(
                height: 70 *
                    double.parse(
                      myController.teamData.value.members!.length.toString(),
                    ),
                child: ListView.builder(
                  itemCount: myController.teamData.value.members!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: KCustomButton(
                        color: accentColor.withOpacity(.6),
                        child: KMyText(
                          myController.teamData.value.members![index].name!,
                          color: Colors.white,
                        ),
                        onTap: () {
                          setState(() {
                            activityOf =
                                "${myController.teamData.value.members![index].name!}'s  Activity";
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              Chip(
                  label: KMyText(
                    activityOf,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  backgroundColor: accentColor),
              const KVerticalSpace(),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                padding: const EdgeInsets.only(bottom: 10),
                height: 300,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: KMyText(getBarValues(i).toString(),
                                weight: FontWeight.bold, size: 15),
                          ),
                          Container(
                            height: i == 0
                                ? 220
                                : getBarValues(i) * 220 / getBarValues(0),
                            width: 50,
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
              )
            ],
          ),
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
    int remainingTask = completedTask - countOnTimeTask();
    int overDueTask = totalTask - (completedTask + remainingTask);
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
        return 'Task\ncreated';
      case 1:
        return 'Task\ncompleted';
      case 2:
        return 'Task\nonTime';
      case 3:
        return 'Task\noverdue';
    }
  }

  getTaskData(int index) {
    if (activityOf == 'Team Activity') {}
  }
}
