import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dil_se_khareedo/data/models/product_model.dart';

class ProductRepository {
  final _db = FirebaseFirestore.instance;
  final _collection = 'products';

  // 🔹 ADD PRODUCT (Admin)
  Future<void> addProduct(ProductModel product) async {
    await _db.collection(_collection).add(product.toMap());
  }

  // 🔹 UPDATE PRODUCT (Admin)
  Future<void> updateProduct(ProductModel product) async {
    await _db.collection(_collection).doc(product.id).update(product.toMap());
  }

  // 🔹 DELETE PRODUCT (Admin)
  Future<void> deleteProduct(String id) async {
    await _db.collection(_collection).doc(id).delete();
  }

  Future<List<ProductModel>> getProducts() async {
    final snapshot = await _db.collection(_collection).get();
    return snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
        .toList();
  }
}
