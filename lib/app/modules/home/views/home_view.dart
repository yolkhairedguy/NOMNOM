import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../widgets/custom_nav_bar.dart';

class HomeView extends GetView<HomeController> {
  final Color yellow = const Color(0xFFFFC83D);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with yellow background
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: yellow,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Good Morning,',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const Text(
                            'Sapphire!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'What would you like to eat today?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/favorite');
                            },
                            child: Icon(Icons.favorite_border, size: 24, color: Colors.black),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/cart');
                            },
                            child: Icon(Icons.shopping_cart_outlined, size: 24, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Search Bar
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Siomay',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/searchfood');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 8),

                  // Interactive Promo Banner Carousel
                  _PromoCarousel(),
                  const SizedBox(height: 32),

                  // Just For You
                  const Text(
                    'Just For You',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.justForYou.length,
                      itemBuilder: (context, index) {
                        final item = controller.justForYou[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('/merchant');
                          },
                          child: Container(
                            width: 200,
                            margin: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                  child: Image.asset(
                                    item.imageUrl,
                                    height: 140,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.star, color: Colors.amber, size: 16),
                                              const SizedBox(width: 4),
                                              Text(
                                                '4.8',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 6,
                                        runSpacing: 4,
                                        children: item.categories.map((tag) => TagChip(tag)).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Popular Dishes Nowadays
                  const Text(
                    'Popular Dishes Nowadays',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.popularItems.length,
                      itemBuilder: (context, index) {
                        final item = controller.popularItems[index];
                        return Container(
                          width: 140,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: Image.asset(
                                  item.imageUrl,
                                  height: 100,
                                  width: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          'Rp. ${item.price}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            _showAddToCartSnackbar(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: yellow,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              size: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Top Rated
                  const Text(
                    'Top Rated',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.topRated.length,
                      itemBuilder: (context, index) {
                        final merchant = controller.topRated[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('/merchant');
                          },
                          child: Container(
                            width: 300,
                            margin: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    merchant.imageUrl,
                                    height: 180,
                                    width: 300,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Dark overlay
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.7),
                                      ],
                                    ),
                                  ),
                                ),
                                // Love button
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: const _FavoriteButton(),
                                ),
                                // Content
                                Positioned(
                                  bottom: 16,
                                  left: 16,
                                  right: 16,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        merchant.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '"Menunya enak-enak!"',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star, 
                                            color: Colors.amber, 
                                            size: 18
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${merchant.rating.toStringAsFixed(1)}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 100), // Space for bottom nav
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }

  void _showAddToCartSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Added to cart',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.green, width: 1),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// Interactive Promo Carousel Widget
class _PromoCarousel extends StatefulWidget {
  @override
  State<_PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<_PromoCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  // List of promo images
  final List<String> _promoImages = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _promoImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    _promoImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 160,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback widget when image doesn't exist
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.orange.shade300,
                              Colors.red.shade400,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_offer,
                                size: 40,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Special Promo ${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Up to ${(index + 1) * 25}% Off!',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // Line indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_promoImages.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: index == _currentPage ? 20 : 8,
              height: 4,
              decoration: BoxDecoration(
                color: index == _currentPage ? const Color(0xFFE85A4F) : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// Separate Favorite Button Widget with its own state
class _FavoriteButton extends StatefulWidget {
  const _FavoriteButton();
  
  @override
  State<_FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<_FavoriteButton> {
  bool isFavorite = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          size: 20,
          color: isFavorite ? Colors.red : Colors.grey[600],
        ),
      ),
    );
  }
}

// Reusable TagChip Widget
class TagChip extends StatelessWidget {
  final String label;

  const TagChip(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
    );
  }
}