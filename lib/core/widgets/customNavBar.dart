import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/state_management/food_provider.dart';
import 'package:food_delivery_app/core/utils/colors.dart';

import 'package:food_delivery_app/src/view/foods/views/food_page.dart';
import 'package:food_delivery_app/src/view/profile/view/profile_screen.dart';
import 'package:get/get.dart';

import '../../src/view/homepage/admin_home/adminhompage.dart';
import '../../src/view/homepage/screens/homepage.dart';
import '../../src/view/notification/notification_screen.dart';
import '../fire_cloud/auth/auth_controller/auth_model.dart';
import '../fire_cloud/auth/auth_controller/authcontroller.dart';
import '../fire_cloud/db_controller/user_controller.dart';

class BuildBottomNavigation extends StatefulWidget {
  const BuildBottomNavigation({super.key});

  @override
  State<BuildBottomNavigation> createState() => _BuildBottomNavigationState();
}

class _BuildBottomNavigationState extends State<BuildBottomNavigation> {
  final controller = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  UserModel? userdata;
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
      UserModel? userData = await firebaseMethods.getUerData(userId); // Corrected function name
      setState(() {
        userdata = userData;
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  

  List<Widget> customerPages = [
    const HomePage(),
    // const CafeHome(),
    const FoodHomePage(),
    const NotificationScreen(),
    const ProfilePage(),
  ];
  List<Widget> cafeteriaPages = [
    const CafeHome(),
    const FoodHomePage(),
    const NotificationScreen(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodController>(
      builder: (
        mainscreenController,
      ) {
        return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const CircleAvatar(
                  // decoration: const BoxDecoration(shape: BoxShape.circle),
                  backgroundImage: ExtendedAssetImageProvider(
                      'assets/images/virtual/vector3.png')),
            ),
            bottomNavigationBar:  
                 SafeArea(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.09),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          )
                        ],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BottomNavWidget(
                            color: mainscreenController.pageindex == 0
                                ? Colors.orange
                                : AppColor.orange,
                            icon: mainscreenController.pageindex == 0
                                ? Icons.home
                                : Icons.home_outlined,
                            tap: () {
                              mainscreenController.pageIndex(0);
                            },
                          ),
                          BottomNavWidget(
                            color: mainscreenController.pageindex == 1
                                ? Colors.orange
                                : AppColor.orange,
                            icon: mainscreenController.pageindex == 1
                                ? Icons.restaurant_menu_rounded
                                : Icons.restaurant_menu_outlined,
                            tap: () {
                              mainscreenController.pageIndex(1);
                            },
                          ),
                          BottomNavWidget(
                            color: mainscreenController.pageindex == 2
                                ? Colors.orange
                                : AppColor.orange,
                            icon: mainscreenController.pageindex == 2
                                ? Icons.favorite
                                : Icons.favorite_border,
                            tap: () {
                              mainscreenController.pageIndex(2);
                            },
                          ),
                          BottomNavWidget(
                            color: mainscreenController.pageindex == 3
                                ? Colors.orange
                                : AppColor.orange,
                            icon: mainscreenController.pageindex == 3
                                ? Icons.person
                                : Icons.person_outline,
                            tap: () {
                              mainscreenController.pageIndex(3);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
            body: _buildSelectedPage(mainscreenController.pageindex));
      },
    );
  }

  Widget _buildSelectedPage(int pageIndex) {
    if (userdata != null &&
        (userdata!.email.contains('cafeteria'))) {
      return cafeteriaPages[pageIndex];
    } else {
      return customerPages[pageIndex];
    }
  }
}

class BottomNavWidget extends StatelessWidget {
  final void Function()? tap;
  final IconData icon;
  final Color color;

  const BottomNavWidget(
      {super.key, this.tap, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: SizedBox(
        height: 42,
        width: 36,
        child: Icon(icon, color: color),
      ),
    );
  }
}
