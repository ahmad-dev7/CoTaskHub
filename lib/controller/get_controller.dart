import 'package:co_task_hub/model/team_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box dataBox;
late MyController myController;
var isAdmin = (FirebaseAuth.instance.currentUser!.email ==
    myController.teamData.value.adminEmail);

class MyController extends GetxController {
  var teamData = TeamData().obs;
  var assignTo = ''.obs;
}
