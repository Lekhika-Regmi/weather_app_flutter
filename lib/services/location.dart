import 'package:geolocator/geolocator.dart';

class Location {
  late final double latitude;
  late final double longitude;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // user still denied — show a message, or fallback
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        // permissions are permanently denied — open app settings
        await Geolocator.openAppSettings();
        return;
      }

      // now we have permission!
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.low,
        distanceFilter: 100,
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
