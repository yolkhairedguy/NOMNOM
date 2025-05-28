import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/rating_controller.dart';

class RatingView extends StatelessWidget {
  final controller = Get.put(RatingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ratings and Reviews', style: TextStyle(fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Obx(() => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: List.generate(5, (index) {
                    final rating = 5 - index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(rating.toStringAsFixed(1)),
                          ],
                        ),
                        selected: controller.selectedRating.value == rating,
                        onSelected: (_) => controller.selectRating(rating.toDouble()),
                        selectedColor: Colors.amber.shade100,
                        backgroundColor: Colors.white,
                        shape: StadiumBorder(
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    );
                  }),
                ),
              )),
          const SizedBox(height: 12),
          Expanded(
            child: Obx(() {
              final reviews = controller.filteredReviews;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(review.avatarUrl),
                              radius: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(review.userName, style: const TextStyle(fontWeight: FontWeight.w600)),
                                  Row(
                                    children: [
                                      Row(
                                        children: List.generate(5, (i) {
                                          return Icon(
                                            i < review.rating ? Icons.star : Icons.star_border,
                                            size: 16,
                                            color: Colors.amber,
                                          );
                                        }),
                                      ),
                                      const SizedBox(width: 6),
                                      Text('• ${review.timeAgo}', style: const TextStyle(fontSize: 12)),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(review.comment),
                        const SizedBox(height: 8),
                        Text(
                          '🍴 ${review.items.join(', ')}',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
