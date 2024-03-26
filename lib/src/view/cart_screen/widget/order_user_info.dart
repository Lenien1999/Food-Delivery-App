 
import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/auth_model.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/authcontroller.dart';
import 'package:food_delivery_app/core/fire_cloud/db_controller/user_controller.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/app_extension.dart';

class OrderUserInfo extends StatelessWidget {
  final String cafe;
  const OrderUserInfo({
    super.key, required this.cafe,
  });

  @override
  Widget build(BuildContext context) {
 
    final controller = Get.put(AuthController());

    return StreamBuilder<UserModel?>(
        stream:
            FirebaseMethods().userStream(controller.fireBaseUser.value!.uid),
        builder: (BuildContext context, snapshot) {
          UserModel? userData = snapshot.data;

          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery information',
                  style: appStyle(
                      color: Colors.black, size: 14, fw: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(246, 247, 249, 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderDetails(
                              title: 'Contact',
                              subtitle: '  ${userData!.email}'),
                          const SizedBox(
                            height: 5,
                          ),
                          orderDetails(
                              title: 'Name:',
                              subtitle: '  ${userData.fullName}'),
                          const SizedBox(
                            height: 5,
                          ),
                          orderDetails(
                              title: 'Phone ', subtitle: '  ${userData.phoneNo}'),
                          const SizedBox(
                            height: 5,
                          ),
                          orderDetails(
                              title: 'Order Address:',
                              subtitle: '  $cafe hostel block F')
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  RichText orderDetails({required String title, required String subtitle}) {
    return RichText(
        text: TextSpan(
            text: title,
            children: [
              TextSpan(
                  text: subtitle,
                  style: appStyle(
                      color: Colors.black87, size: 12, fw: FontWeight.normal))
            ],
            style:
                appStyle(color: Colors.black, size: 14, fw: FontWeight.bold)));
  }
}
