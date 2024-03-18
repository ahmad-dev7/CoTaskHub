import 'package:co_task_hub/controller/get_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;

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
}
