import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  late final double latitude;
  late final double longitude;

  Future<bool> getCurrentLocation(BuildContext context) async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          // User denied again — show message
          _showLocationDeniedDialog(context);
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // User permanently denied — guide to settings
        _showPermissionForeverDialog(context);
        return false;
      }

      // Permission granted
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      latitude = position.latitude;
      longitude = position.longitude;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void _showLocationDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Location Permission Denied"),
        content: Text("We need location access to fetch weather info."),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _showPermissionForeverDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Permission Permanently Denied"),
        content: Text("Please enable location from app settings."),
        actions: [
          TextButton(
            child: Text("Open Settings"),
            onPressed: () {
              Geolocator.openAppSettings();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
