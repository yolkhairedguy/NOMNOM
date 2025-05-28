import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Model untuk produk siomay
class SiomayProduct {
  final String id;
  final String name;
  final String store;
  final int price;
  final double rating;
  final String image;

  SiomayProduct({
    required this.id,
    required this.name,
    required this.store,
    required this.price,
    required this.rating,
    required this.image,
  });
}

// Controller untuk search page
class SearchController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();
  final RxString searchQuery = ''.obs;
  final RxList<SiomayProduct> searchResults = <SiomayProduct>[].obs;
  final RxBool isLoading = false.obs;

  // Dummy data siomay
  final List<SiomayProduct> allProducts = [
    SiomayProduct(
      id: '1',
      name: 'Siomay Bandung',
      store: "Miya Snacks",
      price: 7000,
      rating: 4.7,
      image: 'assets/images/siomay1.png',
    ),
    SiomayProduct(
      id: '2',
      name: 'Siomay Mix',
      store: 'Yumyum',
      price: 5000,
      rating: 4.6,
      image: 'assets/images/siomay2.png',
    ),
    SiomayProduct(
      id: '3',
      name: 'Siomay Spesial',
      store: 'Kedai Jono',
      price: 10000,
      rating: 4.8,
      image: 'assets/images/siomay3.png',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    // Set initial search query dan results
    searchQuery.value = 'Siomay';
    searchProducts('Siomay');
    
    // Listen to search text changes
    searchTextController.addListener(() {
      searchQuery.value = searchTextController.text;
      searchProducts(searchTextController.text);
    });
  }

  void searchProducts(String query) {
    isLoading.value = true;
    
    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (query.isEmpty) {
        searchResults.clear();
      } else {
        searchResults.value = allProducts
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()) ||
                product.store.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      isLoading.value = false;
    });
  }

  void onProductTap(SiomayProduct product) {
    // Handle product tap
    Get.snackbar(
      'Product Selected',
      'You tapped on ${product.name}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onAddToCart(SiomayProduct product) {
    // Handle add to cart
    Get.snackbar(
      'Added to Cart',
      '${product.name} has been added to your cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      borderRadius: 8,
      borderColor: Colors.green,
      borderWidth: 2,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
      icon: const Icon(
        Icons.check_circle,
        color: Colors.green,
      ),
    );
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}

class SearchfoodView extends StatelessWidget {
  const SearchfoodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchController controller = Get.put(SearchController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: controller.searchTextController,
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC107),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          
          // Search Results
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFFFC107),
                  ),
                );
              }

              if (controller.searchResults.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No products found',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  final product = controller.searchResults[index];
                  return ProductCard(
                    product: product,
                    onTap: () => controller.onProductTap(product),
                    onAddToCart: () => controller.onAddToCart(product),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final SiomayProduct product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Product Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      // Gambar utama dari assets
                      Image.asset(
                        product.image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback jika gambar tidak ditemukan
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.orange.shade200,
                                  Colors.orange.shade400,
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.restaurant,
                              color: Colors.white,
                              size: 32,
                            ),
                          );
                        },
                      ),
                      
                      // Rating overlay
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 12,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                product.rating.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.store,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rp. ${product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Add to Cart Button
              GestureDetector(
                onTap: onAddToCart,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC107),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}