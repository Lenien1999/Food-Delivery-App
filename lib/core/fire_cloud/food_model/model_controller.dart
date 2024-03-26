import 'package:food_delivery_app/core/utils/helpers.dart';

import 'food_model.dart';

class ModelController {
  const ModelController._();

  static List<FoodItem> foodList = [
    FoodItem(
      additionalItems: additionalFoods,
      name: 'Fried Rice',
      price: 200,
      imageURL: Helper.getAssetName('fried.jpg', 'virtual'),
      description:
          'A delicious dish made with cooked rice, stir-fried in a wok or frying pan and mixed with other ingredients such as vegetables, eggs, and meat.',
      shortDescription: 'Classic fried rice dish.',
      category: 'Foods',
    ),
    FoodItem(
        additionalItems: additionalFoods,
        category: 'Foods',
        name: 'Fried Rice',
        price: 500,
        description:
            'A delicious dish made with cooked rice, stir-fried in a wok or frying pan and mixed with other ingredients such as vegetables, eggs, and meat.',
        shortDescription: 'Classic fried rice dish.',
        imageURL: 'assets/images/virtual/fried1.jpg'),
    FoodItem(
      additionalItems: additionalFoods,
      name: 'Jollof Rice',
      price: 200,
      category: 'Foods',
      imageURL: 'assets/images/virtual/jollof.jpg',
      description:
          'Jollof Rice is a popular West African dish made with rice, tomatoes, onions, and a blend of spices, cooked to perfection.',
      shortDescription: 'Flavorful rice dish with tomatoes and spices.',
    ),
    FoodItem(
      category: 'Meats',
      name: 'Chicken',
      price: 800,
      imageURL: 'assets/images/virtual/chieken.jpg',
      description:
          'Chicken is a versatile and delicious protein source, commonly prepared by grilling, frying, or roasting.',
      shortDescription: 'Versatile and delicious protein source.',
    ),
    FoodItem(
      additionalItems: additionalFoods,
      category: 'Solids',
      name: 'Eba',
      price: 100,
      imageURL: Helper.getAssetName('eba.jpg', 'virtual'),
      description:
          'Eba is a Nigerian staple food made from cassava flour, commonly served with soups and stews.',
      shortDescription: 'Nigerian staple food made from cassava flour.',
    ),
    FoodItem(
      category: 'Solid',
      name: 'Eba',
      additionalItems: additionalFoods,
      price: 2000,
      imageURL: Helper.getAssetName('eba1.jpg', 'virtual'),
      description:
          'Eba is a Nigerian staple food made from cassava flour, commonly served with soups and stews.',
      shortDescription: 'Nigerian staple food made from cassava flour.',
    ),
    FoodItem(
      category: 'Solid',
      name: 'Semovita',
      price: 200,
      additionalItems: additionalFoods,
      imageURL: Helper.getAssetName('fried.jpg', 'virtual'),
      description:
          'Semovita is a smooth and finely textured semolina flour, commonly used in Nigerian cuisine to prepare swallow, a thick dough-like food often served with soups and stews.',
      shortDescription: 'Smooth semolina flour.',
    ),
    FoodItem(
      category: 'Foods',
      additionalItems: additionalFoods,
      name: 'Beans',
      price: 200,
      imageURL: Helper.getAssetName('bean.jpg', 'virtual'),
      description:
          'Beans are a rich source of protein, fiber, and essential nutrients, commonly used in various culinary dishes worldwide.',
      shortDescription: 'Protein-rich legume.',
    ),
    FoodItem(
      category: 'Foods',
      name: 'Spaghetti',
      price: 200,
      additionalItems: additionalFoods,
      imageURL: Helper.getAssetName('spag.jpg', 'virtual'),
      description:
          'Spaghetti is a type of pasta made from durum wheat semolina, commonly served with a variety of sauces and toppings.',
      shortDescription: 'Versatile pasta dish.',
    ),
    FoodItem(
      category: 'Foods',
      name: 'Yam with Egg',
      additionalItems: additionalFoods,
      price: 800,
      imageURL: Helper.getAssetName('yamegg.jpg', 'virtual'),
      description:
          'Yam with Egg is a nutritious and filling dish made with boiled yam served with scrambled or fried eggs.',
      shortDescription: 'Boiled yam served with eggs.',
    ),
    FoodItem(
      name: 'Yam',
      category: 'Foods',
      additionalItems: additionalFoods,
      price: 800,
      imageURL: Helper.getAssetName('yam.jpg', 'virtual'),
      description:
          'Yam is a starchy tuberous root commonly consumed as a staple food in many parts of the world.',
      shortDescription: 'Starchy tuberous root.',
    ),
    FoodItem(
      category: 'Solid',
      name: 'Fufu Recipe',
      additionalItems: additionalFoods,
      price: 800,
      imageURL: Helper.getAssetName('fufupac.jpg', 'virtual'),
      description:
          'Fufu is a staple food in many West African countries, made from starchy vegetables such as cassava, yams, or plantains.',
      shortDescription: 'Traditional West African dish.',
    ),
    FoodItem(
      category: 'Solid',
      name: 'Fufu',
      additionalItems: additionalFoods,
      price: 100,
      imageURL: Helper.getAssetName('fufu.jpg', 'virtual'),
      description:
          'Fufu is a dough-like food substance made from boiled and mashed starchy vegetables, often served as an accompaniment to soups and stews.',
      shortDescription: 'Dough-like food made from starchy vegetables.',
    ),
    FoodItem(
      category: 'Drinks',
      name: 'Sprite',
      price: 300,
      imageURL: Helper.getAssetName('sprite.jpg', 'virtual'),
      description:
          'Sprite is a clear lemon-lime flavored soft drink created by The Coca-Cola Company.',
      shortDescription: 'Lemon-lime flavored soft drink.',
    ),
    FoodItem(
      category: 'Drinks',
      name: 'Fanta',
      price: 300,
      imageURL: Helper.getAssetName('drink.jpg', 'virtual'),
      description:
          'Fanta is a brand of fruit-flavored carbonated soft Drinks created by The Coca-Cola Company.',
      shortDescription: 'Fruit-flavored carbonated soft drink.',
    ),
    FoodItem(
      category: 'Drinks',
      name: 'Coke',
      price: 300,
      imageURL: Helper.getAssetName('drink.jpg', 'virtual'),
      description:
          'Coca-Cola, or Coke, is a carbonated soft drink manufactured by The Coca-Cola Company.',
      shortDescription: 'Carbonated soft drink.',
    ),
  ];

  static List<FoodCategory> foodCartegoryList = [
    FoodCategory(
        categoryName: 'Foods', foodItems: foodList, image: 'pizza3.jpg'),
    FoodCategory(
        categoryName: 'Drinks', foodItems: foodList, image: 'coffee2.jpg'),
    FoodCategory(
        categoryName: 'Solid', foodItems: foodList, image: 'fruit.jpg'),
    FoodCategory(
        categoryName: 'Meats', foodItems: foodList, image: 'fruit.jpg'),
  ];
  static List<FoodItem> additionalFoods = [
    FoodItem(
      category: 'Meats',
      name: 'Meat',
      price: 100,
      quantity: 0,
      imageURL: Helper.getAssetName('meat.jpg', 'virtual'),
      description:
          'Meat is a staple food rich in protein, essential for muscle growth and repair.',
      shortDescription: 'Protein-rich staple food.',
    ),
    FoodItem(
      name: 'Ponmo',
      price: 200,
      category: 'meats',
      imageURL: 'assets/images/virtual/ponmo.jpg',
      description:
          'Also known as cow skin, ponmo is a popular ingredient in Nigerian cuisine, often used in soups and stews.',
      shortDescription: 'Cow skin used in soups and stews.',
    ),
    FoodItem(
      category: 'meats',
      name: 'Fish',
      price: 200,
      imageURL: Helper.getAssetName('fish.jpg', 'virtual'),
      description:
          'Fish is a nutritious and versatile protein source, commonly prepared by grilling, frying, or baking.',
      shortDescription: 'Nutritious protein source from the sea.',
    ),
    FoodItem(
      category: 'foods',
      name: 'Spaghetti',
      price: 200,
      imageURL: Helper.getAssetName('spag.jpg', 'virtual'),
      description:
          'Spaghetti is a type of pasta made from durum wheat semolina, commonly served with a variety of sauces and toppings.',
      shortDescription: 'Versatile pasta dish.',
    ),
    FoodItem(
      category: 'Drinks',
      name: 'Fanta',
      price: 300,
      imageURL: Helper.getAssetName('drink.jpg', 'virtual'),
      description:
          'Fanta is a brand of fruit-flavored carbonated soft Drinks created by The Coca-Cola Company.',
      shortDescription: 'Fruit-flavored carbonated soft drink.',
    ),
    FoodItem(
      category: 'Drinks',
      name: 'Coke',
      price: 300,
      imageURL: Helper.getAssetName('drink.jpg', 'virtual'),
      description:
          'Coca-Cola, or Coke, is a carbonated soft drink manufactured by The Coca-Cola Company.',
      shortDescription: 'Carbonated soft drink.',
    ),
    FoodItem(
      category: 'Drinks',
      name: 'Table Water',
      price: 300,
      imageURL: Helper.getAssetName('water.png', 'virtual'),
      description:
          'Table water, is a carbonated soft drink manufactured by The Coca-Cola Company.',
      shortDescription: 'Carbonated soft drink.',
    ),
  ];
}
