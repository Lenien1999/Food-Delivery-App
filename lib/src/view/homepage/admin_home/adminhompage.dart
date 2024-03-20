import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/widgets/app_extension.dart';
import 'package:food_delivery_app/core/utils/colors.dart';
import 'package:food_delivery_app/src/view/order/screen/order_home.dart';
import 'package:get/get.dart';

class CafeHome extends StatefulWidget {
  const CafeHome({super.key});

  @override
  State<CafeHome> createState() => _CafeHomeState();
}

class _CafeHomeState extends State<CafeHome> {
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
                              children: const [
                            TextSpan(
                                text: '  Aso Cafeteria',
                                style: TextStyle(
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
                  child: buildCafeInfo(
                      '90', ' Total Order', Icons.my_library_books_outlined),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: buildCafeInfo('15', ' Delivered', Icons.food_bank),
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
                    Get.to(() => const OrderHome());
                  },
                  child: buildCafeInfo(
                      '30', 'Accepted Order', Icons.mark_chat_read),
                )),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: buildCafeInfo('15', 'Cancelled', Icons.cancel),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              color: const Color.fromRGBO(246, 247, 249, 1),
              padding: const EdgeInsets.all(17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contact Cafeteria Staff',
                    style: appStyle(
                        color: AppColor.orange, fw: FontWeight.w800, size: 16),
                  ),
                ],
              ),
            ),
            GridView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15),
                itemBuilder: (context, index) {
                  return Container(
                    height: 216,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color.fromRGBO(246, 247, 249, 1),
                          width: 2,
                        )),
                    child: Column(children: [
                      Expanded(
                        child: Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  topLeft: Radius.circular(12))),
                          child: Image.asset('assets/images/real/user.jpg',
                              height: 110, fit: BoxFit.fitHeight),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Mosunmola Ayoke',
                        style: appStyle(
                            color: AppColor.orange,
                            fw: FontWeight.w800,
                            size: 14),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColor.orange,
                              child: Icon(
                                Icons.call_outlined,
                                color: Colors.white,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: AppColor.orange,
                              child: Icon(
                                Icons.message,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                  );
                })
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
