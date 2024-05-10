import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/user_data_mixin.dart';

class OrderUserInfo extends StatefulWidget {
  final String cafe;
  final String address;

  const OrderUserInfo({
    Key? key,
    required this.cafe,
    required this.address,
  }) : super(key: key);

  @override
  State<OrderUserInfo> createState() => _OrderUserInfoState();
}

class _OrderUserInfoState extends State<OrderUserInfo> with UserDataMixin {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot?>(
      stream: FirebaseFirestore.instance
          .collection('order')
          .where('userId', isEqualTo: userdata?.id)
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _isLoading
              ? const Center(child: CircularProgressIndicator())
              : const Text('No data available');
        }

        if (userdata == null) {
          return const Text('User data is null');
        }

        _isLoading = false;

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
                      _buildDetailItem('Contact', userdata!.email),
                      _buildDetailItem('Name', userdata!.fullName),
                      _buildDetailItem('Phone', userdata!.phoneNo),
                      _buildDetailItem('Cafeteria', '${widget.cafe} Cafeteria'),
                      _buildDetailItem('Address', widget.address),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
