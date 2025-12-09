import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts() async {
    final snapshot = await _db.collection('products').get();

    return snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
        .toList();
  }
}
