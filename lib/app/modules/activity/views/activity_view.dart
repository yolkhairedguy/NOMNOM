import 'package:flutter/material.dart';
import '../../../widgets/custom_nav_bar.dart';

class ActivityView extends StatefulWidget {
  const ActivityView({Key? key}) : super(key: key);

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Orders',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _tabController.animateTo(0),
                      child: TabButton(
                        text: 'On Going',
                        isSelected: _tabController.index == 0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _tabController.animateTo(1),
                      child: TabButton(
                        text: 'History',
                        isSelected: _tabController.index == 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                OnGoingTab(),
                HistoryTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}

class TabButton extends StatelessWidget {
  final String text;
  final bool isSelected;

  const TabButton({
    Key? key,
    required this.text,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isSelected ? Colors.black : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.grey[600],
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}

class OnGoingTab extends StatelessWidget {
  const OnGoingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '9 January 2025',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          OnGoingOrderCard(
            imagePath: 'assets/images/nasigoreng.jpg',
            title: 'Kedai Bu Tika',
            subtitle: 'Nasi Goreng Udang +2 more',
            price: 'Rp. 12.000',
            currentStep: 2,
          ),
          const SizedBox(height: 15),
          OnGoingOrderCard(
            imagePath: 'assets/images/muffin.jpg',
            title: 'Kedai Mami Lita',
            subtitle: 'Chocochips Muffin',
            price: 'Rp. 2.000',
            currentStep: 1,
          ),
        ],
      ),
    );
  }
}

class HistoryTab extends StatelessWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '9 January 2025',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          HistoryOrderCard(
            imagePath: 'assets/images/nasigoreng.jpg',
            title: 'Kedai Bu Tika',
            subtitle: 'Nasi Goreng Udang +2 more',
            price: 'Rp. 12.000',
            items: const [
              OrderItem(name: 'Nasi Goreng', price: 'Rp. 7000', quantity: 1),
              OrderItem(name: 'Kerupuk', price: 'Rp. 1000', quantity: 2),
            ],
            total: 'Rp. 9000',
            status: 'Paid',
            orderedOn: '26/01/2025',
          ),
          const SizedBox(height: 15),
          HistoryOrderCard(
            imagePath: 'assets/images/muffin.jpg',
            title: 'Kedai Mami Lita',
            subtitle: 'Chocochips Muffin',
            price: 'Rp. 2.000',
            items: const [
              OrderItem(name: 'Chocochips Muffin', price: 'Rp. 2000', quantity: 1),
            ],
            total: 'Rp. 2000',
            status: 'Paid',
            orderedOn: '26/01/2025',
          ),
          const SizedBox(height: 30),
          const Text(
            '9 January 2025',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          HistoryOrderCard(
            imagePath: 'assets/images/nasigoreng.jpg',
            title: 'Kedai Bu Tika',
            subtitle: 'Nasi Goreng Udang +2 more',
            price: 'Rp. 12.000',
            items: const [
              OrderItem(name: 'Nasi Goreng Udang', price: 'Rp. 10000', quantity: 1),
              OrderItem(name: 'Kerupuk', price: 'Rp. 1000', quantity: 2),
            ],
            total: 'Rp. 12000',
            status: 'Paid',
            orderedOn: '26/01/2025',
          ),
          const SizedBox(height: 15),
          HistoryOrderCard(
            imagePath: 'assets/images/muffin.jpg',
            title: 'Kedai Mami Lita',
            subtitle: 'Chocochips Muffin',
            price: 'Rp. 2.000',
            items: const [
              OrderItem(name: 'Chocochips Muffin', price: 'Rp. 2000', quantity: 1),
            ],
            total: 'Rp. 2000',
            status: 'Paid',
            orderedOn: '26/01/2025',
          ),
        ],
      ),
    );
  }
}

class OnGoingOrderCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String price;
  final int currentStep;

  const OnGoingOrderCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.orange[100],
                        child: const Icon(
                          Icons.fastfood,
                          color: Colors.orange,
                          size: 30,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Colors.grey),
          const SizedBox(height: 20),
          OrderProgressIndicator(currentStep: currentStep),
        ],
      ),
    );
  }
}

class HistoryOrderCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String price;
  final List<OrderItem> items;
  final String total;
  final String status;
  final String orderedOn;

  const HistoryOrderCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.items,
    required this.total,
    required this.status,
    required this.orderedOn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetails(
              items: items,
              total: total,
              status: status,
              orderedOn: orderedOn,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.orange[100],
                      child: const Icon(
                        Icons.fastfood,
                        color: Colors.orange,
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5C842),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Details',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderProgressIndicator extends StatelessWidget {
  final int currentStep;

  const OrderProgressIndicator({
    Key? key,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: currentStep >= 1 ? const Color(0xFFF5C842) : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Order\nconfirmed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: currentStep >= 1 ? Colors.black : Colors.grey[500],
                  fontWeight: currentStep >= 1 ? FontWeight.w500 : FontWeight.normal,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 2,
            color: currentStep >= 1 ? const Color(0xFFF5C842) : Colors.grey[300],
            margin: const EdgeInsets.only(bottom: 35),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: currentStep >= 2 ? const Color(0xFFF5C842) : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Payment\nconfirmed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: currentStep >= 2 ? Colors.black : Colors.grey[500],
                  fontWeight: currentStep >= 2 ? FontWeight.w500 : FontWeight.normal,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 2,
            color: currentStep >= 2 ? const Color(0xFFF5C842) : Colors.grey[300],
            margin: const EdgeInsets.only(bottom: 35),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: currentStep >= 3 ? Colors.black : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Order\ntaken',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: currentStep >= 3 ? Colors.black : Colors.grey[500],
                  fontWeight: currentStep >= 3 ? FontWeight.w500 : FontWeight.normal,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Model for order items
class OrderItem {
  final String name;
  final String price;
  final int quantity;

  const OrderItem({
    required this.name,
    required this.price,
    required this.quantity,
  });
}

// Order Details Page
class OrderDetails extends StatefulWidget {
  final List<OrderItem> items;
  final String total;
  final String status;
  final String orderedOn;

  const OrderDetails({
    Key? key,
    required this.items,
    required this.total,
    required this.status,
    required this.orderedOn,
  }) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  void _showReviewDialog() {
    showDialog(
      context: context,
      builder: (context) => ReviewDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Order Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Items List
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: widget.items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[200],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              item.name.contains('Nasi Goreng')
                                  ? 'assets/images/nasi_goreng.png'
                                  : 'assets/images/kerupuk.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.orange[100],
                                  child: const Icon(
                                    Icons.fastfood,
                                    color: Colors.orange,
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.price,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey[200],
                          child: Text(
                            item.quantity.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            // Order Summary
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ...widget.items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${item.name} x${item.quantity}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            item.price,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'TOTAL',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.total,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Status and Ordered On
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  widget.status,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ordered on',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  widget.orderedOn,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const Spacer(),
            // Write a Review Button
            Center(
              child: ElevatedButton(
                onPressed: _showReviewDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5C842),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Write a review',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}

// Review Dialog with Rating and Text Field
class ReviewDialog extends StatefulWidget {
  const ReviewDialog({Key? key}) : super(key: key);

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  void _submitReview() {
    Navigator.pop(context); // Close the review dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 50,
            ),
            SizedBox(height: 16),
            Text(
              'Thanks for your feedback!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Write a Review',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1;
                  });
                },
              );
            }),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _reviewController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Write your review here...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: _submitReview,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF5C842),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Send',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}