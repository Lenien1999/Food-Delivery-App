import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/auth_model.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/authcontroller.dart';
import 'package:food_delivery_app/core/fire_cloud/db_controller/user_controller.dart';
import 'package:food_delivery_app/core/widgets/app_extension.dart';
import 'package:food_delivery_app/core/utils/colors.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: AppColor.orange,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          title: Text(
            'Profile',
            style: appStyle(
              size: 18,
              color: Colors.white,
              fw: FontWeight.w500,
            ),
          ),
        ),
        body: StreamBuilder<UserModel?>(
            stream: FirebaseMethods()
                .userStream(controller.fireBaseUser.value!.uid),
            builder: (BuildContext context, snapshot) {
              UserModel? userData = snapshot.data;

              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(14.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.32,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(64),
                                  child: Image.asset(
                                    'assets/images/real/pizza4.jpg',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const Positioned(
                                    bottom: 0,
                                    right: 2,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 23,
                                        backgroundColor: AppColor.orange,
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              userData!.fullName,
                              style: appStyle(
                                size: 18,
                                color: AppColor.orange,
                                fw: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              userData.email,
                              style: appStyle(
                                size: 18,
                                color: AppColor.primary,
                                fw: FontWeight.w500,
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(246, 247, 249, 1),
                          borderRadius: BorderRadius.circular(23)),
                      padding: const EdgeInsets.all(17),
                      child: Text(
                        'General',
                        style: appStyle(
                          size: 18,
                          color: AppColor.orange,
                          fw: FontWeight.w500,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        buildContainer('Change Password', Icons.lock),
                        buildContainer('App Language', Icons.language),
                        buildContainer('Favourite Service',
                            Icons.favorite_border_outlined),
                        buildContainer('Rate Us', Icons.star),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppColor.orange,
                            borderRadius: BorderRadius.circular(12)),
                        child: TextButton(
                          onPressed: () async {
                            await controller.logout();
                          },
                          child: Text(
                            'Logout',
                            style: appStyle(
                              size: 18,
                              color: Colors.white,
                              fw: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }

  buildContainer(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColor.primary,
                size: 20,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                title,
                style: appStyle(
                  size: 18,
                  color: AppColor.primary,
                  fw: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios_outlined,
            color: AppColor.primary,
          )
        ],
      ),
    );
  }
}
