import 'package:get/get.dart';

class CartItem {
  final String imageUrl;
  final String name;
  final int price;
  int quantity;
  bool selected;

  CartItem({
    required this.imageUrl,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.selected = false,
  });
}

class CartController extends GetxController {
  var cart = <String, List<CartItem>>{}.obs;

  void toggleItem(String merchant, int index) {
    cart[merchant]![index].selected = !cart[merchant]![index].selected;
    cart.refresh();
  }

  void increment(String merchant, int index) {
    cart[merchant]![index].quantity++;
    cart.refresh();
  }

  void decrement(String merchant, int index) {
    if (cart[merchant]![index].quantity > 1) {
      cart[merchant]![index].quantity--;
      cart.refresh();
    }
  }

  void deleteItem(String merchant, int index) {
    cart[merchant]!.removeAt(index);
    if (cart[merchant]!.isEmpty) {
      cart.remove(merchant);
    }
    cart.refresh();
  }

  int get total {
    int sum = 0;
    cart.forEach((merchant, items) {
      for (var item in items) {
        if (item.selected) {
          sum += item.price * item.quantity;
        }
      }
    });
    return sum;
  }

  @override
  void onInit() {
    cart['Kedai Bu Tika'] = [
      CartItem(name: 'Nasi Goreng Udang', imageUrl: 'assets/images/nasigoreng.jpg', price: 7000),
      CartItem(name: 'Kerupuk', imageUrl: 'assets/images/kerupuk.jpg', price: 1000),
    ];
    cart['Kedai Mami Lita'] = [
      CartItem(name: 'Sus buah', imageUrl: 'assets/images/susbuah.png', price: 3000),
      CartItem(name: 'Cookies', imageUrl: 'assets/images/cookies.png', price: 3000),
    ];
    super.onInit();
  }
}
