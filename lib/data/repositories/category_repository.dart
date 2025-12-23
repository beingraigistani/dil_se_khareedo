import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category_model.dart';

class CategoryRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async {
    final snapshot = await _db.collection('categories').get();
    return snapshot.docs
        .map((d) => CategoryModel.fromMap(d.data(), d.id))
        .toList();
  }

  Future<DocumentReference> addCategory(String name, String imageUrl) async {
    return await _db.collection('categories').add({
      'name': name,
      'imageUrl': imageUrl,
    });
  }
}
