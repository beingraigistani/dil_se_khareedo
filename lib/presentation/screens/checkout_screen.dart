import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final repo = OrderRepository();

    // Convert cart items to Firestore friendly format
    final items = cart.items.entries.map((e) {
      return {
        'productId': e.key,
        'quantity': e.value,
      };
    }).toList();

    // Calculate total manually later (for now simple)
    final total = 0.0; // Replace with real total if needed

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Review Order", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final order = OrderModel(
                  id: "",
                  items: items,
                  total: total,
                  userId: auth.currentUser!.uid,
                  createdAt: DateTime.now(),
                );

                await repo.createOrder(order);

                cart.clearCart();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order placed successfully")),
                );

                Navigator.pop(context);
              },
              child: const Text("Place Order"),
            ),
          ],
        ),
      ),
    );
  }
}
