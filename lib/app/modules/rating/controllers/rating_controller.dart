import 'package:get/get.dart';

class Review {
  final String userName;
  final String avatarUrl;
  final double rating;
  final String comment;
  final String timeAgo;
  final List<String> items;

  Review({
    required this.userName,
    required this.avatarUrl,
    required this.rating,
    required this.comment,
    required this.timeAgo,
    required this.items,
  });
}

class RatingController extends GetxController {
  var selectedRating = 0.0.obs;

  List<Review> allReviews = [
    Review(
      userName: 'Mogari S.',
      avatarUrl: 'assets/images/avatar1.png',
      rating: 5.0,
      comment: 'Sus buahnya uenak POL 💜',
      timeAgo: '1 day ago',
      items: ['Sus Buah', 'Bomboloni Coklat', 'Item lainnya'],
    ),
    Review(
      userName: 'Soobin C.',
      avatarUrl: 'assets/images/avatar2.png',
      rating: 5.0,
      comment: 'DESSERT MAMI LITA RASANYA GA PERNAH GAGAL 🖐️😵🖐️',
      timeAgo: '1 day ago',
      items: ['Bomboloni Matcha', 'Cookies', 'Item lainnya'],
    ),
    Review(
      userName: 'Sapphire N.',
      avatarUrl: 'assets/images/avatar3.jpg',
      rating: 4.0,
      comment: 'Strawberry muffinnya enak! Buahnya kerasa banget 😋',
      timeAgo: '2 days ago',
      items: ['Strawberry Muffin', 'Cookies Matcha'],
    ),
  ];

  List<Review> get filteredReviews {
    if (selectedRating.value == 0.0) return allReviews;
    return allReviews.where((r) => r.rating == selectedRating.value).toList();
  }

  void selectRating(double rating) {
    selectedRating.value = selectedRating.value == rating ? 0.0 : rating;
  }
}
