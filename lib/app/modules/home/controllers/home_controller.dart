import 'package:get/get.dart';

class Merchant {
  final String name;
  final String imageUrl;
  final double rating;
  final List<String> categories;
  final int price;

  Merchant({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.categories,
    required this.price,
  });
}

class HomeController extends GetxController {
  final merchants = <Merchant>[
    Merchant(
      name: 'Kedai Bu Tika',
      imageUrl: 'assets/images/headerbutika.png',
      rating: 4.8,
      categories: ['Lunch', 'Fried Rice'],
      price: 7000,
    ),
    Merchant(
      name: 'Kedai Mami Lita',
      imageUrl: 'assets/images/headermamilita.png',
      rating: 4.2,
      categories: ['Beverages', 'Dessert'],
      price: 18000,
    ),
    Merchant(
      name: 'Snack Miya',
      imageUrl: 'assets/images/siomay1.png',
      rating: 4.9,
      categories: ['Snack'],
      price: 7000,
    ),
    Merchant(
      name: 'Strawberry Cookies',
      imageUrl: 'assets/images/cookiesstroberi.png',
      rating: 4.7,
      categories: ['Dessert'],
      price: 3500,
    ),
    Merchant(
      name: 'Ayam Geprek Jos',
      imageUrl: 'assets/images/ayamgeprek.jpg',
      rating: 4.5,
      categories: ['Dessert'],
      price: 10000,
    ),
    Merchant(
      name: 'Chocochips Muffin',
      imageUrl: 'assets/images/muffin.jpg',
      rating: 4.5,
      categories: ['Dessert'],
      price: 3000,
    ),
    Merchant(
      name: 'Sus Buah',
      imageUrl: 'assets/images/susbuah.png',
      rating: 4.5,
      categories: ['Dessert'],
      price: 3000,
    ),
  ];

  // Top rated: rating >= 4.8
  List<Merchant> get topRated => merchants.where((m) => m.rating >= 4.8).toList();

  // Just For You: kategori Lunch/Dessert secara acak (simulasi)
  List<Merchant> get justForYou =>
      merchants.where((m) => m.categories.contains('Lunch') || m.categories.contains('Dessert')).toList();

  // Yang Lagi Populer: semua item dengan harga < 5000
  List<Merchant> get popularItems =>
      merchants.where((m) => m.price <= 5000).toList();
}
