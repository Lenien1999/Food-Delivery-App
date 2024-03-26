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

  // Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageURL': imageURL,
      'totalPrice': totalPrice,
      'totalfooditems': totalfooditems,
      'description': description,
      'shortDescription': shortDescription, // Added short description
      'additionalItems': additionalItems.map((item) => item.toJson()).toList(),
    };
  }

  // Deserialization
  factory FoodItem.fromJson(Map<String, dynamic> json, String id) {
    return FoodItem(
      id: json['id'],
      category: json['category'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      imageURL: json['imageURL'],
      totalPrice: json['totalPrice'],
      totalfooditems: json['totalfooditems'],
      description: json['description'],
      shortDescription: json['shortDescription'], // Added short description
      additionalItems: (json['additionalItems'] as List<dynamic>)
          .map((itemJson) => FoodItem.fromJson(itemJson, id))
          .toList(),
    );
  }
 
}


class FoodCategory {
  String categoryName;
  List<FoodItem> foodItems;
  String image;

  FoodCategory({
    required this.categoryName,
    required this.foodItems,
    required this.image,
  });

  // Serialization
  Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
      'foodItems': foodItems.map((item) => item.toJson()).toList(),
      'image': image,
    };
  }

  // Deserialization
  // factory FoodCategory.fromJson(Map<String, dynamic> json) {
  //   return FoodCategory(
  //     categoryName: json['categoryName'],
  //     foodItems: (json['foodItems'] as List<dynamic>)
  //         .map((itemJson) => FoodItem.fromJson(itemJson ))
  //         .toList(),
  //     image: json['image'],
  //   );
  // }
}

