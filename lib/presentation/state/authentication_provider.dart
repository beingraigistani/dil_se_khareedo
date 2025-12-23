import 'package:dil_se_khareedo/data/models/user_model.dart';
import 'package:dil_se_khareedo/data/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return null; // success
    } catch (e) {
      return e.toString(); // return error message
    }
  }

  Future<String?> register(
  String email,
  String password,
  String name,
  String imageUrl,
) async {
  try {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = _auth.currentUser;

    if (user != null) {
      await UserRepository().createUser(
        UserModel(
          uid: user.uid,
          email: user.email ?? "",
          name: name,
          imageUrl: imageUrl,
          role: 'user',
        ),
      );
    }

    return null; // success
  } catch (e) {
    return e.toString();
  }
}
 Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }
}
