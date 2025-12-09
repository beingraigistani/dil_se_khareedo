import 'package:flutter/foundation.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final _repository = ProductRepository();

  List<ProductModel> products = [];
  bool isLoading = false;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    products = await _repository.getProducts();

    isLoading = false;
    notifyListeners();
  }
}
