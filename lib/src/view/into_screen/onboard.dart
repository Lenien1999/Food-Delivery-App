import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/utils/colors.dart';
import 'package:food_delivery_app/src/view/into_screen/introscreen.dart';
import 'package:get/get.dart';

 

import '../../../core/utils/helpers.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
       Get.offAll((const IntroScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: Helper.getScreenWidth(context),
      height: Helper.getScreenHeight(context),
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              Helper.getAssetName("splashIcon.png", "virtual"),
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Helper.getAssetName("vector2.png", "virtual"),
                ),
                RichText(
                  text: const TextSpan(
                      text: 'TECH-U',
                      style: TextStyle(
                          color: AppColor.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                      children: [
                        TextSpan(
                          text: '  CAFETERIA',
                          style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        )
                      ]),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
