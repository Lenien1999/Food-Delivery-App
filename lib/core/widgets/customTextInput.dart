// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    required String hintText,
    EdgeInsets padding = const EdgeInsets.only(left: 20),
    Key? key,
    required this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.visible = false,
      this.validator,
  })  : _hintText = hintText,
        _padding = padding,
        super(key: key);

  final String _hintText;
  final TextEditingController controller;
  final EdgeInsets _padding;
  final IconData prefixIcon;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final bool visible;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: visible,
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 236, 241, 241),
        filled: true,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        hintText: _hintText,
        hintStyle: const TextStyle(
          color: AppColor.placeholder,
        ),
        contentPadding: _padding,
      ),
    );
  }
}
