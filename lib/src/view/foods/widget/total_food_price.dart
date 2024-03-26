// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/authcontroller.dart';
import 'package:food_delivery_app/core/fire_cloud/db_controller/food_controller.dart';
import 'package:food_delivery_app/core/fire_cloud/food_model/food_model.dart';
import 'package:food_delivery_app/core/fire_cloud/food_model/order_model.dart';

import 'package:food_delivery_app/core/state_management/food_provider.dart';
import 'package:food_delivery_app/core/widgets/app_extension.dart';
import 'package:food_delivery_app/core/widgets/customNavBar.dart';

import 'package:get/get.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/helpers.dart';

class TotalFoodPriceWidget extends StatefulWidget {
  final double item;
  final String selectedValue;
  final FoodItem foodItem;
  final String cafe;
  final String address;
  const TotalFoodPriceWidget({
    super.key,
    required this.item,
    required this.foodItem,
    required this.selectedValue,
    required this.cafe,
    required this.address,
  });

  @override
  State<TotalFoodPriceWidget> createState() => _TotalFoodPriceWidgetState();
}

class _TotalFoodPriceWidgetState extends State<TotalFoodPriceWidget> {
  final controller = Get.put(FoodController());
  final foodDbController = Get.put(FoodDbController());
  final authController = Get.put(AuthController());

  buildAlertBox(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Center(
            child: SizedBox(
              height: 400,
              child: AlertDialog(
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/real/Check.png",
                      height: 60,
                      width: 60,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Confirm Order',
                      style: appStyle(
                          color: Colors.black, size: 18, fw: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Are you sure you want to confirm the order',
                      style: appStyle(
                          color: AppColor.orange,
                          size: 14,
                          fw: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: appStyle(
                                  color: Colors.black,
                                  size: 18,
                                  fw: FontWeight.w500),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 80,
                            decoration: BoxDecoration(
                                color: AppColor.orange,
                                borderRadius: BorderRadius.circular(12)),
                            child: TextButton(
                              onPressed: () async {
                                List<FoodItem> filteredAdditionalItems = widget
                                    .foodItem.additionalItems
                                    .where((item) => item.quantity > 0)
                                    .toList();
                                final order = Orders(
                                  address: widget.address,
                                  cafeteria: widget.cafe,
                                  cartFood: FoodItem(
                                      additionalItems: filteredAdditionalItems,
                                      category: widget.foodItem.category,
                                      name: widget.foodItem.name,
                                      price: widget.foodItem.price,
                                      imageURL: widget.foodItem.imageURL,
                                      description: widget.foodItem.description,
                                      shortDescription:
                                          widget.foodItem.shortDescription),
                                  userId:
                                      authController.fireBaseUser.value!.uid,
                                  date: DateTime.now(),
                                );
                                await foodDbController.orderFood(order);
                              },
                              child: Text(
                                'Order',
                                style: appStyle(
                                    color: Colors.white,
                                    size: 18,
                                    fw: FontWeight.w500),
                              ),
                            ),
                          ),
                        ])
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double additionalItemsPrice = widget.foodItem.additionalItems.fold(
        0,
        (previousValue, element) =>
            previousValue + element.price * element.quantity);
    // Calculate the total price including the base price of the food item
    double totalPrice = widget.foodItem.totalPrice + additionalItemsPrice;
    widget.foodItem.totalfooditems = totalPrice;
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            width: 120,
            decoration: const ShapeDecoration(
              color: AppColor.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                height: 140,
                width: double.infinity,
                margin: const EdgeInsets.only(
                  left: 50,
                  right: 40,
                ),
                decoration: ShapeDecoration(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: AppColor.placeholder.withOpacity(0.3),
                      offset: const Offset(0, 5),
                      blurRadius: 5,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: widget.selectedValue == 'Cash on Delivery'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Delivery Cost",
                                  style: appStyle(
                                      color: Color.fromARGB(255, 95, 88, 88),
                                      size: 12,
                                      fw: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "NIG 200",
                                  style: appStyle(
                                      color: AppColor.orange,
                                      size: 12,
                                      fw: FontWeight.w500),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ),
                    const Text(
                      "Total Price",
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.item.toStringAsFixed(2),
                      style: const TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 40,
                      width: Helper.getScreenWidth(context) * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          buildAlertBox(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Helper.getAssetName(
                                "add_to_cart.png",
                                "virtual",
                              ),
                            ),
                            const Text("Checkout Now"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
