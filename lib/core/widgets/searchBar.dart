import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/utils/colors.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        // controller: search,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            prefixIcon: const Icon(Icons.search),
            hintText: 'Seacrh Food',
            suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.mic,
                  color: AppColor.orange,
                )),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
