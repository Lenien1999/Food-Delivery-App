import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/widgets/app_extension.dart';

import '../../../core/utils/colors.dart';
import '../../../core/widgets/rich_text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            scrolledUnderElevation: 0.0,
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: AppColor.orange,
            centerTitle: true,
            title: const AppRichText(
                title: 'Cafe',
                subtitle: ' Notification',
                subColor: Colors.white)),
        body: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.orange, width: 1)),
                child: ListTile(
                  subtitle: Text(
                    'Title fjhsba   ksjkekne wkkln b ekjqjh,q qkenjke  hjkekkbe wjw',
                    style: appStyle(
                        color: Colors.black, size: 12, fw: FontWeight.w500),
                  ),
                  title: Text(
                    'Title',
                    style: appStyle(
                        color: AppColor.orange, size: 14, fw: FontWeight.bold),
                  ),
                  leading: Icon(Icons.notification_important),
                ),
              );
            }));
  }
}
