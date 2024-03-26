// import 'package:badges/badges.dart';
// import 'package:flutter/material.dart' hide Badge;

// import 'package:food_delivery_app/core/widgets/app_extension.dart';
// import 'package:food_delivery_app/core/state_management/food_provider.dart';
// import 'package:food_delivery_app/core/utils/colors.dart';
// import 'package:food_delivery_app/core/utils/page_transition.dart';
// import 'package:get/get.dart';

// import '../../../../core/utils/helpers.dart';
// import '../../../../core/widgets/rich_text.dart';

// import '../../foods/widget/total_food_price.dart';
// import '../../foods/views/food_page.dart';

// class CartPage extends StatelessWidget {
//   const CartPage({super.key});

//   @override
//   Widget build(BuildContext context) {
  
//     return Scaffold(
//       appBar: AppBar(
//         scrolledUnderElevation: 0.0,
//         iconTheme: const IconThemeData(color: AppColor.orange),
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 20.0),
//             child: Badge(
//               badgeStyle:
//                   const BadgeStyle(elevation: 2, badgeColor: Colors.orange),
//               badgeContent: Text(
//                 controller.cartfood.length.toString(),
//                 style: const TextStyle(color: Colors.white),
//               ),
//               child: Image.asset(
//                 Helper.getAssetName("cart_filled.png", "virtual"),
//                 color: AppColor.orange,
//               ),
//             ),
//           )
//         ],
//         title: const AppRichText(
//           title: 'Tech-U',
//           subtitle: ' CART',
//           subColor: AppColor.orange,
//         ),
//       ),
//       body: controller.cartfood.isEmpty
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset('assets/images/virtual/vector2.png'),
//                   Text(
//                     'No Item in Cart Yet',
//                     style: appStyle(
//                         color: AppColor.placeholder,
//                         size: 18,
//                         fw: FontWeight.bold),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Get.to(() => const FoodHomePage());
//                     },
//                     child: Text(
//                       'Place Your Order',
//                       style: appStyle(
//                           color: AppColor.orange,
//                           size: 18,
//                           fw: FontWeight.bold),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           : PageTransition(
//               child: GetBuilder<FoodController>(
//                 builder: (controller) {
//                   return Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             physics: const BouncingScrollPhysics(),
//                             itemCount: controller.cartfood.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               if (index < controller.cartfood.length) {
//                                 final items = controller.cartfood[index];
//                                 List<String> additionalItemsWithQuantity = items
//                                     .additionalItems
//                                     .where((e) => e.quantity > 0)
//                                     .map((e) => "${e.name} ${e.quantity}")
//                                     .toList();
//                                 // Join names of additional items with a comma
//                                 String additionalItemsSummary =
//                                     additionalItemsWithQuantity.join(', ');
//                                 return Container(
//                                   margin: const EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(
//                                       color: const Color.fromARGB(
//                                           255, 228, 225, 225),
//                                       width: 3,
//                                     ),
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           child: Image.asset(
//                                             items.imageURL,
//                                             height: 100,
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(5.0),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     items.category,
//                                                     style: appStyle(
//                                                       color: Colors.black,
//                                                       size: 16,
//                                                       fw: FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                   IconButton(
//                                                       onPressed: () {},
//                                                       icon: const Icon(
//                                                         Icons.delete,
//                                                         color: AppColor.orange,
//                                                       ))
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: Helper.getScreenHeight(
//                                                         context) *
//                                                     0.01,
//                                               ),
//                                               Text(
//                                                 "Price: NGR${items.totalfooditems.toStringAsFixed(0)}",
//                                                 style: appStyle(
//                                                   color: Colors.redAccent,
//                                                   size: 16,
//                                                   fw: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               Wrap(
//                                                 children: [
//                                                   Text(
//                                                     items.name,
//                                                     style: appStyle(
//                                                       color: Colors.black,
//                                                       size: 14,
//                                                       fw: FontWeight.bold,
//                                                     ),
//                                                   ), // Display item name
//                                                   const SizedBox(
//                                                       width:
//                                                           5), // Add some space between item name and summary
//                                                   Text(
//                                                       additionalItemsSummary), // Display summary of additional items
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ).fadeAnimation(4);
//                               } else {
//                                 return const SizedBox.shrink();
//                               }
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                             child: Column(
//                           children: [
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 20.0),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Text("Sub Total",
//                                             style: appStyle(
//                                                 color: Colors.black,
//                                                 size: 14,
//                                                 fw: FontWeight.w500)),
//                                       ),
//                                       Text("\$68",
//                                           style: appStyle(
//                                               color: AppColor.orange,
//                                               size: 14,
//                                               fw: FontWeight.w500))
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Text("Delivery Cost",
//                                             style: appStyle(
//                                                 color: Colors.black,
//                                                 size: 14,
//                                                 fw: FontWeight.w500)),
//                                       ),
//                                       Text("\$2",
//                                           style: appStyle(
//                                               color: AppColor.orange,
//                                               size: 16,
//                                               fw: FontWeight.w500))
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Divider(
//                                     color:
//                                         AppColor.placeholder.withOpacity(0.25),
//                                     thickness: 1.5,
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             TotalFoodPriceWidget(
//                               fooditem:
//                               item: totalFoodPrice,
//                               isCheckout: false,
//                             ),
//                           ],
//                         ))
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//     );
//   }
// }
