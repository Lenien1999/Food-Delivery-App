import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/view/registration/widget/auth_header.dart';
import 'package:food_delivery_app/core/utils/helpers.dart';
import 'package:food_delivery_app/core/widgets/customTextInput.dart';
import 'package:get/get.dart';
 

import '../../../../core/widgets/appbutton.dart';
import './sentOTPScreen.dart';

class ForgetPwScreen extends StatelessWidget {
  
  const ForgetPwScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: ListView(
            shrinkWrap: true,
            children: [
              const AuthHeader(),
              Center(
                child: Text(
                  "Reset Password",
                  style: Helper.getTheme(context).titleLarge,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextInput(
                hintText: "Enter your Email...",
                prefixIcon: Icons.email,
                controller: email,
              ),
              const SizedBox(
                height: 15,
              ),
              AppButton(
                title: 'Send',
                tap: () {
                 Get.to(()=>const SendOTPScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
