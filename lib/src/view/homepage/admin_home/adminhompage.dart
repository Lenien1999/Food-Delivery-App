import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery_app/core/fire_cloud/model/order_model.dart';
import 'package:food_delivery_app/core/widgets/app_extension.dart';
import 'package:food_delivery_app/core/utils/colors.dart';
import 'package:food_delivery_app/src/view/order/screen/order_home.dart';
import 'package:get/get.dart';
import '../../../../core/fire_cloud/auth/auth_controller/user_data_mixin.dart';

class CafeHome extends StatefulWidget {
  const CafeHome({super.key});

  @override
  State<CafeHome> createState() => _CafeHomeState();
}

class _CafeHomeState extends State<CafeHome> with UserDataMixin {
  int totalOrders = 0;
  int deliveredOrders = 0;
  int acceptedOrders = 0;
  int cancelledOrders = 0;
  int receivedOrders = 0;
  @override
  void initState() {
    super.initState();
    fetchOrderCounts();
  }

  void fetchOrderCounts() {
    FirebaseFirestore.instance.collection('order').snapshots().listen(
      (snapshot) {
        int tmpTotalOrders = snapshot.docs.length;
        int tmpDeliveredOrders = 0;
        int tmpAcceptedOrders = 0;
        int tmpCancelledOrders = 0;
        int tmpReceivedOrders = 0;

        for (var doc in snapshot.docs) {
          try {
            OrderStatus status = OrderStatusExtension.fromJson(doc['status']);
            switch (status) {
              case OrderStatus.delivered:
                tmpDeliveredOrders++;
                break;
              case OrderStatus.received:
                tmpReceivedOrders++;

                break;
              case OrderStatus.cancelled:
                tmpCancelledOrders++;
                break;
              case OrderStatus.enRoute:
                tmpAcceptedOrders++;
                break;
              default:
                break;
            }
          } catch (e) {
            // Handle any potential errors, such as data format issues
            print("Error processing document ${doc.id}: $e");
          }
        }

        if (mounted) {
          setState(() {
            totalOrders = tmpTotalOrders;
            receivedOrders = tmpReceivedOrders;
            deliveredOrders = tmpDeliveredOrders;
            acceptedOrders = tmpAcceptedOrders;
            cancelledOrders = tmpCancelledOrders;
          });
        }
      },
      onError: (error) => print("Error listening to order updates: $error"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orange,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.message_outlined,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_outline,
                color: Colors.white,
              )),
        ],
        title: Text(
          'Home',
          style: appStyle(
            color: Colors.white,
            fw: FontWeight.w500,
            size: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Container(
              color: const Color.fromRGBO(246, 247, 249, 1),
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Cafeteria:",
                              style: appStyle(
                                color: AppColor.orange,
                                fw: FontWeight.w500,
                                size: 14,
                              ),
                              children: [
                            TextSpan(
                                text: '  ${userdata?.fullName}',
                                style: const TextStyle(
                                  color: AppColor.orange,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ))
                          ])),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Buy Food at Affordable price:",
                              style: appStyle(
                                  color: AppColor.orange,
                                  fw: FontWeight.w500,
                                  size: 18),
                              children: const [
                            TextSpan(
                                text: ' (Fixed)',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ))
                          ])),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.settings, color: AppColor.orange))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const OrderHome(
                            status: OrderStatus.received,
                          ));
                    },
                    child: buildCafeInfo(receivedOrders.toString(),
                        ' Received Order', FontAwesomeIcons.basketShopping),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const OrderHome(
                            status: OrderStatus.delivered,
                          ));
                    },
                    child: buildCafeInfo(deliveredOrders.toString(),
                        ' Delivered', Icons.food_bank),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Get.to(() => const OrderHome(
                          status: OrderStatus.enRoute,
                        ));
                  },
                  child: buildCafeInfo(acceptedOrders.toString(),
                      'EnRoute Order', FontAwesomeIcons.bicycle),
                )),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const OrderHome(
                            status: OrderStatus.cancelled,
                          ));
                    },
                    child: buildCafeInfo(cancelledOrders.toString(),
                        'Cancelled', FontAwesomeIcons.ban),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: buildCafeInfo(totalOrders.toString(), ' Total Order',
                      Icons.my_library_books_outlined),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: buildCafeInfo(
                      '0', ' Incoming Order', FontAwesomeIcons.expeditedssl),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildCafeInfo(String amount, String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(235, 235, 235, 1),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        title: Text(
          amount,
          style:
              appStyle(color: AppColor.orange, fw: FontWeight.w500, size: 16),
        ),
        subtitle: Text(
          title,
          style: appStyle(color: Colors.black, fw: FontWeight.w500, size: 12),
        ),
        trailing: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            icon,
            color: AppColor.orange,
          ),
        ),
      ),
    );
  }
}
