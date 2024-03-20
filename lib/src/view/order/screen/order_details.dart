import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_app/core/widgets/app_extension.dart';
import 'package:food_delivery_app/core/fire_cloud/food/food_model.dart';
import 'package:food_delivery_app/core/state_management/food_provider.dart';
import 'package:food_delivery_app/src/view/cart_screen/widget/order_user_info.dart';
import 'package:get/get.dart';
import 'package:shadow_clip/shadow_clip.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/helpers.dart';
import '../../foods/widget/custom_triangle.dart';

class OrderDetails extends StatelessWidget {
  final FoodItem foodItem;

  const OrderDetails({Key? key, required this.foodItem}) : super(key: key);

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
          ),
        );
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Star Ratings
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingBar.builder(
                              initialRating: 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 20,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "4 Star Ratings",
                              style: TextStyle(
                                  color: AppColor.orange, fontSize: 12),
                            )
                          ],
                        ),
                        // Price information

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                "NGN ${foodItem.totalPrice.toStringAsFixed(0)}",
                                style: const TextStyle(
                                  color: AppColor.primary,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      "Number of ${foodItem.category == 'Solid' ? 'Wrap' : foodItem.category == 'Drinks' ? 'Drinks' : foodItem.category == 'Meats' ? 'Meats' : 'Spoons'}",
                                      style: Helper.getTheme(context)
                                          .headlineMedium!
                                          .copyWith(
                                            fontSize: 16,
                                          ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 35,
                                      width: 55,
                                      decoration: const ShapeDecoration(
                                        shape: StadiumBorder(
                                          side: BorderSide(
                                              color: AppColor.orange),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
                      foodItem.shortDescription,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontFamily: 'Poppins'),
                    ),
                  ),
                  _divider(),
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
                              return additionalItem.quantity != 0
                                  ? Container(
                                      height: Helper.getScreenHeight(context) *
                                          0.22,
                                      width:
                                          Helper.getScreenWidth(context) * 0.25,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(13),
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
                                                width: Helper.getScreenWidth(
                                                        context) *
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
                                            additionalItem.totalPrice.toInt() ==
                                                    0
                                                ? 'Price: 200'
                                                : 'Price: ${additionalItem.totalPrice.toInt()}',
                                            style: appStyle(
                                                color: Colors.black,
                                                size: 14,
                                                fw: FontWeight.bold),
                                          ),
                                        ],
                                      ).fadeAnimation(0.6),
                                    )
                                  : const SizedBox(); // Return an empty SizedBox for items with quantity 0
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  const OrderUserInfo(),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.placeholder),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "NGN ${foodItem.totalfooditems.toStringAsFixed(2)}",
                        style: appStyle(
                            color: AppColor.orange,
                            size: 14,
                            fw: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColor.orange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Confirm',
                                style: appStyle(
                                    color: Colors.white,
                                    size: 14,
                                    fw: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.placeholder),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: appStyle(
                                    color: AppColor.orange,
                                    size: 14,
                                    fw: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).fadeAnimation(0.8),
          ),
          customizeFav().fadeAnimation(0.4),
        ],
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

  Padding _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        color: AppColor.placeholder,
        thickness: 1.5,
      ),
    );
  }
}
