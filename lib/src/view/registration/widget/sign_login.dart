import 'package:flutter/material.dart';

import '../screens/authscreen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/loginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AuthScreen(isLoginScreen: true);
  }
}

class SignUpScreen extends StatelessWidget {


  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AuthScreen(isLoginScreen: false);
  }
}
