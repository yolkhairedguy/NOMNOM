import 'package:get/get.dart';

import '../modules/activity/bindings/activity_binding.dart';
import '../modules/activity/views/activity_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/merchant/bindings/merchant_binding.dart';
import '../modules/merchant/views/merchant_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/rating/bindings/rating_binding.dart';
import '../modules/rating/views/rating_view.dart';
import '../modules/receipt/bindings/receipt_binding.dart';
import '../modules/receipt/views/receipt_view.dart';
import '../modules/searchfood/bindings/searchfood_binding.dart';
import '../modules/searchfood/views/searchfood_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => const SignUpView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SignInView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITY,
      page: () => const ActivityView(),
      binding: ActivityBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MERCHANT,
      page: () => const MerchantView(),
      binding: MerchantBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.RATING,
      page: () => RatingView(),
      binding: RatingBinding(),
    ),
    GetPage(
      name: _Paths.RECEIPT,
      page: () => const ReceiptView(),
      binding: ReceiptBinding(),
    ),
    GetPage(
      name: _Paths.SEARCHFOOD,
      page: () => const SearchfoodView(),
      binding: SearchfoodBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => const FavoriteView(),
      binding: FavoriteBinding(),
    ),
  ];
}
