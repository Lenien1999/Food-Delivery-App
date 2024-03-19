import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/utils/helpers.dart';

import '../../../../core/utils/colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required Image image,
    required String name,
  })  : _image = image,
        _name = name,
        super(key: key);

  final String _name;
  final Image _image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              border: Border.all(
                  color: const Color.fromARGB(255, 245, 237, 237), width: 15)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: Helper.getScreenWidth(context) * 0.09,
              height: Helper.getScreenHeight(context) * 0.05,
              child: _image,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          _name,
          style: Helper.getTheme(context)
              .headlineMedium
              ?.copyWith(color: AppColor.primary, fontSize: 14),
        ),
      ],
    );
  }
}
