import 'package:get/get.dart';
import '../routes/app_pages.dart';

class NavController extends GetxController {
  var selectedIndex = 0.obs;
  
  void changeIndex(int index) {
    selectedIndex.value = index;
    
    // Navigate to different routes based on index
    switch (index) {
      case 0:
        Get.offAllNamed(Routes.HOME);
        break;
      case 1:
        Get.offAllNamed(Routes.ACTIVITY);
        break;
      case 2:
        Get.offAllNamed(Routes.PROFILE);
        break;
    }
  }
}