import 'package:dil_se_khareedo/presentation/state/authentication_provider.dart';
import 'package:dil_se_khareedo/presentation/state/category_provider.dart';
import 'package:dil_se_khareedo/presentation/state/product_provider.dart';
import 'package:dil_se_khareedo/presentation/widgets/product_card.dart';
import 'package:dil_se_khareedo/presentation/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
      context.read<CategoryProvider>().fetchCategories();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthenticationProvider>().logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, "/cart");
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
          ),

          PopupMenuButton(
            onSelected: (value) {
              if (value == 'orders') {
                Navigator.pushNamed(context, "/orders");
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'orders', child: Text("My Orders")),
            ],
          ),
        ],
      ),

      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.products.isEmpty) {
            return const Center(child: Text("No products found"));
            
          }

          return Column(
            children: [
              SizedBox(
                height: 110,
                child: Consumer<CategoryProvider>(
                  builder: (context, provider, _) {
                    if (provider.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.categories.length,
                      itemBuilder: (context, index) {
                        final category = provider.categories[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CategoryCard(
                            category: category,
                            onTap: () {
                              // later: filter products by category
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) {
                    final product = provider.products[index];

                    return ProductCard(
                      product: product,
                      onTap: () {
                        Navigator.pushNamed(context, "/product", arguments: product);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
