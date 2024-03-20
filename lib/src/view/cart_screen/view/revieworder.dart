import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/view/foods/widget/total_food_price.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/app_extension.dart';
import '../../../../core/state_management/food_provider.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/helpers.dart';
import '../widget/order_user_info.dart';

class RevieOrder extends StatefulWidget {
  const RevieOrder({super.key});

  @override
  State<RevieOrder> createState() => _RevieOrderState();
}

class _RevieOrderState extends State<RevieOrder> {
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
        return Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const OrderUserInfo(),
                 const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.7,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Text(
                      'Payment Method',
                      style: appStyle(
                          color: AppColor.orange,
                          size: 16,
                          fw: FontWeight.bold),
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
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.7,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColor.placeholder.withOpacity(0.25),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Delivery Instruction",
                                  style: appStyle(
                                      color: Colors.black,
                                      size: 16,
                                      fw: FontWeight.w500),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: AppColor.orange,
                                      ),
                                      Text(
                                        "Add Notes",
                                        style: TextStyle(
                                          color: AppColor.orange,
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Delivery Cost",
                                style: appStyle(
                                    color: Colors.black,
                                    size: 16,
                                    fw: FontWeight.w500),
                              ),
                            ),
                            Text(
                              "NIG 2",
                              style: appStyle(
                                  color: AppColor.orange,
                                  size: 16,
                                  fw: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: AppColor.placeholder.withOpacity(0.25),
                          thickness: 1.5,
                        ),
                      ],
                    ),
                  )
                ],
              ).fadeAnimation(0.4),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: TotalFoodPriceWidget(
                    item: concontroller.totalPrice.toDouble())),
          ],
        );
      }),
    );
  }


}

