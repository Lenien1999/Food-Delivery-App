import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/auth_model.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/authcontroller.dart';
import 'package:food_delivery_app/core/fire_cloud/db_controller/user_controller.dart';
import 'package:get/get.dart';
 

mixin UserDataMixin<T extends StatefulWidget> on State<T> {
  final AuthController controller = Get.find<AuthController>();
  UserModel? userdata;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    if (controller.fireBaseUser.value != null) {
      await _fetchUserData(controller.fireBaseUser.value!.uid);
    } else {
      // Handle the case where fireBaseUser is null
      print("Firebase user is null");
    }
  }

  Future<void> _fetchUserData(String userId) async {
    try {
      FirebaseMethods firebaseMethods = FirebaseMethods();
      UserModel? userData = await firebaseMethods.getUserData(userId); // Ensure correct method name
      setState(() {
        userdata = userData;
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}
