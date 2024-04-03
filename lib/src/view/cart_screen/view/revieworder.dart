import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/fire_cloud/model/food_model.dart';

import 'package:food_delivery_app/src/view/foods/widget/total_food_price.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/app_extension.dart';
import '../../../../core/state_management/food_provider.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/helpers.dart';
import '../widget/order_user_info.dart';

class ReviewOrder extends StatefulWidget {
  final double totalFoodPrice;
   
  final FoodItem foodItem;
  final String cafeteria;
  final String address;
  const ReviewOrder(
      {super.key,
      required this.cafeteria,
      required this.address,
      required this.totalFoodPrice,
      required this.foodItem, });

  @override
  State<ReviewOrder> createState() => _ReviewOrderState();
}

class _ReviewOrderState extends State<ReviewOrder> {
  final controller = Get.put(FoodController());
  String _selectedValue = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: AppColor.orange,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text(
          'Review Order',
          style: appStyle(
            size: 18,
            color: Colors.white,
            fw: FontWeight.w500,
          ),
        ),
      ),
      body: GetBuilder<FoodController>(builder: (concontroller) {
        List<String> additionalItemsWithQuantity = widget
            .foodItem.additionalItems
            .where((e) => e.quantity > 0)
            .map((e) => "${e.quantity} ${e.name}")
            .toList();
        // Join names of additional items with a comma
        String additionalItemsSummary = additionalItemsWithQuantity.join(', ');
        return Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, bottom: 20),
                    // margin: const EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Food Summary',
                            style: appStyle(
                                color: Colors.black,
                                size: 16,
                                fw: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Wrap(
                            children: [
                              RichText(
                                  text: TextSpan(
                                      text: "${widget.foodItem.name} with",
                                      style: appStyle(
                                          color: AppColor.orange,
                                          size: 14,
                                          fw: FontWeight.bold),
                                      children: [
                                    TextSpan(
                                      text: "  $additionalItemsSummary",
                                      style: appStyle(
                                          color: Colors.black,
                                          size: 12,
                                          fw: FontWeight.bold),
                                    )
                                  ]))
                            ],
                          )
                        ]),
                  ),
                  OrderUserInfo(
                    cafe: widget.cafeteria,
                    address: widget.address,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Text(
                      'Payment Method',
                      style: appStyle(
                          color: Colors.black, size: 16, fw: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(width: 1, color: AppColor.orange)),
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: DropdownButtonHideUnderline(
                      child: SizedBox(
                        width: 250,
                        child: DropdownButton(
                          value: _selectedValue,
                          items: const [
                            DropdownMenuItem(
                              value: "Cash on Delivery",
                              child: Text("Cash on Delivery"),
                            ),
                            DropdownMenuItem(
                              value: "PayPal Payment",
                              child: Text("PayPal Payment"),
                            ),
                          ],
                          icon: Image.asset(
                            Helper.getAssetName(
                                "dropdown_filled.png", "virtual"),
                          ),
                          style: appStyle(
                              color: AppColor.primary,
                              size: 15,
                              fw: FontWeight.bold),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedValue =
                                  value ?? ""; // Update _selectedValue
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ).fadeAnimation(0.4),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: TotalFoodPriceWidget(
                  totalfoodprice: widget.totalFoodPrice,
                  foodItem: widget.foodItem,
                  selectedValue: _selectedValue,
                  cafe: widget.cafeteria,
                  address: widget.address,
                 
                )),
          ],
        );
      }),
    );
  }
}
