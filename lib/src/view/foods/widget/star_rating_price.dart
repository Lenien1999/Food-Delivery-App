// ignore_for_file: avoid_print

import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_app/core/fire_cloud/model/food_model.dart';

import '../../../../core/utils/colors.dart';

class StarRatingAndPriceWidget extends StatelessWidget {
  final FoodItem foodItem;
  const StarRatingAndPriceWidget({
    super.key,
    required this.foodItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const SizedBox(height: 5),
              const Text(
                "4 Star Ratings",
                style: TextStyle(color: AppColor.orange, fontSize: 12),
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
                  "NGN ${foodItem.price.toStringAsFixed(0)}",
                  style: const TextStyle(
                    color: AppColor.primary,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                    "/per ${foodItem.category == 'Solid' ? 'Wrap' : foodItem.category == 'Drinks' ? 'Drinks' : foodItem.category == 'Meats' ? 'Meats' : 'Spoons'}")
              ],
            ),
          )
        ],
      ),
    );
  }

  String getCurrency() {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    return format.currencySymbol;
  }
}
