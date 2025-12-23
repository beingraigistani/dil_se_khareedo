import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

class AdminProductProvider extends ChangeNotifier {
  final ProductRepository _repo = ProductRepository();
  bool isLoading = false;

  Future<void> addProduct(ProductModel product) async {
    isLoading = true;
    notifyListeners();
    await _repo.addProduct(product);
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateProduct(ProductModel product) async {
    isLoading = true;
    notifyListeners();
    await _repo.updateProduct(product);
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    await _repo.deleteProduct(id);
  }
}
