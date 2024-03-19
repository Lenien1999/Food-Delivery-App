import 'package:food_delivery_app/core/fire_cloud/food/food_model.dart';

class CartItem {
  FoodItem foodItem;
  int quantity;

  CartItem({
    required this.foodItem,
    required this.quantity,
  });
}
