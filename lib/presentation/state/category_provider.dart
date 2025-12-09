import 'package:flutter/foundation.dart';
import '../../../data/models/category_model.dart';
import '../../../data/repositories/category_repository.dart';

class CategoryProvider extends ChangeNotifier {
  final _repo = CategoryRepository();
  List<CategoryModel> categories = [];
  bool loading = false;

  Future<void> fetchCategories() async {
    loading = true;
    notifyListeners();

    categories = await _repo.getCategories();

    loading = false;
    notifyListeners();
  }
}
