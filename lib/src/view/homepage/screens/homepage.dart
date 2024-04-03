import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:food_delivery_app/core/widgets/app_extension.dart';
import 'package:food_delivery_app/core/fire_cloud/auth/auth_controller/authcontroller.dart';

import 'package:food_delivery_app/core/fire_cloud/model/model_controller.dart';

import 'package:food_delivery_app/core/utils/colors.dart';
import 'package:food_delivery_app/core/utils/page_transition.dart';
import 'package:get/get.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../core/widgets/rich_text.dart';
import '../../../../core/widgets/searchBar.dart';

import '../../foods/views/food_screen.dart';

import '../../foods/views/food_page.dart';
import '../widgets/caroul_model.dart';
import '../widgets/carousel_slider.dart';
import '../widgets/category_card.dart';

import '../widgets/recent_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedValue = 'Aso Cafe';
  final CarouselController _controller = CarouselController();
  int currentPage = 0;
  String _chosenCafe = '';
  final userController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return PageTransition(
      child: SafeArea(
        child: Scaffold(
          appBar: customAppbar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: SizedBox(
                        width: 250,
                        child: DropdownButton(
                          value: _selectedValue,
                          items: const [
                            DropdownMenuItem(
                              value: "Aso Cafe",
                              child: Text("Aso Cafe"),
                            ),
                            DropdownMenuItem(
                              value: "Male Uni. Hostel Cafe",
                              child: Text("Male Uni. Hostel Cafe"),
                            ),
                            DropdownMenuItem(
                              value: "Female Uni. Hostel cafe",
                              child: Text("Female Uni. Hostel cafe"),
                            ),
                            DropdownMenuItem(
                              value: "Engineering Building Cafe",
                              child: Text("Engineering Building Cafe"),
                            ),
                          ],
                          icon: Image.asset(
                            Helper.getAssetName(
                                "dropdown_filled.png", "virtual"),
                          ),
                          style: appStyle(
                              color: AppColor.primary,
                              size: 15,
                              fw: FontWeight.bold),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedValue =
                                  value ?? ""; // Update _selectedValue
                              _chosenCafe = _selectedValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ).fadeAnimation(0.2),
                  const SearchWidget().fadeAnimation(0.2),
                  const SizedBox(
                    height: 10,
                  ),
                  CarouselSlider.builder(
                    carouselController: _controller,
                    itemCount: carouselList.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      final item = carouselList[itemIndex];
                      return CarouselSliderWidget(item: item);
                    },
                    options: CarouselOptions(
                        height: 155,
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        onPageChanged: (val, _) {
                          setState(() {
                            currentPage = val;
                          });
                        }),
                  ).fadeAnimation(0.4),
                  CarouselDot(
                    currentPage: currentPage,
                    controller: _controller,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: appStyle(
                              color: AppColor.orange,
                              size: 16,
                              fw: FontWeight.w600),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const FoodHomePage());
                          },
                          child: const Text("View all"),
                        ),
                      ],
                    ),
                  ).fadeAnimation(0.5),
                  Container(
                    height: 150,
                    // width: double.infinity,
                    padding: const EdgeInsets.only(left: 5),
                    child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: ModelController.foodCartegoryList
                            .map((e) => InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (__) {
                                    return FoodsScreen(category: e);
                                  }));
                                },
                                child: Center(
                                  child: _buildCategoryCard(
                                      e.image, e.categoryName),
                                )))
                            .toList()),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Food",
                          style: Helper.getTheme(context).headlineSmall,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const FoodHomePage());
                          },
                          child: const Text("View all"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            //  Get.to(() => FoodAbout(foodItem: foodList));
                          },
                          child: RecentItemCard(
                            image: Image.asset(
                              Helper.getAssetName("pizza3.jpg", "real"),
                              fit: BoxFit.cover,
                            ),
                            name: "Mulberry Pizza by Josh",
                            cafe: _chosenCafe.isEmpty
                                ? "Aso Cafe" // Default display if no cafe is chosen
                                : _chosenCafe, // Display the chosen cafe
                          ),
                        ).fadeAnimation(0.6),
                        RecentItemCard(
                          image: Image.asset(
                            Helper.getAssetName("coffee.jpg", "real"),
                            fit: BoxFit.cover,
                          ),
                          name: "Barita",
                          cafe: _chosenCafe.isEmpty
                              ? "Aso Cafe" // Default display if no cafe is chosen
                              : _chosenCafe, // Display the chosen cafe
                        ),
                        RecentItemCard(
                          image: Image.asset(
                            Helper.getAssetName("pizza.jpg", "real"),
                            fit: BoxFit.cover,
                          ),
                          name: "Pizza Rush Hour",
                          cafe: _chosenCafe.isEmpty
                              ? "Aso Cafe" // Default display if no cafe is chosen
                              : _chosenCafe, // Display the chosen cafe
                        ),
                      ],
                    ).fadeAnimation(0.7),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar customAppbar() {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              userController.logout();
            },
            child: CircleAvatar(
              backgroundColor: AppColor.orange,
              child: Image.asset(
                Helper.getAssetName('user.png', 'virtual'),
                color: Colors.white,
              ),
            ),
          ),
          const AppRichText(
            title: 'Hi,',
            subtitle: ' Mayowa!',
            subColor: AppColor.orange,
          ),
          InkWell(
            onTap: () {},
            child: Badge(
              badgeStyle: const BadgeStyle(elevation: 2),
              badgeContent: const Text(
                '1',
                style: TextStyle(color: Colors.white),
              ),
              child: Image.asset(Helper.getAssetName("cart.png", "virtual")),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    String imageName,
    String categoryName,
  ) {
    return CategoryCard(
        image: Image.asset(
          Helper.getAssetName(imageName, "real"),
          fit: BoxFit.cover,
        ),
        name: categoryName);
  }
}
