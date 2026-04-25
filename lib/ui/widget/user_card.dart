import 'dart:io';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: user.imageUrl.startsWith('http')
              ? NetworkImage(user.imageUrl)
              : FileImage(File(user.imageUrl)) as ImageProvider,
        ),
        title: Text(
          user.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        subtitle: Text("Age: ${user.age}"),
      ),
    );
  }
}