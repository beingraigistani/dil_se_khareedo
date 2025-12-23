import 'package:flutter/foundation.dart';
import '../../../data/models/category_model.dart';
import '../../../data/repositories/category_repository.dart';

class CategoryProvider extends ChangeNotifier {
  final _repo = CategoryRepository();
  List<CategoryModel> categories = [];
  bool loading = false;
  String selectedCategory = '';

  Future<void> fetchCategories() async {
    print('Fetching categories Start');
    loading = true;
    notifyListeners();

    categories = await _repo.getCategories();
    print('Fetched categories: ${categories.length}');

    loading = false;
    notifyListeners();
    print('Fetching categories End');
  }

  Future<String> addCategory(String name, String imageUrl) async {
    final docRef = await _repo.addCategory(name, imageUrl);
    await fetchCategories();
    selectedCategory = docRef.id; 
    notifyListeners();
    return docRef.id;
  }

  void selectCategory(String categoryId) {
    selectedCategory = categoryId;
    print('Selected categoryId: $categoryId');
    notifyListeners();
  }

  void clearSelectedCategory() {
    selectedCategory = '';
    notifyListeners();
  }
}
