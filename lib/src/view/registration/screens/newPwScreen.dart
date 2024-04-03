// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/view/registration/widget/sign_login.dart';
import 'package:food_delivery_app/core/utils/helpers.dart';
import 'package:food_delivery_app/core/widgets/customTextInput.dart';
import 'package:get/get.dart';
 
import '../../../../core/widgets/appbutton.dart';
import '../widget/auth_header.dart';

class NewPwScreen extends StatelessWidget {
  static const routeName = "/newPw";

  const NewPwScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final password = TextEditingController();
    final newpassword = TextEditingController();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ListView(
            shrinkWrap: true,
            children: [
              const AuthHeader(),
              Text(
                "New Password",
                style: Helper.getTheme(context).titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Please enter your email to recieve a link to create a new password via email",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextInput(
                hintText: "New Password",
                prefixIcon: Icons.lock,
                controller: password,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextInput(
                hintText: "Confirm Password",
                prefixIcon: Icons.lock,
                controller: newpassword,
              ),
              const SizedBox(
                height: 15,
              ),
              AppButton(
                title: 'Next',
                tap: () {
                  Get.to(()=>const LoginScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
