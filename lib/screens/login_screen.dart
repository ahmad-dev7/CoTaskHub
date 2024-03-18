import 'package:co_task_hub/constants/k_custom_button.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_textfield.dart';
import 'package:co_task_hub/screens/home_screen.dart';
import 'package:co_task_hub/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    onLogin() async {
      bool isValidUser = await FirebaseServices().loginUser(
        email: emailController.text,
        password: passwordController.text,
      );
      if (isValidUser) {
        Get.to(() => const HomeScreen());
      } else {
        Get.snackbar('Error', 'Fill email & password fields correctly');
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Email Textfield
            KTextField(
              controller: emailController,
              hintText: 'Enter your email',
            ),
            const KVerticalSpace(),
            // Password TextField
            KTextField(
              controller: passwordController,
              hintText: 'Enter your password',
              isPasswordField: true,
            ),
            // Login button
            KCustomButton(onTap: () => onLogin, child: const KMyText('Login'))
          ],
        ),
      ),
    );
  }
}