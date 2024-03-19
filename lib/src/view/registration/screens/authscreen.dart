import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/authcontroller.dart';
import 'package:food_delivery_app/src/view/registration/screens/forgetPwScreen.dart';

import 'package:food_delivery_app/src/view/registration/widget/sign_login.dart';
import 'package:food_delivery_app/core/widgets/appbutton.dart';
import 'package:food_delivery_app/core/widgets/customTextInput.dart';
import 'package:get/get.dart';

import '../../../../core/fire_cloud/auth/auth_controller/auth_model.dart';
import '../../../../core/fire_cloud/db_controller/user_controller.dart';
import '../../../../core/utils/colors.dart';

import '../widget/auth_header.dart';

class AuthScreen extends StatefulWidget {
  final bool isLoginScreen;

  const AuthScreen({Key? key, required this.isLoginScreen}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  bool isVisible = false;
  final _key = GlobalKey<FormState>();
  final usercontroller = Get.put(FirebaseMethods());
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Center(
          child: Form(
            key: _key,
            child: ListView(
              shrinkWrap: true,
              children: [
                const AuthHeader(),
                if (!widget.isLoginScreen)
                  CustomTextInput(
                    hintText: "Full Name",
                    prefixIcon: Icons.person,
                    controller: fullNameController,
                  ),
                const SizedBox(height: 20),
                CustomTextInput(
                  hintText: "Your email",
                  prefixIcon: Icons.email,
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                CustomTextInput(
                  controller: passwordController,
                  hintText: "Password",
                  visible: !isVisible,
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: Icon(isVisible
                        ? Icons.remove_red_eye
                        : Icons.visibility_off),
                  ),
                ),
                const SizedBox(height: 20),
                if (!widget.isLoginScreen)
                  CustomTextInput(
                    hintText: "Phone Number",
                    prefixIcon: Icons.phone_callback_rounded,
                    controller: phoneNumber,
                  ),
                widget.isLoginScreen
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.offAll(() => const ForgetPwScreen());
                          },
                          child: const Text("Forget your password?"),
                        ),
                      )
                    : Container(),
                const SizedBox(height: 20),
                AppButton(
                  title: widget.isLoginScreen ? 'Login' : 'Sign Up',
                  tap: () async {
                    if (_key.currentState!.validate()) {
                      if (widget.isLoginScreen) {
                        // Login user
                        await controller.signInUser(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      } else {
                        // Register user
                        await controller.registerUser(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        // Check if user registration is successful
                        if (controller.fireBaseUser.value != null) {
                          final user = UserModel(
                            id: controller.fireBaseUser.value!.uid,
                            fullName: fullNameController.text,
                            email: emailController.text,
                            phoneNo: phoneNumber
                                .text, // Fixed inconsistency in variable name
                            password: passwordController.text,
                          );

                          // Store additional user information in Firestore using userController
                          await Get.find<FirebaseMethods>().addUserData(
                              user); // Assuming userController is the instance of UserController

                          Get.snackbar(
                            'Success',
                            'Your account has been created',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green.withOpacity(0.1),
                            colorText: Colors.green,
                          );
                        } else {
                          // Handle registration error
                          Get.snackbar(
                            'Error',
                            'Failed to create your account',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red.withOpacity(0.1),
                            colorText: Colors.red,
                          );
                        }
                      }
                    }
                  },
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => widget.isLoginScreen
                          ? const LoginScreen()
                          : const SignUpScreen());
                    },
                    child: InkWell(
                      onTap: () {
                        widget.isLoginScreen
                            ? Get.to(() => const SignUpScreen())
                            : Get.to(() => const LoginScreen());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: widget.isLoginScreen
                              ? "Don't have an account?"
                              : 'Already have an account?',
                          style: const TextStyle(
                            color: AppColor.placeholder,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: widget.isLoginScreen
                                  ? ' Sign Up'
                                  : ' Sign in ',
                              style: const TextStyle(
                                color: AppColor.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
