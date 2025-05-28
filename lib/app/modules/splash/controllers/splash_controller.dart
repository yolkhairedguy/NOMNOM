import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nomnom/app/routes/app_pages.dart';

class SplashController extends GetxController {
  
  void goToOnboarding() {
    Get.offNamed(Routes.ONBOARDING);
  }
  
  @override
  void onInit() {
    super.onInit();
  }
}