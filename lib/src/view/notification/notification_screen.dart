// ignore_for_file: avoid_print

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/authcontroller.dart';
import 'package:food_delivery_app/core/fire_cloud/db_controller/food_controller.dart';
import 'package:food_delivery_app/core/fire_cloud/model/order_model.dart';
import 'package:food_delivery_app/src/view/order/screen/order_details.dart';
import 'package:get/get.dart';
import '../../../core/fire_cloud/auth/auth_controller/auth_model.dart';
import '../../../core/fire_cloud/db_controller/user_controller.dart';
import '../../../core/utils/colors.dart';
import '../../../core/widgets/app_extension.dart';
import '../../../core/widgets/rich_text.dart';
import '../foods/views/food_page.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  UserModel? _userData;
  final controller = Get.put(FoodDbController());
  final authController = Get.put(AuthController());
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _getCurrentUser() async {
    String? userId = authController.fireBaseUser.value?.uid;
    if (userId != null) {
      _fetchUserData(userId);
    } else {
      print('User is not logged in.');
    }
  }

  Future<void> _fetchUserData(String userId) async {
    try {
      FirebaseMethods firebaseMethods = FirebaseMethods();
      UserModel? userData = await firebaseMethods.getUserData(userId);
      setState(() {
        _userData = userData;
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColor.orange,
        centerTitle: true,
        title: const AppRichText(
          title: 'Cafe',
          subtitle: 'Notification',
          subColor: Colors.white,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('order')
                  .where('userId', isEqualTo: _userData?.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final orders = snapshot.data!.docs
                    .map((doc) => Orders.fromJson(
                        doc.data() as Map<String, dynamic>, doc.id))
                    .toList();
                if (orders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/virtual/vector2.png'),
                        Text(
                          'No notifications yet',
                          style: appStyle(
                            color: AppColor.placeholder,
                            size: 18,
                            fw: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => const FoodHomePage());
                          },
                          child: Text(
                            'Place Your Order',
                            style: appStyle(
                              color: AppColor.orange,
                              size: 18,
                              fw: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    // Generate notifications for each order status.
                    List<Widget> notifications =
                        _buildOrderStatusNotifications(order);

                    return Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.orange, width: 1),
                      ),
                      child: Column(
                        children: notifications,
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  List<Widget> _buildOrderStatusNotifications(Orders order) {
    List<Widget> notifications = [];

    // Generate a notification tile for each status that is true.
    if (order.status == OrderStatus.received) {
      notifications.add(
        InkWell(
          onTap: () {
            Get.to(() => OrderDetails(order: order));
          },
          child: _buildNotificationTile(
            "Order Received",
            "Your order has been received.",
            Icons.check,
            Colors.blue,
          ),
        ),
      );
    }

    if (order.status == OrderStatus.enRoute) {
      Random random = Random();
      int deliveryTime = random.nextInt(26) + 5;
      notifications.add(
        InkWell(
          onTap: () {
            Get.to(() => OrderDetails(order: order));
          },
          child: _buildNotificationTile(
            "Order En Route",
            "Your order is en route for delivery in the next $deliveryTime min.",
            Icons.local_shipping,
            Colors.green,
          ),
        ),
      );
    }
    if (order.status == OrderStatus.delivered) {
      notifications.add(
        InkWell(
          onTap: () {
            Get.to(() => OrderDetails(order: order));
          },
          child: _buildNotificationTile(
            "Order Delivered",
            "Your order has been confirmed for delivery",
            Icons.delivery_dining,
            Colors.purple,
          ),
        ),
      );
    }

    return notifications;
  }

  Widget _buildNotificationTile(
      String title, String subtitle, IconData icon, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
    );
  }
}
