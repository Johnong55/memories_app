import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class LocationService extends GetxService {
  Future<LocationService> init() async {
    return this;
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When permissions are granted, we can get the position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<String?> getLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        // Construct a nice location string, e.g., "Hoan Kiem, Hanoi"
        String name = '';
        if (place.subAdministrativeArea != null && place.subAdministrativeArea!.isNotEmpty) {
           name += place.subAdministrativeArea!;
        } else if (place.locality != null && place.locality!.isNotEmpty) {
           name += place.locality!;
        }
        
        if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
          if (name.isNotEmpty) name += ', ';
          name += place.administrativeArea!;
        }
        
        return name.isNotEmpty ? name : "Unknown Location";
      }
    } catch (e) {
      print('Error getting location name: $e');
    }
    return null;
  }
}
