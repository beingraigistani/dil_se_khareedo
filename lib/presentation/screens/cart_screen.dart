import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../presentation/state/cart_provider.dart';
import '../../../data/models/product_model.dart';
import '../../../presentation/state/product_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final products = context.read<ProductProvider>().products;

    final cartItems = cart.items.entries.map((entry) {
      final product = products.firstWhere((p) => p.id == entry.key);
      return {'product': product, 'quantity': entry.value};
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index]['product'] as ProductModel;
                final quantity = cartItems[index]['quantity'] as int;

                return ListTile(
                  leading: Image.network(product.image, width: 50, height: 50),
                  title: Text(product.name),
                  subtitle: Text("Qty: $quantity"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          context.read<CartProvider>().removeFromCart(product);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          context.read<CartProvider>().addToCart(product);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/checkout");
                },

                child: const Text("Proceed to Checkout"),
              ),
            )
          : null,
    );
  }
}
