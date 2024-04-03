import 'package:food_delivery_app/core/fire_cloud/model/food_model.dart';

import 'package:get/get.dart';

class FoodController extends GetxController {
  RxDouble totalPrice = 0.0.obs;
  int pageindex = 0;
  var foodCategoryList = <FoodCategory>[].obs;
  void pageIndex(int index) {
    pageindex = index;
    update();
  }

  void increaseItemQuantity(FoodItem fooditem) {
    fooditem.quantity++;

    fooditem.totalPrice =
        fooditem.price * fooditem.quantity; // Update total price for the item

    update();
  }

  void decreaseItemQuantity(FoodItem fooditem) {
    if (fooditem.quantity > 1) {
      fooditem.quantity--;
      fooditem.totalPrice =
          fooditem.price * fooditem.quantity; // Update total price for the item

      update();
    }
  }

  void decreaseAdditionalItemQuantity(FoodItem fooditem) {
    if (fooditem.quantity > 0) {
      fooditem.quantity--;
      fooditem.totalPrice = fooditem.price * fooditem.quantity;

      update();
    }
  }
}
