import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutView extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;
  final double total;

  const CheckoutView({
    Key? key,
    this.selectedItems = const [],
    this.total = 0.0,
  }) : super(key: key);

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final Color yellow = const Color(0xFFFFC83D);
  int selectedPaymentMethod = 0; // 0 for GoPay, 1 for Cash

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Items Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Order Items',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...widget.selectedItems.isEmpty 
                        ? [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Center(
                                child: Text(
                                  'No items selected',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ),
                          ]
                        : widget.selectedItems.asMap().entries.map((entry) {
                          int index = entry.key;
                          Map<String, dynamic> item = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(bottom: index == widget.selectedItems.length - 1 ? 0 : 16),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item['imageUrl'],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.grey[300]!),
                                        ),
                                        child: const Icon(Icons.fastfood, color: Colors.grey),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'From: ${item['merchant']}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Text(
                                        'Rp. ${item['price']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${item['quantity']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Order Summary Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Order Summary',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...widget.selectedItems.isEmpty
                        ? [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Center(
                                child: Text(
                                  'No items to summarize',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ),
                          ]
                        : widget.selectedItems.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '${item['name']} x${item['quantity']}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                'Rp. ${(item['price'] * item['quantity']).toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                        const Divider(),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Rp. ${widget.total.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Payment Method Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Payment Method',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // GoPay Option
                        GestureDetector(
                          onTap: () => setState(() => selectedPaymentMethod = 0),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: selectedPaymentMethod == 0 ? yellow.withOpacity(0.1) : Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selectedPaymentMethod == 0 ? yellow : Colors.grey[300]!,
                                width: selectedPaymentMethod == 0 ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Radio<int>(
                                  value: 0,
                                  groupValue: selectedPaymentMethod,
                                  onChanged: (value) => setState(() => selectedPaymentMethod = value!),
                                  activeColor: yellow,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00AED5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.account_balance_wallet,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'GoPay',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                if (selectedPaymentMethod == 0)
                                  Icon(Icons.check_circle, color: yellow, size: 20),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        // Cash Option
                        GestureDetector(
                          onTap: () => setState(() => selectedPaymentMethod = 1),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: selectedPaymentMethod == 1 ? yellow.withOpacity(0.1) : Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selectedPaymentMethod == 1 ? yellow : Colors.grey[300]!,
                                width: selectedPaymentMethod == 1 ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Radio<int>(
                                  value: 1,
                                  groupValue: selectedPaymentMethod,
                                  onChanged: (value) => setState(() => selectedPaymentMethod = value!),
                                  activeColor: yellow,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.payments,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Cash',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                if (selectedPaymentMethod == 1)
                                  Icon(Icons.check_circle, color: yellow, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // Space for bottom section
                ],
              ),
            ),
          ),
          
          // Bottom Total and Checkout Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total (${widget.selectedItems.length} items)',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Rp. ${widget.total.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _showCheckoutDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellow,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCheckoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              const SizedBox(width: 12),
              const Text('Order Confirmed!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Payment method: ${selectedPaymentMethod == 0 ? "GoPay" : "Cash"}'),
              const SizedBox(height: 8),
              Text('Total: Rp. ${widget.total.toStringAsFixed(0)}'),
              const SizedBox(height: 8),
              Text('Items: ${widget.selectedItems.length}'),
              const SizedBox(height: 8),
              const Text('Your order has been placed successfully!'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to cart page
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}