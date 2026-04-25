import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx_test/controllers/user_controller.dart';
import 'package:totalx_test/ui/widget/user_card.dart';

import '../../../provider/user_provider.dart';

class UserListView extends StatefulWidget {
  final String searchQuery;

  final String selectedFilter;

  const UserListView({required this.searchQuery, required this.selectedFilter});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final provider = Provider.of<UserProvider>(context, listen: false);
        final controller = UserController(provider);

        controller.loadUsers(loadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        final filteredUsers = provider.users.where((user) {
          final nameMatch = user.name.toLowerCase().contains(
            widget.searchQuery,
          );
          final phoneMatch = user.phone.contains(widget.searchQuery);
          final matchesSearch = nameMatch || phoneMatch;

          if (widget.selectedFilter == "older") {
            return matchesSearch && user.age > 60;
          } else if (widget.selectedFilter == "younger") {
            return matchesSearch && user.age <= 60;
          }

          return matchesSearch;
        }).toList();
        return ListView.builder(
          controller: _scrollController,
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            return UserCard(user: filteredUsers[index]);
          },
        );
      },
    );
  }
}
