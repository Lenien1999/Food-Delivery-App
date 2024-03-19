import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/fire_cloud/food/food_model.dart';
import 'package:food_delivery_app/core/state_management/food_provider.dart';
import 'package:food_delivery_app/src/view/cart_screen/view/cart_page.dart';
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
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodController());
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
                          onPressed: () {
                            controller.addToCart(widget.items);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Helper.getAssetName(
                                    "add_to_cart.png", "virtual"),
                              ),
                              const Text(
                                "Add to Cart",
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
                  onTap: () {
                    Get.to(() => const CartPage());
                  },
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
