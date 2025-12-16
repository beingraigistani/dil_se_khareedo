import 'package:dil_se_khareedo/presentation/state/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../presentation/state/cart_provider.dart';
import '../../../presentation/state/authentication_provider.dart';
import '../../../data/repositories/order_repository.dart';
import '../../../data/models/order_model.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final auth = context.read<AuthenticationProvider>();
    final products = context.read<ProductProvider>().products;

    final repo = OrderRepository();

    double totalAmount = 0;

    final List<Map<String, dynamic>> items = cart.items.entries.map((entry) {
      final productId = entry.key;
      final quantity = entry.value;

      final product = products.firstWhere((p) => p.id == productId);

      final subtotal = product.price * quantity;
      totalAmount += subtotal;

      return {
        'productId': product.id,
        'name': product.name,
        'image': product.image,
        'price': product.price,
        'quantity': quantity,
        'subtotal': subtotal,
      };
    }).toList();
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (_, index) {
                final item = items[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item['image'],
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name'], style: AppTextStyles.body),
                              const SizedBox(height: 4),
                              Text(
                                "Qty: ${item['quantity']}",
                                style: AppTextStyles.body,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$${item['subtotal'].toStringAsFixed(2)}",
                                style: AppTextStyles.body,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          /// ORDER SUMMARY
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.05),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total", style: AppTextStyles.heading),
                    Text(
                      "\$${totalAmount.toStringAsFixed(2)}",
                      style: AppTextStyles.heading,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final order = OrderModel(
                        id: '',
                        userId: auth.currentUser!.uid,
                        items: items,
                        total: totalAmount,
                        createdAt: DateTime.now(),
                      );

                      await repo.createOrder(order);
                      cart.clearCart();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Order placed successfully"),
                        ),
                      );

                      Navigator.pop(context);
                    },
                    child: const Text("Place Order"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
