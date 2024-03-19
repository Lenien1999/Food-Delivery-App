import 'package:flutter/material.dart';

// Define a Food class
class Food {
  final String name;
  final int price; // Price in Naira
  final String image;
  final int quantity;

  Food(
      {this.quantity = 1,
      required this.name,
      required this.price,
      required this.image});
}

// Define food items
final friedRice =
    Food(name: 'Fried Rice', price: 200, image: 'assets/fried_rice.jpg');
final jollofRice =
    Food(name: 'Jollof Rice', price: 200, image: 'assets/jollof_rice.jpg');
final ponmo = Food(name: 'Ponmo', price: 200, image: 'assets/ponmo.jpg');
final chicken = Food(name: 'Chicken', price: 800, image: 'assets/chicken.jpg');
final meat = Food(name: 'Meat', price: 100, image: 'assets/meat.jpg');
final yam = Food(name: 'Yam', price: 200, image: 'assets/chicken.jpg');
final spag = Food(name: 'Spag', price: 200, image: 'assets/meat.jpg');
final beans = Food(name: 'Beans', price: 200, image: 'assets/chicken.jpg');
final friedEgg = Food(name: 'Meat', price: 200, image: 'assets/meat.jpg');
final boil = Food(name: 'Boil', price: 150, image: 'assets/chicken.jpg');
final fish = Food(name: 'Fish', price: 200, image: 'assets/meat.jpg');
final semo = Food(name: 'Semovital', price: 200, image: 'assets/meat.jpg');
final eba = Food(name: 'Eba', price: 100, image: 'assets/chicken.jpg');
final fufu = Food(name: 'Fufu', price: 100, image: 'assets/meat.jpg');
final amala = Food(name: 'Amala', price: 100, image: 'assets/meat.jpg');

// Define drinks
final coke = Food(name: 'Coke', price: 150, image: 'assets/coke.jpg');
final fanta = Food(name: 'Fanta', price: 150, image: 'assets/fanta.jpg');
final sprite = Food(name: 'Sprite', price: 150, image: 'assets/sprite.jpg');

// Define food lists for each cafeteria
final asoCafeteriaMenu = [friedRice, jollofRice, ponmo, chicken, meat];
final maleUniCafeteriaMenu = [friedRice, jollofRice, ponmo, chicken, meat];
final femaleUniCafeteriaMenu = [friedRice, jollofRice, ponmo, chicken, meat];
final engBuildingCafeMenu = [friedRice, jollofRice, ponmo, chicken, meat];
 
 

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<Food, int> selectedItems = {};
  Food? selectedDrink;
  String? selectedCafeteria;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Items'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                _buildSectionTitle('Food Items'),
                _buildFoodItems(asoCafeteriaMenu),
                _buildSectionTitle('Drinks'),
                _buildDrinkItems([coke, fanta, sprite]),
              ],
            ),
          ),
          if (selectedItems.isNotEmpty || selectedDrink != null)
            _buildSelectedItems(),
          if (selectedItems.isNotEmpty || selectedDrink != null)
            const Divider(),
          _buildSelectCafeteriaButton(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFoodItems(List<Food> foodItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: foodItems.map((food) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(food.image),
          ),
          title: Text(food.name),
          subtitle: Text('Price: NGN ${food.price}'),
          trailing: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                if (selectedItems.containsKey(food)) {
                  selectedItems[food] = selectedItems[food]! + 1;
                } else {
                  selectedItems[food] = 1;
                }
              });
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDrinkItems(List<Food> drinks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: drinks.map((drink) {
        return RadioListTile<Food>(
          title: Text(drink.name),
          subtitle: Text('Price: NGN ${drink.price}'),
          value: drink,
          groupValue: selectedDrink,
          onChanged: (value) {
            setState(() {
              selectedDrink = value;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildSelectedItems() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selected Items:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: selectedItems.entries.map((entry) {
              final food = entry.key;
              final quantity = entry.value;
              return Text('${food.name} (Quantity: $quantity)');
            }).toList(),
          ),
          if (selectedDrink != null) Text(selectedDrink!.name),
        ],
      ),
    );
  }

  Widget _buildSelectCafeteriaButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          _selectCafeteria();
        },
        child: const Text('Select Cafeteria'),
      ),
    );
  }

  void _selectCafeteria() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Cafeteria'),
        content:
         Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCafeteriaRadioButton('ASO Cafeteria'),
            _buildCafeteriaRadioButton('Male Uni Cafeteria'),
            _buildCafeteriaRadioButton('Female Uni Cafeteria'),
            _buildCafeteriaRadioButton('Eng Building Cafe'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildCafeteriaRadioButton(String cafeteria) {
    return RadioListTile<String>(
      title: Text(cafeteria),
      value: cafeteria,
      groupValue: selectedCafeteria,
      onChanged: (value) {
        setState(() {
          selectedCafeteria = value;
          Navigator.of(context).pop();
          _showOrderSummary();
        });
      },
    );
  }

  void _showOrderSummary() {
    String selectedItemsString = selectedItems.entries.map((entry) {
      final food = entry.key;
      final quantity = entry.value;
      return '${food.name} (Quantity: $quantity)';
    }).join(', ');

    String selectedDrinkString =
        selectedDrink != null ? selectedDrink!.name : 'No drink selected';
    String selectedCafeteriaString =
        selectedCafeteria ?? 'No cafeteria selected';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Summary'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Food Items: $selectedItemsString'),
            Text('Drink: $selectedDrinkString'),
            Text('Cafeteria: $selectedCafeteriaString'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
