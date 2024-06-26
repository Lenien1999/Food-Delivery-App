import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/auth_model.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/user_data_mixin.dart';
import 'package:food_delivery_app/core/fire_cloud/db_controller/food_controller.dart';
import 'package:food_delivery_app/core/utils/colors.dart';
import 'package:food_delivery_app/core/utils/helpers.dart';
import 'package:food_delivery_app/core/widgets/app_extension.dart';
import 'package:food_delivery_app/core/widgets/rich_text.dart';
import 'package:food_delivery_app/src/view/order/screen/order_details.dart';
import 'package:get/get.dart';

import '../../../../core/fire_cloud/db_controller/user_controller.dart';
import '../../../../core/fire_cloud/model/order_model.dart';

class Cafeteria extends StatefulWidget {
  const Cafeteria({Key? key}) : super(key: key);

  @override
  State<Cafeteria> createState() => _CafeteriaState();
}

class _CafeteriaState extends State<Cafeteria> with UserDataMixin {
  final foodController = Get.put(FoodDbController());
  String selectedCafeteria = 'ASO';

  Future<UserModel?> _fetchUserData(String userId) async {
    try {
      FirebaseMethods firebaseMethods = FirebaseMethods();
      UserModel? userData = await firebaseMethods.getUserData(userId);
      return userData;
    } catch (e) {
      print('Error fetching user data: $e');
      throw Exception('Failed to load user data');
    }
  }

  List<String> cafeteriaOptions = [
    'ASO',
    'Male University',
    'Female University',
    'Engneering Building',
  ];

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
              child: Image.asset(
                Helper.getAssetName("cart.png", "virtual"),
                color: Colors.white,
              ),
            ),
          )
        ],
        title: const AppRichText(
          title: 'Tech-U',
          subtitle: ' CAFE',
          subColor: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('order')
            .where('cafeteria', isEqualTo: selectedCafeteria)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final orders = snapshot.data!.docs
              .map((doc) =>
                  Orders.fromJson(doc.data() as Map<String, dynamic>, doc.id))
              .toList();
          final order = orders
              .where((orderCafe) => orderCafe.cafeteria == selectedCafeteria)
              .toList();

          return Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
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
                SizedBox(
                  height: 60,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(cafeteriaOptions.length, (index) {
                      final cafe = cafeteriaOptions[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedCafeteria = cafe;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: selectedCafeteria == cafe
                                ? Colors.redAccent
                                : const Color.fromRGBO(246, 247, 249, 1),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 8),
                            child: Text(
                              cafe.toString().split('.').last,
                              style: appStyle(
                                color: selectedCafeteria == cafe
                                    ? Colors.white
                                    : const Color.fromRGBO(108, 117, 125, 1),
                                fw: FontWeight.w600,
                                size: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: order.length,
                    itemBuilder: (BuildContext context, int index) {
                      final orders = order[index];
                      return buildOrderItem(orders, context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildOrderItem(Orders orders, BuildContext context) {
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
          color: const Color.fromRGBO(246, 247, 249, 1),
        ),
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
                          orders.status.toString().split('.').last,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColor.orange),
                        ),
                      ),
                    ),
                  ),
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
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  )
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
                  onRatingUpdate: (rating) {},
                ),
                Text(
                  "4.3",
                  style: appStyle(
                    color: Colors.grey,
                    fw: FontWeight.bold,
                    size: 14,
                  ),
                ),
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
              future: _fetchUserData(orders.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final user = snapshot.data!;
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/real/user.jpg',
                      ),
                    ),
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
                      ),
                    ),
                    subtitle: Text(
                      user.phoneNo,
                      style: appStyle(
                        color: const Color.fromARGB(255, 218, 137, 16),
                        fw: FontWeight.w600,
                        size: 12,
                      ),
                    ),
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
