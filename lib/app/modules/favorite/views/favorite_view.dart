import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Model untuk merchant favorite
class FavoriteMerchant {
  final String id;
  final String name;
  final double rating;
  final List<String> categories;
  final String image;

  FavoriteMerchant({
    required this.id,
    required this.name,
    required this.rating,
    required this.categories,
    required this.image,
  });
}

// Controller untuk favorite page
class FavoritePageController extends GetxController {
  final RxList<FavoriteMerchant> favoriteMerchants = <FavoriteMerchant>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavoriteMerchants();
  }

  void loadFavoriteMerchants() {
    isLoading.value = true;
    
    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 500), () {
      favoriteMerchants.value = [
        FavoriteMerchant(
          id: '1',
          name: 'Kedai Bu Tika',
          rating: 4.8,
          categories: ['Lunch', 'Fried Rice'],
          image: 'assets/images/nasigoreng.jpg',
        ),
        FavoriteMerchant(
          id: '2',
          name: 'Miya Snacks',
          rating: 4.6,
          categories: ['Snack', 'Siomay'],
          image: 'assets/images/siomay1.png',
        ),
        FavoriteMerchant(
          id: '3',
          name: 'Ayam Geprek Jos',
          rating: 4.9,
          categories: ['Breakfast', 'Traditional'],
          image: 'assets/images/ayamgeprek.jpg',
        ),
        FavoriteMerchant(
          id: '4',
          name: 'SnackBites',
          rating: 4.7,
          categories: ['Snack'],
          image: 'assets/images/chickenpop.jpg',
        ),
        FavoriteMerchant(
          id: '5',
          name: 'Kedai Seblak Teteh',
          rating: 4.5,
          categories: ['Snack', 'Spicy'],
          image: 'assets/images/seblak.jpg',
        ),
        FavoriteMerchant(
          id: '6',
          name: 'Bakso Mang Ade',
          rating: 4.4,
          categories: ['Lunch', 'Meatball'],
          image: 'assets/images/bakso.jpg',
        ),
      ];
      isLoading.value = false;
    });
  }

  void removeFavorite(FavoriteMerchant merchant) {
    favoriteMerchants.remove(merchant);
    
    Get.snackbar(
      'Removed from Favorites',
      'Selected merchant removed from favorite',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      borderRadius: 8,
      borderColor: Colors.orange,
      borderWidth: 2,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
      icon: const Icon(
        Icons.warning,
        color: Colors.orange,
      ),
    );
  }

  void onMerchantTap(FavoriteMerchant merchant) {
    Get.snackbar(
      'Merchant Selected',
      'You tapped on ${merchant.name}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoritePageController controller = Get.put(FavoritePageController());

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
          'Favorite',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFFC107),
            ),
          );
        }

        if (controller.favoriteMerchants.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'No favorite merchants yet',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Add some merchants to your favorites!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85, // Increased ratio to reduce height
            ),
            itemCount: controller.favoriteMerchants.length,
            itemBuilder: (context, index) {
              final merchant = controller.favoriteMerchants[index];
              return MerchantCard(
                merchant: merchant,
                onTap: () => controller.onMerchantTap(merchant),
                onRemoveFavorite: () => controller.removeFavorite(merchant),
              );
            },
          ),
        );
      }),
    );
  }
}

class MerchantCard extends StatelessWidget {
  final FavoriteMerchant merchant;
  final VoidCallback onTap;
  final VoidCallback onRemoveFavorite;

  const MerchantCard({
    Key? key,
    required this.merchant,
    required this.onTap,
    required this.onRemoveFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section - Reduced flex
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.asset(
                      merchant.image,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Love Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onRemoveFavorite,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content Section - Reduced flex and padding
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Merchant Name
                    Text(
                      merchant.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFC107),
                          size: 12,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          merchant.rating.toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Categories
                    Expanded(
                      child: Wrap(
                        spacing: 3,
                        runSpacing: 2,
                        children: merchant.categories.take(2).map((category) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                fontSize: 9,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}