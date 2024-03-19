class FoodItem {
  String? id;
  String category;
  String name;
  double price;
  int quantity;
  String imageURL;
  double totalPrice;
  double totalfooditems;
  String description;
  String shortDescription; // Short description added
  final List<FoodItem> additionalItems;

  FoodItem({
    this.totalPrice = 0.0,
    this.id,
    this.totalfooditems = 0.0,
    required this.category,
    required this.name,
    required this.price,
    this.quantity = 1,
    required this.imageURL,
    required this.description,
    required this.shortDescription, // Short description added
    List<FoodItem>? additionalItems,
  }) : additionalItems = additionalItems ?? [] {
    // Initialize quantity of additional items to zero if not provided
    for (var item in this.additionalItems) {
      item.quantity = 0;
    }
  }
}

class FoodCategory {
  String categoryName;
  List<FoodItem> foodItems;
  String image;

  FoodCategory(
      {required this.image,
      required this.categoryName,
      required this.foodItems});
}
