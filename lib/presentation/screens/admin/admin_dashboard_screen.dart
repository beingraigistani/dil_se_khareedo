import 'package:dil_se_khareedo/presentation/state/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../routes/app_routes.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthenticationProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Admin Panel")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.adminProducts),
              child: const Text("Manage Products"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => auth.logout(),
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
