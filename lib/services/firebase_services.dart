import 'package:co_task_hub/controller/get_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseServices {
  final MyController _myCtrl = Get.put(MyController());
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
        _myCtrl.userName.value = name;
        _myCtrl.userEMail.value = email;
        _myCtrl.box.write('email', email);
        _myCtrl.box.write('name', name);
      });
    } else {}

    return userCredential.user != null ? true : false;
  }

  // Login (Fetch user's email & password)
  Future<bool> loginUser(
      {required String email, required String password}) async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      _myCtrl.userEMail.value = userCredential.user!.email!;
      _myCtrl.userName.value = userCredential.user!.displayName!;
      _myCtrl.box.write('name', userCredential.user?.displayName);
    }

    return userCredential.user != null ? true : false;
  }
}
