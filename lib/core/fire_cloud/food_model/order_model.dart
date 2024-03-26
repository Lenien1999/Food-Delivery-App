import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/fire_cloud/food_model/food_model.dart';
class Orders {
  String? id;
  String userId;
  DateTime? cancellationTimestamp;
  FoodItem cartFood;
  DateTime date;
  String cafeteria;
  String address;
  bool isDelivered;
  bool isRejected;

  Orders({
    this.id,
    this.isDelivered = false,
    this.isRejected = false,
    required this.address,
    required this.cafeteria,
    required this.cartFood,
    required this.userId,
    required this.date,
    this.cancellationTimestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date,
      'isDelivered': isDelivered,
      'isRejected': isRejected,
      'cafeteria': cafeteria,
      'cartFood':  cartFood.toJson(),
      'address': address,
      'cancellationTimestamp': cancellationTimestamp,
    };
  }

  factory Orders.fromJson(Map<String, dynamic> data, String id) {
    return Orders(
      id: id,
      address: data['address'] ?? " ",
      cafeteria: data['cafeteria'] ?? '',
      userId: data['userId'] ?? '',
      cancellationTimestamp:
          (data['cancellationTimestamp'] as Timestamp?)?.toDate() ??
              DateTime.now(),
      isDelivered: data['isDelivered'] ?? false,
      isRejected: data['isRejected'] ?? false,
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      cartFood: FoodItem.fromJson(data['foodItem'] ?? {}, id)
    );
  }
}
