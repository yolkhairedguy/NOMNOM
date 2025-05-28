import 'package:get/get.dart';

import '../controllers/searchfood_controller.dart';

class SearchfoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchfoodController>(
      () => SearchfoodController(),
    );
  }
}
