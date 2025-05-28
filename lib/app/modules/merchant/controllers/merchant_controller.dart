import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MerchantController extends GetxController {
  final merchantName = 'MagicKitchen'.obs;
  final rating = 4.5.obs;

  final featuredItems = [
    MenuItem(name: 'Chicken Roll', imageUrl: 'assets/images/chicken_roll.jpg'),
    MenuItem(name: 'Beef Burger', imageUrl: 'assets/images/beef_burger.jpg'),
  ];

  final mostPopularItems = [
    MenuItem(name: 'Grilled Chicken', imageUrl: 'assets/images/grilled_chicken.jpg'),
    MenuItem(name: 'Salad Bowl', imageUrl: 'assets/images/salad_bowl.jpg'),
  ];
}

class MenuItem {
  final String name;
  final String imageUrl;

  MenuItem({required this.name, required this.imageUrl});
}
