import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/utils/colors.dart';

import '../../../../core/utils/helpers.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          Helper.getAssetName('tech-logo.png', 'virtual'),
          width: Helper.getScreenWidth(context) * 0.5,
        ),
        const SizedBox(height: 30),
        RichText(
          text: const TextSpan(
            text: 'TECH-U',
            style: TextStyle(
              color: AppColor.orange,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
            children: [
              TextSpan(
                text: '  CAFETERIA ',
                style: TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 13),
      ],
    );
  }
}
