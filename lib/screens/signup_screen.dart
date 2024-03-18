import 'package:co_task_hub/constants/k_custom_button.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_textfield.dart';
import 'package:co_task_hub/screens/login_screen.dart';
import 'package:co_task_hub/screens/navigation_screen.dart';
import 'package:co_task_hub/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    onSignup() {
      FirebaseServices()
          .createUser(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
          )
          .then(
            (value) => Get.to(() => const NavigationScreen()),
          );
    }

    return Scaffold(
      body: KHorizontalPadding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            KTextField(
              controller: nameController,
              hintText: 'Enter your name',
            ),
            const KVerticalSpace(),
            KTextField(
              controller: emailController,
              hintText: 'Enter your email',
            ),
            const KVerticalSpace(),
            KTextField(
              controller: passwordController,
              hintText: 'Enter your password',
              isPasswordField: true,
            ),
            const KVerticalSpace(height: 30),
            KCustomButton(
              onTap: onSignup,
              child: const KMyText('Signup'),
            ),
            const KVerticalSpace(),
            TextButton(
                onPressed: () => Get.to(() => const LoginScreen()),
                child: const KMyText('Login', color: Colors.blue))
          ],
        ),
      ),
    );
  }
}
