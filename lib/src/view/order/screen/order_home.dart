// ignore_for_file: avoid_print

import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/auth_model.dart';
import 'package:food_delivery_app/core/fire_cloud/db_controller/food_controller.dart';
import 'package:food_delivery_app/core/fire_cloud/db_controller/user_controller.dart';
import 'package:food_delivery_app/core/fire_cloud/model/order_model.dart';

import 'package:food_delivery_app/core/utils/helpers.dart';
import 'package:food_delivery_app/src/view/order/screen/order_details.dart';
import 'package:get/get.dart';
import '../../../../core/fire_cloud/auth/auth_controller/user_data_mixin.dart';
import '../../../../core/widgets/app_extension.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/rich_text.dart';

class OrderHome extends StatefulWidget {
  final OrderStatus status;
  const OrderHome({
    super.key,
    required this.status,
  });

  @override
  State<OrderHome> createState() => _OrderHomeState();
}

class _OrderHomeState extends State<OrderHome> with UserDataMixin {
  final foodController = Get.put(FoodDbController());
  OrderStatus selectedStatus = OrderStatus.values[0]; // Default selected status

  Future<UserModel?> _fetchUserData(String userId) async {
    try {
      FirebaseMethods firebaseMethods = FirebaseMethods();
      UserModel? userData = await firebaseMethods.getUserData(userId);
      return userData;
    } catch (e) {
      print('Error fetching user data: $e');
      throw Exception(
          'Failed to load user data'); // Rethrow or handle as needed
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: () {},
                child: Badge(
                  badgeStyle:
                      const BadgeStyle(elevation: 2, badgeColor: Colors.white),
                  badgeContent: const Text(
                    '0',
                    style: TextStyle(color: AppColor.orange),
                  ),
                  child: Image.asset(
                    Helper.getAssetName("cart.png", "virtual"),
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
          title: AppRichText(
              title: '${widget.status.toString().split('.').last} ',
              subtitle: ' Orders',
              subColor: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: TextEditingController(),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  filled: true,
                  fillColor: const Color.fromRGBO(246, 247, 249, 1),
                  hintText: 'Search here',
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<Orders>>(
                    stream: foodController.orderFoodList(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No Order'),
                        );
                      }
                      final order = snapshot.data!
                          .where((order) => order.status == widget.status)
                          .toList();
                      if (order.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/virtual/vector2.png'),
                              Text(
                                'Empty',
                                style: appStyle(
                                  color: AppColor.placeholder,
                                  size: 18,
                                  fw: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: order.length,
                        itemBuilder: (BuildContext context, int index) {
                          final orders = order[index];

                          return buildOrderItem(orders, context);
                        },
                      );
                    }),
              ),
            ],
          ),
        ));
  }

  buildOrderItem(Orders orders, BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => OrderDetails(order: orders));
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 2,
                spreadRadius: 1,
              )
            ],
            border: Border.all(
                width: 1, color: const Color.fromARGB(255, 224, 222, 222)),
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromRGBO(246, 247, 249, 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 175,
              child: Stack(
                children: [
                  Image.asset(
                    orders.cartFood.imageURL,
                    fit: BoxFit.fill,
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Positioned(
                      left: 10,
                      top: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.orange, width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(23),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            orders.cartFood.name,
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColor.orange),
                          ),
                        ),
                      )),
                  Positioned(
                      right: 20,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          color: AppColor.orange,
                          borderRadius: BorderRadius.circular(23),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10),
                          child: Text(
                            "NG${orders.cartFood.totalfooditems}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Row(
              children: [
                RatingBar.builder(
                    initialRating: 4,
                    minRating: 1,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                    itemSize: 20,
                    direction: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const Icon(
                        Icons.star,
                        color: Color.fromRGBO(255, 189, 0, 1),
                      );
                    },
                    onRatingUpdate: (rating) {}),
                Text(
                  "4.3",
                  style: appStyle(
                    color: Colors.grey,
                    fw: FontWeight.bold,
                    size: 14,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                width: 310,
                child: Text(
                  orders.cartFood.shortDescription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: appStyle(
                    color: const Color.fromRGBO(28, 31, 52, 1),
                    fw: FontWeight.w500,
                    size: 16,
                  ),
                ),
              ),
            ),
            FutureBuilder<UserModel?>(
              future: _fetchUserData(
                  orders.userId), // This assumes you have the user's ID
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final user = snapshot.data!;
                  return ListTile(
                    leading: const CircleAvatar(
                        backgroundImage: AssetImage(
                      'assets/images/real/user.jpg',
                    )),
                    title: Text(
                      user.fullName,
                      style: appStyle(
                        color: const Color.fromRGBO(108, 117, 125, 1),
                        fw: FontWeight.w600,
                        size: 14,
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.account_balance_sharp,
                          color: AppColor.orange,
                        )), // Handle null case
                    subtitle: Text(
                      user.phoneNo,
                      style: appStyle(
                        color: const Color.fromARGB(255, 218, 137, 16),
                        fw: FontWeight.w600,
                        size: 12,
                      ),
                    ), // Handle null case
                  );
                } else {
                  return const Text('User data not found');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
