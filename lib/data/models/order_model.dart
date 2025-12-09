class OrderModel {
  final String id;
  final List<Map<String, dynamic>> items; // productId + quantity
  final double total;
  final String userId;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.userId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'items': items,
      'total': total,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
