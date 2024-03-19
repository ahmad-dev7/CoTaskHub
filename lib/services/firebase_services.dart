import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    return;
  }

  // Add Team
  Future joinTeam({required String teamCode}) async {
    var name = 'Arvind Sonkar';
    var email = 'arvind@gmail.com';
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
      print('Member added successfully');
    } else {
      print('error member added failed');
    }
  }

  String generateTeamCode() {
    final Random random = Random();
    String alphabets = 'abcdefghijklmnopqrstuvwxyz';
    String numbers = '1234567890';
    String teamCode = '';
    late String alphabetCode;
    late String numCode;
    for (var i = 0; i <= 4; i++) {
      alphabetCode = String.fromCharCodes(Iterable.generate(
          4, (_) => alphabets.codeUnitAt(random.nextInt(alphabets.length))));
    }
    for (var i = 0; i <= 4; i++) {
      numCode = String.fromCharCodes(Iterable.generate(
          4, (_) => numbers.codeUnitAt(random.nextInt(numbers.length))));
    }
    teamCode = alphabetCode + numCode;
    return teamCode;
  }
}
