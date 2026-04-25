import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx_test/ui/widget/location_appbar.dart';
import 'package:totalx_test/ui/widget/search_filter.dart';
import 'package:totalx_test/ui/widget/user_list_view.dart';
import '../controllers/user_controller.dart';
import '../provider/user_provider.dart';
import '../services/location_service.dart';
import 'add_user_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedFilter = "all";
  late UserController controller;

  String searchQuery = "";
  String locationName = "Allow location permission";

  final locationService = LocationService();

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<UserProvider>(context, listen: false);
    controller = UserController(provider);
    controller.loadUsers();

    getLocation();
  }

  Future<void> getLocation() async {
    final city = await locationService.getCurrentCity();
    setState(() => locationName = city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: LocationAppBar(
        locationName: locationName,
        locationService: locationService,
        onLocationUpdated: (city) {
          setState(() => locationName = city);
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddUserPage()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),

      body: Column(
        children: [
          SearchFilterBar(
            onSearchChanged: (value) {
              setState(() => searchQuery = value.trim().toLowerCase());
            },
            onFilterSelected: (value) {
              setState(() => selectedFilter = value);
            },
          ),

          Expanded(
            child: UserListView(
              searchQuery: searchQuery,
              selectedFilter: selectedFilter,
            ),
          ),
        ],
      ),
    );
  }
}
