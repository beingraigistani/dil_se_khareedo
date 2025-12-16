import 'package:dil_se_khareedo/core/constants/app_text_styles.dart';
import 'package:dil_se_khareedo/presentation/state/authentication_provider.dart';
import 'package:dil_se_khareedo/presentation/state/category_provider.dart';
import 'package:dil_se_khareedo/presentation/state/product_provider.dart';
import 'package:dil_se_khareedo/presentation/widgets/product_card.dart';
import 'package:dil_se_khareedo/presentation/widgets/category_card.dart';
import 'package:dil_se_khareedo/presentation/widgets/search_bar.dart';
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
          // ✅ Correct place for watching provider
          final productProvider = context.watch<ProductProvider>();

          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          return Column(
            children: [
              // 🔍 Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: AppSearchBar(
                  onSearch: (value) {
                    context.read<ProductProvider>().searchProducts(value);
                  },
                ),
              ),

              // 🏷 Categories
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text("Categories", style: AppTextStyles.heading),
              ),

              SizedBox(
                height: 110,
                child: Consumer<CategoryProvider>(
                  builder: (context, categoryProvider, _) {
                    if (categoryProvider.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryProvider.categories.length,
                      itemBuilder: (context, index) {
                        final category = categoryProvider.categories[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CategoryCard(
                            category: category,
                            onTap: () {
                              context.read<CategoryProvider>().selectCategory(
                                category.id,
                              );
                              context.read<ProductProvider>().filterByCategory(
                                category.id,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<ProductProvider>().resetFilter();
                  context.read<CategoryProvider>().clearSelectedCategory();
                },
                child: const Text("Reset"),
              ),

              // 🛍 Product Grid — FIXED
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text("Products", style: AppTextStyles.heading),
              ),

              Expanded(
                child: productProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                        itemCount: productProvider.filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product =
                              productProvider.filteredProducts[index];
                          return ProductCard(
                            product: product,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                "/product",
                                arguments: product,
                              );
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
