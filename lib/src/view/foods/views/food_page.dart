import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_app/core/fire_cloud/model/model_controller.dart';

import 'package:food_delivery_app/core/utils/colors.dart';
import 'package:food_delivery_app/core/utils/helpers.dart';
import 'package:food_delivery_app/src/view/foods/views/food_about.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/app_extension.dart';
import '../../../../../core/widgets/rich_text.dart';
 
class FoodHomePage extends StatelessWidget {
  const FoodHomePage({super.key});

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
                onTap: () {
                  
                },
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
          title: const AppRichText(
              title: 'Tech-U', subtitle: ' CAFE', subColor: Colors.white)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Food Repositories',
              style: appStyle(
                  color: AppColor.orange, size: 16, fw: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
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
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.9,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: ModelController.foodList.length,
              itemBuilder: (context, index) {
                final foodItem = ModelController.foodList[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => FoodAbout(foodItem: foodItem));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 2,
                            spreadRadius: 1,
                          )
                        ],
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 224, 222, 222)),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Image.asset(
                                foodItem.imageURL,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Positioned(
                                  left: 5,
                                  top: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.orange, width: 1),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(23),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        foodItem.name,
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.orange),
                                      ),
                                    ),
                                  )),
                              Positioned(
                                  right: 10,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      color: AppColor.orange,
                                      borderRadius: BorderRadius.circular(23),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0, horizontal: 10),
                                      child: Text(
                                        '\$${foodItem.price.toInt()}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                RatingBar.builder(
                                    initialRating: 4,
                                    minRating: 1,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                    itemSize: 15,
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
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                foodItem.shortDescription,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: appStyle(
                                  color: const Color.fromRGBO(28, 31, 52, 1),
                                  fw: FontWeight.w500,
                                  size: 12,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => FoodAbout(foodItem: foodItem));
                              },
                              child: Container(
                                margin: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: AppColor.orange,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(14)),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Center(
                                    child: Text(
                                      'View',
                                      style: appStyle(
                                          color: AppColor.orange,
                                          size: 12,
                                          fw: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
