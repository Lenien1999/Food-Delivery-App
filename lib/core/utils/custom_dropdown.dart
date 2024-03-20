import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/widgets/app_extension.dart';
import 'package:food_delivery_app/core/utils/colors.dart';
import 'package:food_delivery_app/core/utils/helpers.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String defaultValue;
  final Function(String) onChanged;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.defaultValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: SizedBox(
        width: 250,
        child: DropdownButton(
          value: _selectedValue,
          onChanged: (newValue) {
            setState(() {
              _selectedValue = newValue!;
            });
            widget.onChanged(newValue!);
          },
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          icon: Image.asset(
            Helper.getAssetName("dropdown_filled.png", "virtual"),
          ),
          style: appStyle(
            color: AppColor.primary,
            size: 15,
            fw: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
