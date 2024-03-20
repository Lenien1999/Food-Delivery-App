import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/utils/fade_animation.dart';

extension WidgetExtension on Widget {
  Widget fadeAnimation(double delay) {
    return FadeAnimation(delay: delay, child: this);
  }
}

TextStyle appStyle(
    {required Color color, required double size, required FontWeight fw}) {
  return TextStyle(
    color: color,fontSize: size, fontWeight: fw,
  );
}
