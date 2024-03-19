import '../../../../core/utils/helpers.dart';

class CarouselModel {
  String title;
  String image;
  String subtitle;
  CarouselModel(
      {required this.title, required this.image, required this.subtitle});
}

List<CarouselModel> carouselList = [
  CarouselModel(
      title: 'Fried Rice',
      image: Helper.getAssetName("fried.jpg", "virtual"),
      subtitle: 'Delicious and savory rice dish.'),
  CarouselModel(
      title: 'Jollof Rice',
      image: Helper.getAssetName("jollof.jpg", "virtual"),
      subtitle: 'Flavorful and aromatic rice dish.'),
  CarouselModel(
      title: 'Noodle Soup',
      image: Helper.getAssetName("jollof1.jpg", "virtual"),
      subtitle: 'Warm and comforting noodle soup.'),
  CarouselModel(
      title: 'Salad Bowl',
      image: Helper.getAssetName("fried1.jpg", "virtual"),
      subtitle: 'Fresh and crisp salad bowl.'),
];
