import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  var name = 'Sapphire'.obs;
  var email = 'nomnom@gmail.com'.obs;
  var selectedPaymentMethod = 'Cash'.obs;
  var reminderNotif = false.obs;
  var favoriteOpenNotif = false.obs;

  void changeName(String newName) {
    name.value = newName;
  }

  void changeEmail(String newEmail) {
    email.value = newEmail;
  }

  void changePaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void toggleReminderNotif(bool value) {
    reminderNotif.value = value;
  }

  void toggleFavoriteOpenNotif(bool value) {
    favoriteOpenNotif.value = value;
  }

  void logout() {
    Get.offAllNamed('/splash');
  }

  void deleteAccount() {
    // Simulate account deletion
    Get.offAllNamed('/splash');
  }
}
