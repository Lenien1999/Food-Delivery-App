import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/authexception.dart';
import 'package:food_delivery_app/core/widgets/customNavBar.dart';
import 'package:food_delivery_app/src/view/into_screen/onboard.dart';
import 'package:get/get.dart';

import 'auth_model.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> fireBaseUser;
  var verificationId = ''.obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onReady() async {
    Future.delayed(const Duration(seconds: 6));

    fireBaseUser = Rx<User?>(_auth.currentUser);
    fireBaseUser.bindStream(_auth.userChanges());
    ever(fireBaseUser, setInitialScreen);
  }

  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const OnBoardScreen())
        : Get.offAll(() => const BuildBottomNavigation());
  }

  Future<void> registerUser(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (fireBaseUser.value != null) {
        Get.offAll(() => const BuildBottomNavigation());
      } else {
        Get.to(() => const OnBoardScreen());
      }
    } on FirebaseAuthException catch (e) {
      final error = SignandLoginFailure.code(e.code);
      error.showSnackbar();
    } catch (_) {
      const error = SignandLoginFailure('An unknown error has occurred.');
      error.showSnackbar();
    }
  }

  Future<void> signInUser(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // If sign-in is successful, navigate to the appropriate screen
      if (_auth.currentUser != null) {
        Get.offAll(() => const BuildBottomNavigation());
      } else {
        Get.to(() => const OnBoardScreen());
      }
    } on FirebaseAuthException catch (e) {
      // Display error message using snackbar
      Get.snackbar("Error", e.message ?? "An error occurred",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    } catch (_) {
      // Handle generic errors
      const error = SignandLoginFailure('An unknown error has occurred.');
      error.showSnackbar();
    }
  }

  // Future<void> signInUser(
  //     {required String email, required String password}) async {
  //   try {
  //     _auth.signInWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     final error = SignandLoginFailure.code(e.code);
  //     Get.snackbar("Error", error.failure,
  //         snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
  //   } catch (_) {
  //     const error = SignandLoginFailure();
  //     Get.snackbar("Error", error.failure,
  //         snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
  //   }
  // }

  Future<void> resetPassword(String email, BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const CircularProgressIndicator());
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", 'Password Reset Email Sent',
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.green);
      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      Get.back();
    }
  }

  Future<UserModel?> getCurrentUserData() async {
    final currentUser = fireBaseUser.value;
    if (currentUser != null) {
      final userDoc = await _db.collection('users').doc(currentUser.uid).get();
      if (userDoc.exists) {
        return UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      }
    }
    return null;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
