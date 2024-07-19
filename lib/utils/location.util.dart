import 'package:geolocator/geolocator.dart';

Future<Position?> getCurrentPosition() async {
  final hasPermission = await _handleLocationPermission();
  if (!hasPermission) {
    return null;
  }
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

Future<bool> _handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return false;
  }
  return true;
}
