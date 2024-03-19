// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:food_delivery_app/core/fire_cloud/food/food_model.dart';


// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   Future<List<FoodItem>> getFoodItems() async {
//     QuerySnapshot snapshot = await _db.collection('foodItems').get();
//     return snapshot.docs.map((doc) => FoodItem.fromFirestore(doc)).toList();
//   }

//   Future<void> addToCart(String userId, String foodItemId, int quantity) async {
//     DocumentReference userRef = _db.collection('users').doc(userId);
//     DocumentSnapshot userSnapshot = await userRef.get();

//     if (!userSnapshot.exists) {
//       throw Exception('User does not exist');
//     }

//     await userRef.collection('cart').doc(foodItemId).set({
//       'quantity': quantity,
//     });
//   }

//   // Future<void> placeOrder(String userId, List<CartItem> cartItems) async {
//   //   double totalPrice = cartItems.fold(
//   //       0, (previousValue, cartItem) => previousValue + cartItem.foodItem.price * cartItem.quantity);

//   //   DocumentReference orderRef = await _db.collection('orders').add({
//   //     'userId': userId,
//   //     'totalPrice': totalPrice,
//   //     'timestamp': Timestamp.now(),
//   //     'items': cartItems.map((cartItem) {
//   //       return {
//   //         'foodItem': _db.collection('foodItems').doc(cartItem.foodItem.id),
//   //         'quantity': cartItem.quantity,
//   //       };
//   //     }).toList(),
//   //   });

//   //   await _clearCart(userId);
//   // }

//   // Future<List<Order>> getUserOrders(String userId) async {
//   //   QuerySnapshot snapshot = await _db
//   //       .collection('orders')
//   //       .where('userId', isEqualTo: userId)
//   //       .orderBy('timestamp', descending: true)
//   //       .get();

//   //   return snapshot.docs.map((doc) => Order.fromFirestore(doc)).toList();
//   // }

//   Future<void> _clearCart(String userId) async {
//     QuerySnapshot cartSnapshot = await _db.collection('users').doc(userId).collection('cart').get();
//     for (DocumentSnapshot doc in cartSnapshot.docs) {
//       await doc.reference.delete();
//     }
//   }
// }
