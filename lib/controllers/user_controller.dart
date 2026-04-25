import 'package:totalx_test/provider/user_provider.dart';

import '../models/user_model.dart';

import '../services/user_service.dart';

class UserController {
  final UserProvider provider;
  final UserService _service = UserService();

  UserController(this.provider);

  Future<void> loadUsers() async {
    final data = await _service.fetchUsers();
    provider.setusers(data);
  }

  Future<void> addUser(UserModel user) async {
    final newUser = await _service.addUser(user);
    provider.addUser(newUser);
  }
}
