import 'package:flutter/material.dart';

import '../../../../core/widgets/app_extension.dart';

class OrderUserInfo extends StatelessWidget {
  const OrderUserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery information',
            style: appStyle(color: Colors.black, size: 14, fw: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration:
                const BoxDecoration(color: Color.fromRGBO(246, 247, 249, 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderDetails(
                        title: 'Contact', subtitle: '  mayowa@gmai.com'),
                    const SizedBox(
                      height: 5,
                    ),
                    orderDetails(
                        title: 'Name:', subtitle: '  Mayowa Mosunmola'),
                    const SizedBox(
                      height: 5,
                    ),
                    orderDetails(title: 'Phone ', subtitle: '  080192882989'),
                    const SizedBox(
                      height: 5,
                    ),
                    orderDetails(
                        title: 'Order Address:',
                        subtitle: '  Aso Cafteria hostel block F')
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  RichText orderDetails({required String title, required String subtitle}) {
    return RichText(
        text: TextSpan(
            text: title,
            children: [
              TextSpan(
                  text: subtitle,
                  style: appStyle(
                      color: Colors.black87, size: 12, fw: FontWeight.normal))
            ],
            style:
                appStyle(color: Colors.black, size: 14, fw: FontWeight.bold)));
  }
}
