// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/widgets/app_extension.dart';
import 'package:food_delivery_app/core/widgets/customNavBar.dart';
import 'package:food_delivery_app/src/view/cart_screen/view/revieworder.dart';

import 'package:get/get.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/widgets/customTextInput.dart';

class TotalFoodPriceWidget extends StatefulWidget {
  final double item;
  const TotalFoodPriceWidget({
    Key? key,
    required this.item,
  });

  @override
  State<TotalFoodPriceWidget> createState() => _TotalFoodPriceWidgetState();
}

class _TotalFoodPriceWidgetState extends State<TotalFoodPriceWidget> {
  String? selectedCafeteria;
  TextEditingController destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    destinationController = TextEditingController();
  }

  @override
  void dispose() {
    destinationController.dispose();
    super.dispose();
  }

  List<String> cafeteriaOptions = [
    'ASO Cafeteria',
    'Male Uni Cafeteria',
    'Female Uni Cafeteria',
    'Eng Building Cafe',
  ];

  void _selectCafeteria(String cafeteria) {
    setState(() {
      selectedCafeteria = cafeteria;
    });
    Navigator.of(context).pop(); // Close the modal bottom sheet
    _showCafeteriaBottomSheet(); // Reopen the modal bottom sheet with updated selection
  }

  void _showCafeteriaBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) {
        return SizedBox(
          height: Helper.getScreenHeight(context) * 0.7,
          child: Column(
            children: [
              const SizedBox(height: 15),
              Center(
                child: Text(
                  "Cafeteria & Address",
                  style: appStyle(
                    color: AppColor.orange,
                    size: 18,
                    fw: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Divider(
                  color: AppColor.placeholder.withOpacity(0.5),
                  thickness: 1.5,
                  height: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: CustomTextInput(
                  hintText: "Enter Destination",
                  controller: destinationController,
                  prefixIcon: Icons.location_on,
                ),
              ),
              const SizedBox(height: 30),
              Column(
                children: cafeteriaOptions.map((cafeteria) {
                  return RadioListTile<String>(
                    title: Text(cafeteria),
                    value: cafeteria,
                    groupValue: selectedCafeteria,
                    onChanged: (value) {
                      _selectCafeteria(value!);
                    },
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.orange,
                    ),
                    onPressed: () {
                      Get.to(() => const RevieOrder());
                    },
                    child: Text(
                      "Continue",
                      style: appStyle(
                        color: Colors.white,
                        size: 18,
                        fw: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
                                buildConfirmBooking(context);
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

  buildConfirmBooking(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
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
                      'Order Successful',
                      style: appStyle(
                          color: Colors.black, size: 18, fw: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'It is a long established fact that a reader will be distracted by the readable',
                      style: appStyle(
                          color: Colors.black, size: 14, fw: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: AppColor.orange,
                          borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        onPressed: () {
                          Get.offAll(() => const BuildBottomNavigation());
                        },
                        child: Text(
                          'Back to Home',
                          style: appStyle(
                              color: Colors.white,
                              size: 16,
                              fw: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
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
                height: 110,
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
                    const Text(
                      "Total Price",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.item.toStringAsFixed(2),
                      style: const TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: Helper.getScreenWidth(context) * 0.5,
                      child: ElevatedButton(
                        // onPressed: () {
                        //   buildAlertBox(context);
                        // },
                        onPressed: _showCafeteriaBottomSheet,
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
                    ),
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
