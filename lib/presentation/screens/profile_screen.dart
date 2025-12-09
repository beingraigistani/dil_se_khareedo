import 'package:dil_se_khareedo/presentation/state/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../presentation/state/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthenticationProvider>();
    context.read<UserProvider>().loadUser(auth.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: user == null
          ? const Center(child: CircularProgressIndicator()
          )
          
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email: ${user.email}",
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text("Name: ${user.name.isEmpty ? "Not set" : user.name}",
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/orders");
                    },
                    child: const Text("My Orders"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await context.read<AuthenticationProvider>().logout();
                      Navigator.pushReplacementNamed(context, "/login");
                    },
                    child: const Text("Logout"),
                  ),
                ],
              ),
            ),
    );
  }
}
