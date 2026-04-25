import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:totalx_test/provider/user_provider.dart';

import '../models/user_model.dart';

import '../services/user_service.dart';

class UserController {
  DocumentSnapshot? lastDoc;
  bool hasMore = true;
  bool isLoading = false;
  final UserProvider provider;
  final UserService _service = UserService();

  UserController(this.provider);

  Future<void> loadUsers({bool loadMore = false}) async {
    if (isLoading) return;

    isLoading = true;

    Query query = FirebaseFirestore.instance
        .collection('users')
        .orderBy('name')
        .limit(10);

    if (loadMore && lastDoc != null) {
      query = query.startAfterDocument(lastDoc!);
    }

    final snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      lastDoc = snapshot.docs.last;
    }

    if (snapshot.docs.length < 10) {
      hasMore = false;
    }

    final users = snapshot.docs.map((doc) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();

    if (loadMore) {
      provider.addMoreUsers(users);
    } else {
      provider.setusers(users);
    }

    isLoading = false;
  }

  Future<void> addUser(UserModel user) async {
    final newUser = await _service.addUser(user);
    provider.addUser(newUser);
  }
}
