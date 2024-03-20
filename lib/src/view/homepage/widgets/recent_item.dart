import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/widgets/app_extension.dart';
import 'package:food_delivery_app/core/utils/helpers.dart';

import '../../../../core/utils/colors.dart';

class RecentItemCard extends StatelessWidget {
  const RecentItemCard({
    Key? key,
    required String name,
    required Image image,
    required this.cafe,
  })  : _name = name,
        _image = image,
        super(key: key);

  final String _name;
  final String cafe;
  final Image _image;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 80,
            height: 80,
            child: _image,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_name,
                    style: appStyle(
                        color: AppColor.orange, size: 16, fw: FontWeight.w600)),
                Row(
                  children: [
                    const Text("Cafe"),
                    const SizedBox(
                      width: 4,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        ". ",
                        style: TextStyle(
                          color: AppColor.orange,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      cafe,
                      style: appStyle(
                          color: AppColor.primary,
                          size: 13,
                          fw: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      Helper.getAssetName("star_filled.png", "virtual"),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "4.9",
                      style: TextStyle(
                        color: AppColor.orange,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text('124 Ratings')
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
