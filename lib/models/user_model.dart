import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String name;
  final int age;
  final String phone;
  final String imageUrl;


  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.phone,
    required this.imageUrl,
  });







factory UserModel.fromMap(Map<String, dynamic> data, String id) {

  return UserModel(
    id: id,
    name: data['name'] ,
    age: data['age'] ,
    phone: data['phone'] ,
    imageUrl: data['imageUrl'] ,
  );

}


Map<String, dynamic> toMap() {
  return {
    'name': name,
    'age': age,
    'phone': phone,
    'imageUrl': imageUrl,
  };
}



}


