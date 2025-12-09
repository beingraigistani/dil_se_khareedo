import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';

class OrderRepository {
  final _db = FirebaseFirestore.instance;

  Future<void> createOrder(OrderModel order) async {
    await _db.collection('orders').add(order.toMap());
  }

  Future<List<Map<String, dynamic>>> getOrders(String userId) async {
    final snapshot = await _db
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return {'id': doc.id, 'data': doc.data()};
    }).toList();
  }
  }
