
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/core/fire_cloud/food/cart_model.dart';

class Order{
  String id;
  List<CartItem> items;
  double totalPrice;
  Timestamp timestamp;

  Order({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.timestamp,
  });

  
}

