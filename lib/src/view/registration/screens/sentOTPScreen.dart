// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/view/registration/screens/forgetPwScreen.dart';
import 'package:food_delivery_app/core/utils/helpers.dart';
import 'package:get/get.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/appbutton.dart';
import '../widget/auth_header.dart';
import './newPwScreen.dart';

class SendOTPScreen extends StatelessWidget {
  const SendOTPScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: ListView(
            shrinkWrap: true,
            children: [
              const AuthHeader(),
              Text(
                'We have sent you an OTP to your Mobile',
                style: Helper.getTheme(context).bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Please check your mobile number 071*****12 continue to reset your password",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OTPInput(),
                  OTPInput(),
                  OTPInput(),
                  OTPInput(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                title: 'Next',
                tap: () {
                  Get.to(() => const NewPwScreen());
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn't Recieve? "),
                  InkWell(
                    onTap: () {
                      Get.to(() => const ForgetPwScreen());
                    },
                    child: const Text(
                      "Click Here",
                      style: TextStyle(
                        color: AppColor.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class OTPInput extends StatelessWidget {
  const OTPInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: ShapeDecoration(
        color: AppColor.placeholderBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18, left: 20),
            child: Text(
              "*",
              style: TextStyle(fontSize: 45),
            ),
          ),
          TextField(
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ],
      ),
    );
  }
}
