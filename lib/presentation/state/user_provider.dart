import 'package:flutter/foundation.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;
  final _repo = UserRepository();

  Future<void> loadUser(String uid) async {
    user = await _repo.getUser(uid);
    notifyListeners();
  }
}
