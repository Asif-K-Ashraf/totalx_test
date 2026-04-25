import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:totalx_test/models/user_model.dart';

class UserService {
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;





//image upload
  Future<String> imageupload(File file) async {
    final ref = _storage.ref().child(
      'users/${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }


  //add user
  Future<UserModel> addUser(UserModel user) async {
    final doc= await _db.collection('users').add(user.toMap());
    return UserModel(
      id: doc.id,
      name: user.name,
      age: user.age,
      phone: user.phone,
      imageUrl: user.imageUrl,
    );
  }

//fetch users from firebase
    Future<List<UserModel>> fetchUsers() async {
    final snapshot = await _db.collection('users').get();

    return snapshot.docs.map((doc) {
      return UserModel.fromMap(doc.data(), doc.id);
    }).toList();
  }


}
