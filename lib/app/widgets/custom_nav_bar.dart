import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/nav_controllers.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  
  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavController navController = Get.find<NavController>();
    
    return Container(
      height: 70,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            icon: Icons.home,
            index: 0,
            isSelected: currentIndex == 0,
            onTap: () => navController.changeIndex(0),
          ),
          _buildNavItem(
            icon: Icons.receipt_long,
            index: 1,
            isSelected: currentIndex == 1,
            onTap: () => navController.changeIndex(1),
          ),
          _buildNavItem(
            icon: Icons.person,
            index: 2,
            isSelected: currentIndex == 2,
            onTap: () => navController.changeIndex(2),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFC83D) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey,
          size: 24,
        ),
      ),
    );
  }
}