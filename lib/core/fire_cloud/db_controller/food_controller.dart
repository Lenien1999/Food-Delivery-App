import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/utils/snackbar.dart';
import 'package:food_delivery_app/core/widgets/customNavBar.dart';
import 'package:get/get.dart';
import '../model/order_model.dart';

class FoodDbController extends GetxController {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('order');

  Future<void> orderFood(Orders foods) async {
    try {
      await _collectionReference.add(foods.toJson());
      SnackbarUtils.showSuccessSnackbar("Order placed successfully");
      buildConfirmBooking();
    } catch (error) {
      SnackbarUtils.showErrorSnackbar(
          "Failed to place order. Please try again.");
      Get.offAll(() => const BuildBottomNavigation());
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

  Future<void> markOrderAsEnroute(Orders orders) async {
    final isNotEnRoute = orders.status != OrderStatus.enRoute;

    try {
      await _collectionReference.doc(orders.id).update({
        "status": OrderStatus.enRoute.toJson(),
        "cancellationTimestamp": isNotEnRoute ? DateTime.now() : null,
      });
      SnackbarUtils.showSuccessSnackbar("Order marked as en route");
      Get.offAll(() => const BuildBottomNavigation());
    } catch (error) {
      SnackbarUtils.showErrorSnackbar(
          "Failed to mark order as en route. Please try again.");
      Get.offAll(() => const BuildBottomNavigation());
    }
  }

  Future<void> markOrderAsCancelled(Orders orders) async {
    final cancelled = orders.status != OrderStatus.cancelled;

    try {
      await _collectionReference.doc(orders.id).update({
        "status": OrderStatus.cancelled.toJson(),
        "cancellationTimestamp": cancelled ? DateTime.now() : null,
      });
      SnackbarUtils.showSuccessSnackbar("Order marked as cancelled");
      Get.offAll(() => const BuildBottomNavigation());
    } catch (error) {
      SnackbarUtils.showErrorSnackbar(
          "Failed to mark order as cancelled. Please try again.");
      Get.offAll(() => const BuildBottomNavigation());
    }
  }

  Future<void> markOrderAsDelivered(Orders orders) async {
    final isNotDelivered = orders.status != OrderStatus.delivered;

    try {
      await _collectionReference.doc(orders.id).update({
        "status": OrderStatus.delivered.toJson(),
        "cancellationTimestamp": isNotDelivered ? DateTime.now() : null,
      });
      SnackbarUtils.showSuccessSnackbar("Order marked as delivered");
      Get.offAll(() => const BuildBottomNavigation());
    } catch (error) {
      SnackbarUtils.showErrorSnackbar(
          "Failed to mark order as delivered. Please try again.");
      Get.offAll(() => const BuildBottomNavigation());
    }
  }

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
                const SizedBox(height: 20),
                const Text(
                  'Order Successful',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                const Text(
                  'It is a long established fact that a reader will be distracted by the readable',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 25),
                Container(
                  height: 50,
                  width: MediaQuery.of(Get.context!).size.width,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: () =>
                        Get.offAll(() => const BuildBottomNavigation()),
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
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
