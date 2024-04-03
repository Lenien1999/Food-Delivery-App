import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/core/fire_cloud/model/food_model.dart';
 

// Define the enum for OrderStatus
enum OrderStatus { received,  enRoute,cancelled, delivered }

// Implement the toJson and fromJson methods for the enum
extension OrderStatusExtension on OrderStatus {
  String toJson() {
    return toString().split('.').last;
  }

  static OrderStatus fromJson(String json) {
    switch (json) {
      case 'received':
        return OrderStatus.received;
  
      case 'cancelled':
        return OrderStatus.cancelled;
      case 'enRoute':
        return OrderStatus.enRoute;
      case 'delivered':
        return OrderStatus.delivered;
      default:
        throw ArgumentError('Invalid OrderStatus: $json');
    }
  }
}

class Orders {
  String? id;
  String userId;
  DateTime? cancellationTimestamp;
  FoodItem cartFood;
  DateTime date;
  String cafeteria;
  final OrderStatus status;
  String address;

  Orders({
    this.id,
    required this.status,
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
      'cafeteria': cafeteria,
      'cartFood': cartFood.toJson(),
      'status': status.toJson(), // Serialize enum using its toJson method
      'address': address,
      'cancellationTimestamp': cancellationTimestamp,
    };
  }

  factory Orders.fromJson(Map<String, dynamic> data, String id) {
    return Orders(
        id: id,
        status: data['status'] != null
            ? OrderStatusExtension.fromJson(data['status'])
            : OrderStatus.received,
        address: data['address'] ?? " ",
        cafeteria: data['cafeteria'] ?? '',
        userId: data['userId'] ?? '',
        cancellationTimestamp:
            (data['cancellationTimestamp'] as Timestamp?)?.toDate() ??
                DateTime.now(),
        date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
        cartFood: FoodItem.fromJson(data['cartFood'] ?? {}, id));
  }
}
