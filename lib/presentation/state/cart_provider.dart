import 'package:flutter/foundation.dart';
import '../../../data/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  
  final Map<String, int> _items = {}; // productId : quantity
  
  

  Map<String, int> get items => _items;

  void addToCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      _items[product.id] = _items[product.id]! + 1;
    } else {
      _items[product.id] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      if (_items[product.id] == 1) {
        _items.remove(product.id);
      } else {
        _items[product.id] = _items[product.id]! - 1;
      }
      notifyListeners();
    }
  }

  int getQuantity(ProductModel product) {
    return _items[product.id] ?? 0;
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}

