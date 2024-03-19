import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/app_extension.dart';
import 'package:food_delivery_app/core/fire_cloud/food/food_model.dart';
import 'package:food_delivery_app/core/state_management/food_provider.dart';
import 'package:get/get.dart';
import 'package:shadow_clip/shadow_clip.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/helpers.dart';

import '../widget/custom_triangle.dart';

import '../widget/food_package_price.dart';
import '../widget/star_rating_price.dart';

class FoodAbout extends StatelessWidget {
  final FoodItem foodItem;

  const FoodAbout({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FoodController>(builder: (controller) {
        return SingleChildScrollView(
            child: Column(
          children: [
            Stack(
              children: [
                foodAboutHeader(context).fadeAnimation(0.2),
                SafeArea(
                  child: Column(
                    children: [
                      _buildHeader(context),
                      SizedBox(
                        height: Helper.getScreenHeight(context) * 0.35,
                      ),
                      _buildFoodDetails(context, controller),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
      }),
    );
  }

  SizedBox _buildFoodDetails(BuildContext context, FoodController controller) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      foodItem.name,
                      style: appStyle(
                          color: Colors.black, size: 24, fw: FontWeight.bold),
                    ).fadeAnimation(0.6),
                  ),
                  StarRatingAndPriceWidget(
                    foodItem: foodItem,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Description",
                      style: appStyle(
                          color: Colors.black, size: 18, fw: FontWeight.bold),
                    ).fadeAnimation(0.7),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        foodItem.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontFamily: 'Poppins'),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "Customize your Order",
                      style: Helper.getTheme(context).headlineMedium!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.orange),
                    ),
                  ),
                  _divider(),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "NGN ${foodItem.totalPrice.toStringAsFixed(0)}",
                        style: appStyle(
                            color: Colors.black, size: 18, fw: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "Number of ${foodItem.category == 'Solid' ? 'Wrap' : foodItem.category == 'Drinks' ? 'Drinks' : foodItem.category == 'Meats' ? 'Meats' : 'Spoons'}",
                          style:
                              Helper.getTheme(context).headlineMedium!.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(5.0)),
                                onPressed: () {
                                  controller.decreaseItemQuantity(foodItem);
                                },
                                child: const Text("-"),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 35,
                                width: 40,
                                decoration: const ShapeDecoration(
                                  shape: StadiumBorder(
                                    side: BorderSide(color: AppColor.orange),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      foodItem.quantity.toString(),
                                      style: const TextStyle(
                                        color: AppColor.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(5.0)),
                                onPressed: () {
                                  controller.increaseItemQuantity(foodItem);
                                },
                                child: const Text("+"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (foodItem.category == 'Foods' ||
                      foodItem.category == 'Solid' ||
                      foodItem.category == 'meats' &&
                          foodItem.additionalItems.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Additional Item',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Display additional food items

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Wrap(
                            spacing: 30,
                            runSpacing: 20,
                            children:
                                foodItem.additionalItems.map((additionalItem) {
                              return Container(
                                  height:
                                      Helper.getScreenHeight(context) * 0.22,
                                  width: Helper.getScreenWidth(context) * 0.25,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(13),
                                      border: Border.all(
                                          width: 6,
                                          style: BorderStyle.solid,
                                          color: const Color.fromARGB(
                                              255, 250, 246, 246))),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            additionalItem.imageURL,
                                            fit: BoxFit.cover,
                                            height: Helper.getScreenHeight(
                                                    context) *
                                                0.1,
                                            width:
                                                Helper.getScreenWidth(context) *
                                                    0.25,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        additionalItem.name,
                                        style: appStyle(
                                            color: AppColor.orange,
                                            size: 14,
                                            fw: FontWeight.bold),
                                      ),
                                      Text(
                                        additionalItem.totalPrice.toInt() == 0
                                            ? 'Price: 200'
                                            : 'Price: ${additionalItem.totalPrice.toInt()}',
                                        style: appStyle(
                                            color: Colors.black,
                                            size: 14,
                                            fw: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                controller
                                                    .decreaseAdditionalItemQuantity(
                                                        additionalItem);
                                              },
                                              child: const CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 18,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ),
                                          Text(
                                            additionalItem.quantity.toString(),
                                            style: const TextStyle(
                                              color: AppColor.orange,
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                controller.increaseItemQuantity(
                                                    additionalItem);
                                              },
                                              child: const CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 18,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )).fadeAnimation(0.6);
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  FoodPackagePrice(
                    items: foodItem,
                  )
                ],
              ),
            ).fadeAnimation(0.8),
          ),
          customizeFav().fadeAnimation(0.4),
        ],
      ),
    );
  }

  Padding _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        color: AppColor.placeholder,
        thickness: 1.5,
      ),
    );
  }

  Padding _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
          ),
          Image.asset(
            Helper.getAssetName("cart_white.png", "virtual"),
          ).fadeAnimation(0.4),
        ],
      ),
    );
  }

  Padding customizeFav() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: ClipShadow(
          clipper: CustomTriangle(),
          boxShadow: const [
            BoxShadow(
              color: AppColor.placeholder,
              offset: Offset(0, 5),
              blurRadius: 5,
            ),
          ],
          child: Container(
            width: 60,
            height: 60,
            color: Colors.white,
            child: Image.asset(
              Helper.getAssetName(
                "fav_filled.png",
                "virtual",
              ),
            ),
          ),
        ),
      ),
    );
  }

  Stack foodAboutHeader(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: Helper.getScreenHeight(context) * 0.5,
          width: Helper.getScreenWidth(context),
          child: Image.asset(
            foodItem.imageURL,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: Helper.getScreenHeight(context) * 0.5,
          width: Helper.getScreenWidth(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.4],
              colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
