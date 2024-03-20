import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/widgets/app_extension.dart';
 

class AppRichText extends StatelessWidget {
  const AppRichText({
    super.key,
    required this.title,
    required this.subtitle,
    required this.subColor,
  });
  final String title;
  final String subtitle;
  final Color subColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: title,
            style: appStyle(color: Colors.black, size: 18, fw: FontWeight.bold),
            children: [
          TextSpan(
            text: subtitle,
            style: appStyle(color: subColor, size: 18, fw: FontWeight.bold),
          )
        ]));
  }
}
