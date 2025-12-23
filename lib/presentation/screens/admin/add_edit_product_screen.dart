import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/admin_product_provider.dart';
import '../../state/category_provider.dart';
import '../../../data/models/product_model.dart';

class AddEditProductScreen extends StatefulWidget {
  const AddEditProductScreen({super.key});

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name, desc, image;
  late double price;
  ProductModel? product;
  String? selectedCategoryId;

  @override
  void didChangeDependencies() {
    product = ModalRoute.of(context)?.settings.arguments as ProductModel?;
    if (product != null) {
      name = product!.name;
      desc = product!.description;
      image = product!.imageUrl;
      price = product!.price;
      selectedCategoryId = product?.categoryId;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CategoryProvider>().fetchCategories();
    });
  }

  // function to show dialog to add new category
  void _showAddCategoryDialog(BuildContext context) {
    final nameController = TextEditingController();
    final imageController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Category"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Category Name"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(
                labelText: "Image URL (optional)",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.trim().isEmpty) return;

              final newCategoryId = await context
                  .read<CategoryProvider>()
                  .addCategory(
                    nameController.text.trim(),
                    imageController.text.trim(),
                  );

              setState(() {
                selectedCategoryId = newCategoryId;
              });

              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final admin = context.watch<AdminProductProvider>();

    final categoryProvider = context.watch<CategoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(product == null ? "Add Product" : "Edit Product"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              initialValue: product?.name,
              decoration: const InputDecoration(labelText: "Name"),
              onSaved: (v) => name = v!,
            ),

            TextFormField(
              initialValue: product?.description,
              decoration: const InputDecoration(labelText: "Description"),
              onSaved: (v) => desc = v!,
            ),

            TextFormField(
              initialValue: product?.imageUrl,
              decoration: const InputDecoration(labelText: "Image URL"),
              onSaved: (v) => image = v!,
            ),

            TextFormField(
              initialValue: product?.price.toString(),
              decoration: const InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
              onSaved: (v) => price = double.parse(v!),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedCategoryId,
              hint: const Text("Select Category"),
              items: categoryProvider.categories.map((cat) {
                return DropdownMenuItem<String>(
                  value: cat.id,
                  child: Text(cat.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategoryId = value;
                });
              },
              validator: (value) => value == null ? "Category required" : null,
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                _showAddCategoryDialog(context);
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New Category"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                _formKey.currentState!.save();

                final newProduct = ProductModel(
                  id: product?.id ?? '',
                  name: name,
                  description: desc,
                  imageUrl: image,
                  price: price,
                  categoryId: selectedCategoryId!,
                );

                product == null
                    ? admin.addProduct(newProduct)
                    : admin.updateProduct(newProduct);
                if (selectedCategoryId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a category")),
                  );
                  return;
                }

                print("Saving product with categoryId: $selectedCategoryId");

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
