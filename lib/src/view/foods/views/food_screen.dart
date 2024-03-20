import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery_app/core/widgets/app_extension.dart';
import 'package:food_delivery_app/core/fire_cloud/food/food_model.dart';
import 'package:food_delivery_app/core/fire_cloud/food/model_controller.dart';
import 'package:food_delivery_app/src/view/cart_screen/view/cart_page.dart';
import 'package:food_delivery_app/src/view/foods/views/food_about.dart';
import 'package:food_delivery_app/core/utils/colors.dart';
import 'package:food_delivery_app/core/utils/page_transition.dart';
import 'package:food_delivery_app/core/widgets/rich_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../core/widgets/searchBar.dart';

class FoodsScreen extends StatelessWidget {
  final FoodCategory category;
  const FoodsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final String foodcategory = category.categoryName;
    int itemCount = ModelController.foodCartegoryList
        .where((element) =>
            element.foodItems.any((doc) => doc.category == foodcategory))
        .toList()
        .length;
    return PageTransition(
      child: Scaffold(
        appBar: AppBar(
            scrolledUnderElevation: 0.0,
            iconTheme: const IconThemeData(color: AppColor.orange),
            backgroundColor: Colors.white,
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const CartPage());
                  },
                  child: Badge(
                    badgeStyle: const BadgeStyle(
                        elevation: 2, badgeColor: Colors.orange),
                    badgeContent: const Text(
                      '1',
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Image.asset(
                      Helper.getAssetName("cart.png", "virtual"),
                      color: AppColor.orange,
                    ),
                  ),
                ),
              )
            ],
            title: AppRichText(
                title: 'Tech-U',
                subtitle: ' CAFE ${category.categoryName}',
                subColor: AppColor.orange)),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'What do you want \n for',
                        style: appStyle(
                                color: Colors.black,
                                size: 20,
                                fw: FontWeight.bold)
                            .copyWith(fontFamily: 'Poppins'),
                        children: [
                          TextSpan(
                              text: ' Dinner?',
                              style: appStyle(
                                      color: AppColor.orange,
                                      size: 16,
                                      fw: FontWeight.bold)
                                  .copyWith())
                        ]),
                  ),
                ),
              ).fadeAnimation(0.2),
              const SearchWidget().fadeAnimation(0.4),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Available Foods',
                style: appStyle(
                    color: Colors.black, size: 16, fw: FontWeight.bold),
              ).fadeAnimation(0.5),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (__, index) {
                  final filtefood = ModelController.foodList
                      .where((element) => element.category == foodcategory)
                      .toList();
                  if (index < filtefood.length) {
                    final foods = filtefood[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (__) {
                          return FoodAbout(
                            foodItem: foods,
                          );
                        }));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(13),
                        width: Helper.getScreenWidth(context) * 0.8,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 240, 237, 237),
                                width: 2,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                child: Image.asset(
                                  foods.imageURL,
                                  height: 110,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          foods.name,
                                          style: appStyle(
                                              color: Colors.black,
                                              size: 18,
                                              fw: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 9,
                                        ),
                                        const Icon(
                                          FontAwesomeIcons.star,
                                          color: AppColor.orange,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1, vertical: 1),
                                      child: Text(
                                        foods.shortDescription,
                                        overflow: TextOverflow.fade,
                                        style: appStyle(
                                            color: Colors.black,
                                            size: 12,
                                            fw: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Price: ${getCurrency() + foods.price.toStringAsFixed(0)}',
                                          style: appStyle(
                                              color: AppColor.orange,
                                              size: 16,
                                              fw: FontWeight.w700),
                                        ),
                                        Image.asset(
                                          Helper.getAssetName(
                                              "cart.png", "virtual"),
                                          color: AppColor.orange,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).fadeAnimation(0.8),
                    );
                  } else {
                    // ignore: avoid_print
                    print('Index out of bounds: $index');
                    return Container(); // or some placeholder widget
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }

  String getCurrency() {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    return format.currencySymbol;
  }
}
