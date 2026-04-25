import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx_test/ui/widget/user_card.dart';

import '../../../provider/user_provider.dart';

class UserListView extends StatelessWidget {
  final String searchQuery;

  final String selectedFilter;

  const UserListView({required this.searchQuery, required this.selectedFilter});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        final filteredUsers = provider.users.where((user) {
          final nameMatch = user.name.toLowerCase().contains(searchQuery);
          final phoneMatch = user.phone.contains(searchQuery);
          final matchesSearch = nameMatch || phoneMatch;

          if (selectedFilter == "older") {
            return matchesSearch && user.age > 60;
          } else if (selectedFilter == "younger") {
            return matchesSearch && user.age <= 60;
          }

          return matchesSearch;
        }).toList();
        return ListView.builder(
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            return UserCard(user: filteredUsers[index]);
          },
        );
      },
    );
  }
}
