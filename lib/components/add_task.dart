import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_custom_button.dart';
import 'package:co_task_hub/constants/k_custom_dropdown.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_format_date.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_textfield.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  List<String> members = [];
  String assignTo = '';
  DateTime? dueDate;
  @override
  void initState() {
    super.initState();
    getMembers();
  }

  getMembers() {
    for (var memberName in myController.teamData.value.members!) {
      members.add(memberName.name!);
    }
    setState(() => members);
  }

  @override
  void dispose() {
    members.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        height: 375,
        decoration: const BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: KHorizontalPadding(
          child: Column(
            children: [
              const KVerticalSpace(),
              const KMyText(
                'Create Task',
                weight: FontWeight.bold,
                size: 18,
              ),
              const KVerticalSpace(height: 10),
              KTextField(
                controller: titleController,
                hintText: 'Enter task title',
                iconData: Icons.title,
                capitalization: TextCapitalization.words,
              ),
              const KVerticalSpace(height: 10),
              KTextField(
                controller: descriptionController,
                hintText: 'Enter task description',
                iconData: Icons.description_outlined,
                maxLines: 3,
              ),
              const KVerticalSpace(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      height: 50,
                      child: SelectDropdownButton(
                        buttonHint: 'Assign to',
                        itemsList: members,
                        selectedValue: assignTo == '' ? null : assignTo,
                        onSelect: (value) => setState(() => assignTo = value),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 31),
                          ),
                        ).then((value) {
                          setState(() => dueDate = value!);
                          Get.snackbar('Success', 'Task Created');
                          Get.back();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(20)),
                        height: 50,
                        child: ListTile(
                          title: KMyText(
                            dueDate == null
                                ? 'Due date'
                                : kFormatDate(dueDate!),
                            size: 14,
                          ),
                          trailing:
                              const Icon(Icons.date_range, color: accentColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const KVerticalSpace(),
              KCustomButton(
                child: const KMyText('Create Task'),
                onTap: () async {
                  await FirebaseServices().addTask(
                    title: titleController.text,
                    desc: descriptionController.text,
                    dueDate: dueDate!,
                    assignedTo: assignTo,
                  );
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
