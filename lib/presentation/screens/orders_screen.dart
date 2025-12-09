import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../presentation/state/authentication_provider.dart';
import '../../../data/repositories/order_repository.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final _repo = OrderRepository();
  bool loading = true;
  List<Map<String, dynamic>> orders = [];

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  void loadOrders() async {
    final userId = context.read<AuthenticationProvider>().currentUser!.uid;
    orders = await _repo.getOrders(userId);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
              ? const Center(child: Text("No orders yet"))
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index]['data'];
                    final createdAt = DateTime.parse(order['createdAt']);
                    final formattedDate =
                        DateFormat('dd MMM yyyy • hh:mm a').format(createdAt);

                    return ListTile(
                      title: Text("Order #${orders[index]['id']}"),
                      subtitle: Text("Placed on $formattedDate"),
                      trailing: Text("\$${order['total']}"),
                    );
                  },
                ),
    );
  }
}
