import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_custom_button.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_textfield.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/screens/home_screen.dart';
import 'package:co_task_hub/screens/navigation_screen.dart';
import 'package:co_task_hub/screens/signup_screen.dart';
import 'package:co_task_hub/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool gettingData = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  onLogin() async {
    setState(() => gettingData = true);
    dataBox.clear();
    debugPrint('executed Login');
    bool isValidUser = await FirebaseServices().loginUser(
      email: emailController.text.trim().toLowerCase(),
      password: passwordController.text,
    );
    if (isValidUser) {
      Get.snackbar(
        "Success",
        "Authentication completed",
        duration: const Duration(milliseconds: 1300),
        backgroundColor: Colors.greenAccent,
      );
      Future.delayed(const Duration(milliseconds: 1600)).then(
        (value) {
          setState(() => gettingData = false);
          Get.offAll(
            () => myController.teamData.value.teamCode != null
                ? const NavigationScreen()
                : const HomeScreen(),
          );
        },
      );
    } else {
      Get.snackbar('Error', 'Fill email & password fields correctly');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: KHorizontalPadding(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const KVerticalSpace(),
                  const KMyText('Login', size: 25),
                  const KVerticalSpace(),
                  // Email Textfield
                  KTextField(
                    controller: emailController,
                    hintText: 'Enter your email',
                    iconData: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const KVerticalSpace(),
                  // Password TextField
                  KTextField(
                    controller: passwordController,
                    hintText: 'Enter your password',
                    isPasswordField: true,
                    iconData: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const KVerticalSpace(height: 50),
                  // Login button
                  KCustomButton(
                    onTap: onLogin,
                    child: Visibility(
                      visible: !gettingData,
                      replacement:
                          const CircularProgressIndicator(color: Colors.white),
                      child: const KMyText(
                        'Login',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const KVerticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const KMyText('Don\'t have an account?  ',
                          color: Colors.grey),
                      TextButton(
                        onPressed: () => Get.to(() => const SignupScreen()),
                        child: const KMyText(
                          'Signup',
                          color: accentColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
