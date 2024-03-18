import 'package:co_task_hub/constants/k_custom_button.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_textfield.dart';
import 'package:co_task_hub/screens/navigation_screen.dart';
import 'package:co_task_hub/screens/signup_screen.dart';
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
      debugPrint('executed Login');
      bool isValidUser = await FirebaseServices().loginUser(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      if (isValidUser) {
        Get.offAll(() => const NavigationScreen());
      } else {
        Get.snackbar('Error', 'Fill email & password fields correctly');
      }
    }

    return Scaffold(
      body: KHorizontalPadding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email Textfield
            KTextField(
              controller: emailController,
              hintText: 'Enter your email',
              iconData: Icons.email,
            ),
            const KVerticalSpace(),
            // Password TextField
            KTextField(
              controller: passwordController,
              hintText: 'Enter your password',
              isPasswordField: true,
              iconData: Icons.lock,
            ),
            const KVerticalSpace(height: 40),
            // Login button
            KCustomButton(onTap: onLogin, child: const KMyText('Login')),
            const KVerticalSpace(),
            TextButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                child: const KMyText('Signup', color: Colors.blue))
          ],
        ),
      ),
    );
  }
}
