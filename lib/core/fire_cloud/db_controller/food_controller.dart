import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:food_delivery_app/core/widgets/customNavBar.dart';
import 'package:food_delivery_app/src/view/foods/views/food_page.dart';

import 'package:get/get.dart';
import '../food_model/order_model.dart';

class FoodDbController {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('order');

  Future<void> orderFood(Orders foods) async {
    try {
      await _collectionReference.add(foods.toJson());
      // Display success message using snackbar
      Get.snackbar(
        "Success",
        "Order placed successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      buildConfirmBooking();
    } catch (error) {
      // Display error message using snackbar
      Get.snackbar(
        "Error",
        "Failed to place order. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      Get.off(() => const FoodHomePage());
    }
  }

  Stream<List<Orders>> orderFoodList() {
    return _collectionReference.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final id = doc.id;
        return Orders.fromJson(data, id);
      }).toList();
    });
  }

  // Future<void> markOrderAsComplete(Orders orders) async {
  //   _collectionReference.doc(orders.id).update({
  //     "isDelivered": orders.isDelivered,
  //     "cancellationTimestamp": orders.isDelivered
  //         ? DateTime.now() // Set cancellation timestamp only when canceled
  //         : null, // Clear cancellation timestamp if not canceled
  //   });
  // }

  // Future<void> markOrderAsRejected(Orders orders) async {
  //   _collectionReference.doc(orders.id).update({
  //     "isCancelled": orders.isRejected,
  //     "cancellationTimestamp": orders.isRejected
  //         ? DateTime.now() // Set cancellation timestamp only when canceled
  //         : null, // Clear cancellation timestamp if not canceled
  //   });
  // }

  Stream<List<Orders>> rejectOrderList() {
    return _collectionReference
        .where('isRejected', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final id = doc.id;
        return Orders.fromJson(data, id);
      }).toList();
    });
  }

  Stream<List<Orders>> deliveredOrderList() {
    return _collectionReference
        .where('isDelivered', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final id = doc.id;
        return Orders.fromJson(data, id);
      }).toList();
    });
  }

  buildConfirmBooking() {
    return Get.dialog(
      Center(
        child: SizedBox(
          height: 400,
          child: AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/real/Check.png",
                  height: 60,
                  width: 60,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Order Successful',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'It is a long established fact that a reader will be distracted by the readable',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(Get.context!).size.width,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.offAll(() => const BuildBottomNavigation());
                    },
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
