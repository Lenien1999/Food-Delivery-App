import 'package:food_delivery_app/core/fire_cloud/food/food_model.dart';

import 'package:get/get.dart';

class FoodController extends GetxController {
  RxList<FoodItem> cartfood = <FoodItem>[].obs;
  RxDouble totalPrice = 0.0.obs;
  int pageindex = 0;
  var foodCategoryList = <FoodCategory>[].obs;
  void pageIndex(int index) {
    pageindex = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize totalPrice when the controller is initialized
    calculateTotalPrice();
  }

  void increaseItemQuantity(FoodItem fooditem) {
    fooditem.quantity++;

    fooditem.totalPrice =
        fooditem.price * fooditem.quantity; // Update total price for the item
    calculateTotalPrice();
    update();
  }

  removeCartItemAtSpecificIndex(int index) {
    cartfood.removeAt(index);
    calculateTotalPrice();
    update();
  }

  void decreaseItemQuantity(FoodItem fooditem) {
    if (fooditem.quantity > 1) {
      fooditem.quantity--;
      fooditem.totalPrice =
          fooditem.price * fooditem.quantity; // Update total price for the item

      calculateTotalPrice();
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

  void calculateTotalPrice() {
    double total = 0.0;
    for (var foodItem in cartfood) {
      total +=
          foodItem.totalPrice; // Add the total price of each item to the total
    }
    totalPrice.value = total;
    update();
  }

  void addToCart(FoodItem foodItem) {
    cartfood.add(foodItem);
    update();
  }
}
