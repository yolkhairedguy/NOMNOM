import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../../checkout/views/checkout_view.dart';

class CartView extends StatelessWidget {
  final controller = Get.put(CartController());

  CartView({super.key});

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
          'Shopping Cart',
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
            child: Obx(() {
              if (controller.cart.isEmpty) {
                return const Center(
                  child: Text(
                    "Your cart is empty 😢",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: controller.cart.entries.map((entry) {
                  final merchant = entry.key;
                  final items = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          merchant,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...items.asMap().entries.map((e) {
                          final index = e.key;
                          final item = e.value;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Dismissible(
                              key: Key('${merchant}_${index}_${item.name}'),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) async {
                                // Show confirmation dialog
                                return await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Delete Item'),
                                      content: Text('Remove "${item.name}" from cart?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(true),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                          ),
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                ) ?? false;
                              },
                              onDismissed: (direction) {
                                controller.deleteItem(merchant, index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${item.name} removed from cart'),
                                    duration: const Duration(seconds: 2),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: () {
                                        // Add back the item (you might need to implement this in controller)
                                        // controller.addItem(merchant, item);
                                      },
                                    ),
                                  ),
                                );
                              },
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey[200]!,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Checkbox
                                    Checkbox(
                                      value: item.selected,
                                      onChanged: (_) => controller.toggleItem(merchant, index),
                                      activeColor: const Color(0xFFFFC83D),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    // Product image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        item.imageUrl,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Icon(
                                              Icons.fastfood,
                                              color: Colors.grey,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Product details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Rp. ${item.price}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Quantity controls
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.remove,
                                              size: 18,
                                            ),
                                            onPressed: () => controller.decrement(merchant, index),
                                            constraints: const BoxConstraints(
                                              minWidth: 32,
                                              minHeight: 32,
                                            ),
                                            padding: EdgeInsets.zero,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                            child: Text(
                                              '${item.quantity}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.add,
                                              size: 18,
                                            ),
                                            onPressed: () => controller.increment(merchant, index),
                                            constraints: const BoxConstraints(
                                              minWidth: 32,
                                              minHeight: 32,
                                            ),
                                            padding: EdgeInsets.zero,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
          ),
          // Bottom checkout section
          Obx(() {
            final selectedItems = <CartItem>[];
            controller.cart.forEach((merchant, items) {
              selectedItems.addAll(items.where((item) => item.selected));
            });

            if (selectedItems.isEmpty) {
              return const SizedBox.shrink();
            }

            return Container(
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
                            'Total (${selectedItems.length} items)',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Rp${controller.total.toStringAsFixed(2)}',
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
                          // Get selected items and pass to checkout
                          final selectedItems = <Map<String, dynamic>>[];
                          controller.cart.forEach((merchant, items) {
                            for (var item in items) {
                              if (item.selected) {
                                selectedItems.add({
                                  'name': item.name,
                                  'price': item.price,
                                  'quantity': item.quantity,
                                  'imageUrl': item.imageUrl,
                                  'merchant': merchant,
                                });
                              }
                            }
                          });
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutView(
                                selectedItems: selectedItems,
                                total: controller.total.toDouble(),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC83D),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Check Out',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}