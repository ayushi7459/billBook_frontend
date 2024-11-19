import 'package:geolocator/geolocator.dart';

void getLocation() async {
  print("tapped for permission");
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  print(position);
}
