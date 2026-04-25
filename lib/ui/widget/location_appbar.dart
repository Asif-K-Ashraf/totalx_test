import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../services/location_service.dart';

class LocationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String locationName;
  final LocationService locationService;
  final Function(String) onLocationUpdated;

  const LocationAppBar({
    required this.locationName,
    required this.locationService,
    required this.onLocationUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            onLocationUpdated(city);
          }
        },
        child: Row(
          children: [
            Icon(Icons.location_on, color: Colors.white),
            SizedBox(width: 5),
            Text(
              locationName,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90);
}