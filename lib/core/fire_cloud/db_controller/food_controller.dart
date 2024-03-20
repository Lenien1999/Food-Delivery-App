import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/src/view/order/order_db/order_model.dart';
 
 
class FoodDbController {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('order');
  Future<void> orderFood(Orders foods) async {
    await _collectionReference.add(foods.toJson());
  }

   
   

  Stream<List<Orders>> orderFoodList() {
    return _collectionReference.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final id = doc.id; // Fetching the document ID
        return Orders.fromJson(
            data, id); // Pass the ID to the fromJson method
      }).toList();
    });
  }

  Future<void> markOrderAsComplete(Orders orders) async {
    _collectionReference.doc(orders.id).update({
      "isDelivered": orders.isDelivered,
      "cancellationTimestamp": orders.isDelivered
          ? DateTime.now() // Set cancellation timestamp only when canceled
          : null, // Clear cancellation timestamp if not canceled});
    });  
  }



  Future<void> markOrderAsRejected(Orders orders) async {
    _collectionReference.doc(orders.id).update({
      "isCancelled": orders.isRejected,
      "cancellationTimestamp": orders.isRejected
          ? DateTime.now() // Set cancellation timestamp only when canceled
          : null, // Clear cancellation timestamp if not canceled});
    });
  }

  Stream<List<Orders>> rejectOrderList() {
    return _collectionReference
        .where('isRejected', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final id = doc.id; // Fetching the document ID
        return Orders.fromJson(
            data, id); // Pass the ID to the fromJson method
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
        final id = doc.id; // Fetching the document ID
        return Orders.fromJson(
            data, id); // Pass the ID to the fromJson method
      }).toList();
    });
  }
}
