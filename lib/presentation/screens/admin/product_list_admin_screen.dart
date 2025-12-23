import 'package:dil_se_khareedo/presentation/state/admin_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/product_provider.dart';
import '../../../routes/app_routes.dart';

class ProductListAdminScreen extends StatelessWidget {
  const ProductListAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.addEditProduct),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, i) {
          final product = products[i];
          return ListTile(
            leading: Image.network(product.imageUrl, width: 50),
            title: Text(product.name),
            subtitle: Text("\$${product.price}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.addEditProduct,
                      arguments: product,
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    context
                        .read<AdminProductProvider>()
                        .deleteProduct(product.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
