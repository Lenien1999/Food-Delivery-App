import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/authcontroller.dart';
import 'package:food_delivery_app/core/fire_cloud/db_controller/food_controller.dart';
import 'package:food_delivery_app/core/fire_cloud/food_model/food_model.dart';
import 'package:food_delivery_app/core/state_management/food_provider.dart';
import 'package:food_delivery_app/core/widgets/app_extension.dart';
import 'package:food_delivery_app/core/widgets/customTextInput.dart';
import 'package:food_delivery_app/src/view/cart_screen/view/revieworder.dart';
import 'package:get/get.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/helpers.dart';

class FoodPackagePrice extends StatefulWidget {
  final FoodItem items;
  const FoodPackagePrice({
    super.key,
    required this.items,
  });

  @override
  State<FoodPackagePrice> createState() => _FoodPackagePriceState();
}

class _FoodPackagePriceState extends State<FoodPackagePrice> {
  String selectedCafeteria = '';
  TextEditingController destinationController = TextEditingController();
  final controller = Get.put(FoodController());
  final foodDbController = Get.put(FoodDbController());
  final authController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    destinationController = TextEditingController();
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
                      if (selectedCafeteria.isEmpty ||
                          destinationController.text.isEmpty) {
                        // Show error message if either cafeteria or address is empty
                        Get.snackbar('Error',
                            "Please select cafeteria and enter destination.",
                            backgroundColor: AppColor.orange,
                            snackPosition: SnackPosition.TOP);
                      } else {
                        // Proceed to the next screen
                        Get.to(() => ReviewOrder(
                              cafeteria: selectedCafeteria,
                              address: destinationController.text,
                              totalFoodPrice: widget.items.totalfooditems,
                              foodItem: widget.items,
                            ));
                      }
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

  @override
  Widget build(BuildContext context) {
    // Calculate the total price of additional items
    double additionalItemsPrice = widget.items.additionalItems.fold(
        0,
        (previousValue, element) =>
            previousValue + element.price * element.quantity);
    // Calculate the total price including the base price of the food item
    double totalPrice = widget.items.totalPrice + additionalItemsPrice;
    widget.items.totalfooditems = totalPrice;

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
                height: 120,
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
                      "NGN ${widget.items.totalfooditems}",
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
                          onPressed: _showCafeteriaBottomSheet,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Helper.getAssetName(
                                    "add_to_cart.png", "virtual"),
                              ),
                              const Text(
                                "Checkout",
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 60,
                height: 60,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                      color: AppColor.placeholder.withOpacity(0.3),
                      offset: const Offset(0, 5),
                      blurRadius: 5,
                    ),
                  ],
                  shape: const CircleBorder(),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Image.asset(
                    Helper.getAssetName("cart_filled.png", "virtual"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
