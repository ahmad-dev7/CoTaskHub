import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_custom_button.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_textfield.dart';
import 'package:co_task_hub/screens/home_screen.dart';
import 'package:co_task_hub/screens/login_screen.dart';
import 'package:co_task_hub/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool gettingData = false;
  @override
  Widget build(BuildContext context) {
    onSignup() {
      setState(() => gettingData = true);
      FirebaseServices()
          .createUser(
        email: emailController.text.trim().toLowerCase(),
        password: passwordController.text,
        name: nameController.text,
      )
          .then(
        (value) {
          Get.snackbar(
            "Success",
            "Account created!",
            duration: const Duration(milliseconds: 1300),
            backgroundColor: Colors.greenAccent,
          );
          Future.delayed(const Duration(milliseconds: 1600)).then((value) {
            setState(() => gettingData = false);
            Get.offAll(
              () => const HomeScreen(),
            );
          });
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: KHorizontalPadding(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center vertically
                children: [
                  const KVerticalSpace(),
                  const KMyText('Signup', size: 25),
                  const KVerticalSpace(),
                  KTextField(
                    controller: nameController,
                    hintText: 'Enter your name',
                    iconData: Icons.person,
                    keyboardType: TextInputType.name,
                    capitalization: TextCapitalization.words,
                  ),
                  const KVerticalSpace(),
                  KTextField(
                    controller: emailController,
                    hintText: 'Enter your email',
                    iconData: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const KVerticalSpace(),
                  KTextField(
                    controller: passwordController,
                    hintText: 'Enter your password',
                    isPasswordField: true,
                    iconData: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const KVerticalSpace(height: 50),
                  KCustomButton(
                    onTap: onSignup,
                    child: Visibility(
                        visible: !gettingData,
                        replacement: const CircularProgressIndicator(
                            color: Colors.white),
                        child: const KMyText('Signup', color: Colors.white)),
                  ),
                  const KVerticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const KMyText(
                        'Don\'t have an account?',
                        color: Colors.grey,
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => const LoginScreen()),
                        child: const KMyText(
                          'Login',
                          color: accentColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
