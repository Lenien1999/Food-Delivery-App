import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/fire_cloud/db_controller/food_controller.dart';
import 'package:food_delivery_app/core/state_management/food_provider.dart';
import 'package:food_delivery_app/firebase_options.dart';

import 'package:get/get.dart';

import 'core/fire_cloud/auth/auth_controller/authcontroller.dart';

import 'core/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register the controllers with GetX
  Get.put(AuthController());
  Get.put(FoodController());
  Get.put(FoodDbController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Change MaterialApp to GetMaterialApp
      title: 'TECH-U CAFE',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      theme: ThemeData(
        useMaterial3: true,
        // scaffoldBackgroundColor: Colors.black,
        fontFamily: "Poppins",
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.orange,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.black,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.orange,
        ),
        primaryColor: AppColor.orange,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
              color: AppColor.primary,
              fontSize: 14,
              fontWeight: FontWeight.w500),
          bodySmall: TextStyle(color: AppColor.orange),
          bodyLarge: TextStyle(color: AppColor.orange),
          displayMedium: TextStyle(color: AppColor.orange),
        ),
        hintColor: AppColor.primary,
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.black,
        ),
      ),
      home: const CircularProgressIndicator(),
    );
  }
}
