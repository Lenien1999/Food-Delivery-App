import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/authcontroller.dart';
import 'package:food_delivery_app/core/fire_cloud/db_controller/food_controller.dart';
import 'package:food_delivery_app/core/fire_cloud/food_model/order_model.dart';
import 'package:get/get.dart';
import '../../../core/fire_cloud/auth/auth_controller/auth_model.dart';
import '../../../core/fire_cloud/db_controller/user_controller.dart';
import '../../../core/utils/colors.dart';
import '../../../core/widgets/rich_text.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  UserModel? _userData;
  final controller = Get.put(FoodDbController());
  final authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
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
                subColor: Colors.white)),
        body: StreamBuilder<QuerySnapshot>(
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
                            border:
                                Border.all(color: AppColor.orange, width: 1)),
                        child: Column(children: notifications));
                  });
            }));
  }

  List<Widget> _buildOrderStatusNotifications(Orders order) {
    List<Widget> notifications = [];

    // Generate a notification tile for each status that is true.
    if (order.isConfirmed) {
      notifications.add(_buildNotificationTile("Order Confirmed",
          "Your order has been confirmed.", Icons.check, Colors.blue));
    }
    if (order.isRejected) {
      notifications.add(_buildNotificationTile("Order Rejected",
          "Sorry, your order was rejected.", Icons.close, Colors.red));
    }
    if (order.isDelivered) {
      notifications.add(_buildNotificationTile(
          "Order Delivered",
          "Your order has been delivered.",
          Icons.local_shipping,
          Colors.green));
    }

    return notifications;
  }

  Widget _buildNotificationTile(
      String title, String subtitle, IconData icon, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title,
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }
}
