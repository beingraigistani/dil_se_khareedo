import 'package:flutter/foundation.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final _repository = ProductRepository();

  List<ProductModel> filteredProducts = [];

  List<ProductModel> products = [];
  bool isLoading = false;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    products = await _repository.getProducts();
    filteredProducts = products;

    isLoading = false;

    notifyListeners();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = products;
    } else {
      filteredProducts = products
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void filterByCategory(String categoryId) {
    filteredProducts = products
        .where((p) => p.categoryId == categoryId)
        .toList();
    notifyListeners();
  }

  void resetFilter() {
    filteredProducts = products;
    notifyListeners();
  }
}
