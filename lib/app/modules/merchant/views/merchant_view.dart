import 'package:flutter/material.dart';

class MerchantView extends StatefulWidget {
  const MerchantView({super.key});

  @override
  State<MerchantView> createState() => _MerchantViewState();
}

class _MerchantViewState extends State<MerchantView> {
  String _selectedCategory = 'All';
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Sticky Header
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                // Navigate to home page
                _navigateToHome();
              },
            ),
            title: const Text(
              'Kedai Mami Lita',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border, 
                  color: Colors.red
                ),
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                  _showSuccessSnackBar(_isFavorite ? 'Added to favorite.' : 'Removed from favorite.');
                },
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
                onPressed: () {
                  // Navigate to cart page
                  _navigateToCart();
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Header Profile
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      'assets/images/headermamilita.png',
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: -25,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kedai Mami Lita',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      ' • Dessert • Beverages',
                                      style: TextStyle(fontSize: 11, color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              _buildRatingBadge(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),

                // Section: Featured Items
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Text(
                        'Featured Items',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const Spacer(),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                
                // Featured Items with Fade Effect
                SizedBox(
                  height: 180,
                  child: Stack(
                    children: [
                      ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        children: [
                          _buildFeaturedItem('Sus buah', '3000', 'assets/images/susbuah.png'),
                          const SizedBox(width: 12),
                          _buildFeaturedItem('Cookies', '3000', 'assets/images/cookies.png'),
                          const SizedBox(width: 12),
                          _buildFeaturedItem('Strawberry Cookies', '3500', 'assets/images/cookiesstroberi.png'),
                        ],
                      ),
                      // Fade effect on the right
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 20,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.grey[50]!.withOpacity(0),
                                Colors.grey[50]!,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Section: Most Popular
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Most Popular',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Categories Filter
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryChip('All'),
                        const SizedBox(width: 8),
                        _buildCategoryChip('Dessert'),
                        const SizedBox(width: 8),
                        _buildCategoryChip('Beverages'),
                        const SizedBox(width: 8),
                        _buildCategoryChip('Other'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Most Popular Items in Grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildFoodCard('Sus buah', '3000', 'assets/images/headermamilita.png', 'Dessert'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFoodCard('Cookies', '3500', 'assets/images/headermamilita.png', 'Dessert'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.green, width: 1),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _navigateToHome() {
    // Pilihan 1: Pop back (jika MerchantView dipush dari halaman sebelumnya)
    Navigator.pushNamed(context, '/home');
    
    // Pilihan 2: Jika menggunakan named routes
    // Navigator.pushReplacementNamed(context, '/home');
    
    // Pilihan 3: Jika ingin kembali ke root
    // Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _navigateToCart() {
    // Pilihan 1: Menggunakan named routes (recommended)
    Navigator.pushNamed(context, '/cart');
    
    // Pilihan 2: Menggunakan MaterialPageRoute langsung
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => CartView()),
    // );
  }

  void _navigateToRating() {
    // Pilihan 1: Menggunakan named routes (recommended)
    Navigator.pushNamed(context, '/rating');
    
    // Pilihan 2: Menggunakan MaterialPageRoute langsung
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => RatingView()),
    // );
  }

  Widget _buildRatingBadge() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFD32F2F), Color(0xFFB71C1C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: Colors.yellow, size: 14),
              const SizedBox(width: 2),
              const Text(
                '4.8 (10+)',
                style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: GestureDetector(
            onTap: () {
              _navigateToRating();
            },
            child: const Text(
              'See Reviews',
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedItem(String name, String price, String imagePath) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(6),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 110,
                      color: Colors.grey[200],
                      child: const Icon(Icons.fastfood, color: Colors.orange, size: 30),
                    );
                  },
                ),
              ),
              const SizedBox(height: 6),
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                '\Rp$price',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {
                _showSuccessSnackBar('Added to cart.');
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCard(String name, String price, String imagePath, String category) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.asset(
                  imagePath,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 100,
                      color: Colors.grey[200],
                      child: const Icon(Icons.fastfood, color: Colors.orange, size: 30),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '\Rp$price',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                _showSuccessSnackBar('Added to cart.');
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    bool isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}