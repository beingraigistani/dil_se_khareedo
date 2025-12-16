import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/user_repository.dart';
import '../../../presentation/state/user_provider.dart';
import '../../../presentation/widgets/app_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final userProvider =
        Provider.of<UserProvider>(context, listen: false);

    nameController.text = userProvider.user?.name ?? "";
    imageController.text = userProvider.user?.imageUrl ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final repo = UserRepository();
    final uid = userProvider.user?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(
                labelText: "Image URL",
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              child:Text("Save") ,
              onPressed: uid == null
                  ? null
                  : () async {
                      await repo.updateUser(
                        uid,
                        nameController.text.trim(),
                        imageController.text.trim(),
                      );

                      await userProvider.loadUser(uid);

                      Navigator.pop(context);
                    },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    imageController.dispose();
    super.dispose();
  }
}
