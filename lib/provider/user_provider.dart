import 'package:flutter/material.dart';
import 'package:totalx_test/models/user_model.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> users = [];
  void setusers(List<UserModel> data) {
    users = data;
    notifyListeners();
  }

  void addMoreUsers(List<UserModel> newUsers) {
    users.addAll(newUsers);
    notifyListeners();
  }

  void addUser(UserModel user) {
    users.add(user);
    notifyListeners();
  }
}
