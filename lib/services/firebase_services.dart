import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_task_hub/constants/k_generate_code.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/model/team_data_model.dart';
import 'package:co_task_hub/screens/navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference teamCollection =
      FirebaseFirestore.instance.collection('teams');

  // Signup (Create User) with email & password
  Future<bool> createUser(
      {required String email,
      required String password,
      required String name}) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      userCredential.user?.updateDisplayName(name).then((_) {
        dataBox.put('email', email);
        dataBox.put('name', name);
      });
      return true;
    } else {
      return false;
    }
  }

  // Login (Fetch user's email & password)
  Future<bool> loginUser(
      {required String email, required String password}) async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      dataBox.put('name', userCredential.user!.displayName!);
      dataBox.put('email', email);
    }
    myController.teamData.value = await getTeamDetails();
    await Future.delayed(const Duration(milliseconds: 100));
    return userCredential.user != null ? true : false;
  }

  // Create Team
  Future createTeam({
    required String teamName,
    required String projectName,
    required String projectDescription,
  }) async {
    String teamCode = generateTeamCode();
    await teamCollection.add({
      'teamName': teamName,
      'projectName': projectName,
      'projectDescription': projectDescription,
      'teamCode': teamCode,
      'adminName': dataBox.get('name'),
      'adminEmail': dataBox.get('email'),
      'members': [
        {
          'name': dataBox.get('name'),
          'email': dataBox.get('email'),
        }
      ],
    });
    dataBox.put('teamCode', teamCode);
    myController.teamData.value = await getTeamDetails();
    myController.teamData.refresh();
    print("Created team name ${myController.teamData.value.teamName!}");
    return;
  }

  // Join Team
  Future joinTeam({required String teamCode}) async {
    var name = dataBox.get('name');
    var email = dataBox.get('email');
    QuerySnapshot querySnapshot = await teamCollection
        .where(Filter('teamCode', isEqualTo: teamCode))
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot teamDoc = querySnapshot.docs.first;
      List<dynamic> currentMembers = teamDoc['members'];
      currentMembers.add({
        'name': name,
        'email': email,
      });
      await teamDoc.reference.update({'members': currentMembers});
      dataBox.put('teamCode', teamCode);
      myController.teamData.value = await getTeamDetails();
      myController.teamData.refresh();
      Get.offAll(() => const NavigationScreen());
    }
  }

  // Fetch Team  Details
  Future getTeamDetails() async {
    QuerySnapshot querySnapshot = await teamCollection
        .where(Filter('members', arrayContains: {
          'name': dataBox.get('name'),
          'email': dataBox.get('email')
        }))
        .get();

    List<Map<String, dynamic>> teamData = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    TeamData myTeamData = TeamData.fromJson(teamData[0]);

    return myTeamData;
  }

  Future leaveTeam() async {}
}
