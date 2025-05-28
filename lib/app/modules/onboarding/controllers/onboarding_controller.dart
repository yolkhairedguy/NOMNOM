import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      currentPage.value++;
    }
  }

  void prevPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  final List<Map<String, dynamic>> pages = [
    {
      'title': 'Need a quick meal?',
      'subtitle': "Don't fret!",
      'highlight': "We got you!",
      'image': 'assets/icon/3d/hamburger.png',
      'color': const Color(0xFFE74C3C),
    },
    {
      'title': 'BEEP BEEP!',
      'subtitle': '"Oh no! I need a reminder!"',
      'highlight': "One tap and it's settled.",
      'image': 'assets/icon/3d/meat.png',
      'color': const Color(0xFFF9CA24),
    },
    {
      'title': 'One step closer to your',
      'subtitle': 'delightful journey.',
      'highlight': "Sign up now ;)",
      'image': 'assets/icon/3d/salad.png',
      'color': const Color(0xFF3498DB),
      'hasSignUpButton': true,
    },
  ];
}