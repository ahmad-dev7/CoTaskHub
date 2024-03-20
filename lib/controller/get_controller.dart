import 'package:co_task_hub/model/team_data_model.dart';
import 'package:co_task_hub/services/firebase_services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box dataBox;
late MyController myController;

class MyController extends GetxController {
  var teamData = TeamData().obs;
  var assignTo = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getTeamDetails();
  }

  getTeamDetails() async {
    FirebaseServices services = FirebaseServices();
    var data = await services.getTeamDetails();
    if (data != null) {
      teamData.value = data;
    }
    teamData.refresh();
  }
}
