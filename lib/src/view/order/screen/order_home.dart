import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_app/core/fire_cloud/food_model/food_model.dart';

import 'package:food_delivery_app/core/state_management/food_provider.dart';
import 'package:food_delivery_app/core/utils/helpers.dart';
import 'package:food_delivery_app/src/view/order/screen/order_details.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/app_extension.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/rich_text.dart';

class OrderHome extends StatefulWidget {
  final FoodItem foodItem;
  const OrderHome({super.key, required this.foodItem});

  @override
  State<OrderHome> createState() => _OrderHomeState();
}

class _OrderHomeState extends State<OrderHome> {
  final orderCategory = ['All Order', 'Pending', 'Confirmed'];
  final controller = Get.put(FoodController());
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
                onTap: () {},
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
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            TextFormField(
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
            SizedBox(
              height: 60,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(orderCategory.length, (index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(246, 247, 249, 1)),
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 8),
                      child: Text(
                        orderCategory[index],
                        style: appStyle(
                          color: const Color.fromRGBO(108, 117, 125, 1),
                          fw: FontWeight.w600,
                          size: 14,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
   
                    
                     InkWell(
                      onTap: () {
                        Get.to(() => OrderDetails(
                              foodItem: widget.foodItem,
                            ));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
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
                                color:
                                    const Color.fromARGB(255, 224, 222, 222)),
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromRGBO(246, 247, 249, 1)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 175,
                              child: GestureDetector(
                                onTap: () {},
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      widget.foodItem.imageURL,
                                      fit: BoxFit.fill,
                                      height: 160,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    Positioned(
                                        left: 10,
                                        top: 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColor.orange,
                                                width: 1),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(23),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              widget.foodItem.name,
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.orange),
                                            ),
                                          ),
                                        )),
                                    Positioned(
                                        right: 20,
                                        bottom: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white, width: 1),
                                            color: AppColor.orange,
                                            borderRadius:
                                                BorderRadius.circular(23),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0, horizontal: 10),
                                            child: Text(
                                              "\$${widget.foodItem.price}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                                    initialRating: 4,
                                    minRating: 1,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                    itemSize: 20,
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
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 310,
                                child: Text(
                                 widget.foodItem.shortDescription,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: appStyle(
                                    color: const Color.fromRGBO(28, 31, 52, 1),
                                    fw: FontWeight.w500,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/images/real/user.jpg',
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Aminu Azeez',
                                    style: appStyle(
                                      color: const Color.fromRGBO(
                                          108, 117, 125, 1),
                                      fw: FontWeight.w600,
                                      size: 14,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ,
            
          ],
        ),
      ),
    );
  }
}
