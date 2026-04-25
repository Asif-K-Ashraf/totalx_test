// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:totalx_test/controllers/user_controller.dart';
// import 'package:totalx_test/provider/user_provider.dart';

// import 'add_user_page.dart';

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late UserController controller;
//   String searchQuery = "";

//   @override
//   void initState() {
//     super.initState();
//     final provider = Provider.of<UserProvider>(context, listen: false);
//     controller = UserController(provider);
//     controller.loadUsers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           "📍 Nilambur",
//           style: TextStyle(color: Colors.white, fontSize: 30),
//         ),
//       ),
//       backgroundColor: Colors.grey[200],

//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.black,
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => AddUserPage()),
//           );
//         },
//         child: Icon(Icons.add, color: Colors.white),
//       ),

//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       onChanged: (value) {
//                         setState(() {
//                           searchQuery = value.toLowerCase();
//                         });
//                       },
//                       decoration: InputDecoration(
//                         hintText: "search by name",
//                         prefixIcon: Icon(Icons.search),
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Icon(Icons.filter_list, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Users Lists",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),

//             SizedBox(height: 10),

//             Expanded(
//               child: Consumer<UserProvider>(
//                 builder: (context, provider, child) {
//                   final filteredUsers = provider.users.where((user) {
//                     return user.name.toLowerCase().contains(searchQuery);
//                   }).toList();

//                   return ListView.builder(
//                     itemCount: filteredUsers.length,
//                     itemBuilder: (context, index) {
//                       final user = filteredUsers[index];

//                       return Card(
//                         color: Colors.white,
//                         margin: EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             radius: 30,
//                             backgroundImage: user.imageUrl.startsWith('http')
//                                 ? NetworkImage(user.imageUrl)
//                                 : FileImage(File(user.imageUrl))
//                                       as ImageProvider,
//                           ),
//                           title: Text(
//                             user.name,
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 25,
//                             ),
//                           ),
//                           subtitle: Text("Age: ${user.age}"),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'package:totalx_test/controllers/user_controller.dart';
import 'package:totalx_test/provider/user_provider.dart';
import 'package:totalx_test/services/location_service.dart';

import 'add_user_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserController controller;

  String searchQuery = "";
  String locationName = "allow location permission";

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

    setState(() {
      locationName = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 90,
        title: GestureDetector(
          onTap: () async {
            final city = await locationService.getCurrentCity();

            if (city == "Turn on GPS") {
              await Geolocator.openLocationSettings();
            } else if (city == "Enable permission") {
              await Geolocator.openAppSettings();
            } else {
              setState(() {
                locationName = city;
              });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white, size: 20),
                  SizedBox(width: 5),
                  Text(
                    locationName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.trim().toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "search by name",
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),

                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.filter_list, color: Colors.white),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Users Lists",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 10),

            Expanded(
              child: Consumer<UserProvider>(
                builder: (context, provider, child) {
                  final filteredUsers = provider.users.where((user) {
                    final nameMatch = user.name.toLowerCase().contains(
                      searchQuery,
                    );
                    final phoneMatch = user.phone.contains(searchQuery);

                    return nameMatch || phoneMatch;
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];

                      return Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: user.imageUrl.startsWith('http')
                                ? NetworkImage(user.imageUrl)
                                : FileImage(File(user.imageUrl))
                                      as ImageProvider,
                          ),
                          title: Text(
                            user.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text("Age: ${user.age}"),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
