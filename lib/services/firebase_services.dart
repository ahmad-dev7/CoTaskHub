import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_task_hub/constants/k_generate_code.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/model/team_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference teamCollection =
      FirebaseFirestore.instance.collection('teams');

  final CollectionReference chats =
      FirebaseFirestore.instance.collection('chats');

  final CollectionReference files =
      FirebaseFirestore.instance.collection('files');

  //! Signup (Create User) with email & password
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
    dataBox.put('name', userCredential.user!.displayName!);
    dataBox.put('email', email);
    await getTeamDetails();
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
      'tasks': [],
    });
    dataBox.put('teamCode', teamCode);
    Get.back();
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
      return;
    }
  }

  // Fetch Team  Details
  Future getTeamDetails() async {
    print('started  fetching team details...');
    QuerySnapshot querySnapshot =
        await teamCollection.where('members', arrayContains: {
      'name': dataBox.get('name'),
      'email': dataBox.get('email'),
    }).get();
    print("this is $querySnapshot first call");
    List<Map<String, dynamic>> teamData = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    String json = jsonEncode(teamData);
    print(json);
    print("object ${teamData[0]['members']}");
    if (teamData.isNotEmpty) {
      print("Assigning data to local variable");
      var myData = TeamData.fromJson(teamData[0]);
      myController.teamData.value = myData;
      print(myData.adminName);
    }
  }

  // Add task
  Future<void> addTask({
    required String title,
    required String desc,
    required String assignedTo,
    required DateTime dueDate,
  }) async {
    QuerySnapshot querySnapshot = await teamCollection
        .where('teamCode', isEqualTo: myController.teamData.value.teamCode!)
        .get();

    DocumentSnapshot teamDoc = querySnapshot.docs.first;
    List<dynamic> newTask = teamDoc['tasks'];
    newTask.add({
      'taskTitle': title,
      'taskDesc': desc,
      'assignedTo': assignedTo,
      'dueDate': dueDate.toString(),
      'isCompleted': false,
    });

    // Update the 'tasks' array in the Firestore document
    await teamDoc.reference.update({'tasks': newTask});

    // Optionally, update the local team data if needed
    var teamDetails = await getTeamDetails();
    if (teamDetails != null) {
      myController.teamData.value = teamDetails;
    }
  }

  // Mark Completed
  Future<void> markAsCompleted({required int index}) async {
    QuerySnapshot querySnapshot = await teamCollection
        .where('teamCode', isEqualTo: myController.teamData.value.teamCode)
        .get();
    DocumentSnapshot taskDoc = querySnapshot.docs[0];
    List<dynamic> currentTask = taskDoc['tasks'];
    currentTask[index]['isCompleted'] = true;
    await taskDoc.reference.update({'tasks': currentTask});
    myController.teamData.value = await getTeamDetails();
    myController.teamData.refresh();
  }

  // Create Message
  createMessage({required String message, bool? isUrl}) async {
    return chats.add({
      'message': message,
      'timeStamp': DateTime.now(),
      'senderEmail': dataBox.get('email'),
      'name': dataBox.get('name'),
      'isUrl': isUrl ?? false,
      'teamCode': myController.teamData.value.teamCode,
    });
  }

  // Add Documents
  Future<String> addDocuments({
    required String fileName,
    required File file,
  }) async {
    final reference =
        FirebaseStorage.instance.ref().child("files/$fileName.pdf");

    final uploadTask = reference.putFile(file);

    await uploadTask.whenComplete(() => null);

    final fileUrl = await reference.getDownloadURL();

    await files.add({
      'name': fileName,
      'url': fileUrl,
      'teamCode': myController.teamData.value.teamCode,
    });

    return fileUrl;
  }

  // Get Documents
  Future getDocuments() async {
    final result = await files
        .where(
          Filter(
            'teamCode',
            isEqualTo: dataBox.get('teamCode'),
          ),
        )
        .get();

    var filesData = result.docs.map((e) => e.data()).toList();
    print(filesData[0]);
    return filesData;
  }

  Future leaveTeam() async {}
}
