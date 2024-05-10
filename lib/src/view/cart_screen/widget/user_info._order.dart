import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/user_data_mixin.dart';

import '../../../../core/fire_cloud/auth/auth_controller/auth_model.dart';
import '../../../../core/fire_cloud/db_controller/user_controller.dart';

class OrderUserInfoOrder extends StatefulWidget {
  final String cafe;
  final String address;
  final String user;
  const OrderUserInfoOrder({
    Key? key,
    required this.cafe,
    required this.address,
    required this.user,
  }) : super(key: key);

  @override
  State<OrderUserInfoOrder> createState() => _OrderUserInfoOrderState();
}

class _OrderUserInfoOrderState extends State<OrderUserInfoOrder>
    with UserDataMixin {
  Future<UserModel?> _fetchUserData(String userId) async {
    try {
      FirebaseMethods firebaseMethods = FirebaseMethods();
      UserModel? userData = await firebaseMethods.getUserData(userId);
      return userData;
    } catch (e) {
      print('Error fetching user data: $e');
      throw Exception(
          'Failed to load user data'); // Rethrow or handle as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
        future:
            _fetchUserData(widget.user), // This assumes you have the user's ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            final user = snapshot.data!;

            // Assuming there's only one order for the user for simplicity

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Delivery Information',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailItem('Contact', user.email),
                          _buildDetailItem('Name', user.fullName),
                          _buildDetailItem('Phone', user.phoneNo),
                          _buildDetailItem(
                              'Cafeteria', '${widget.cafe} Cafeteria'),
                          _buildDetailItem('Address', widget.address),
                          // Add more details from orderData if needed
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('User data not found');
          }
        });
  }

  Widget _buildDetailItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 65, 58, 58),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
