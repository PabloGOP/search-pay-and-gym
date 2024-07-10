import 'package:geolocator/geolocator.dart';

class Location {
  String type = "Point";
  Coordinates coordinates;

  Location(this.coordinates);

  Location.fromDB(Map<String, dynamic> json)
      : coordinates = Coordinates(
            long: json["coordinates"][0], lat: json["coordinates"][1]);

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": [coordinates.long, coordinates.lat]
      };

  static Future<Location> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location service is disabled");
    }

    return Geolocator.checkPermission().then((permission) async {
      if (permission == LocationPermission.deniedForever) {
        return Future.error("Permission is permanently disabled");
      } else if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error("Permission denied");
        }
      }

      return Geolocator.getCurrentPosition().then((value) {
        return Location(
            Coordinates(long: value.longitude, lat: value.latitude));
      });
    });
  }
}

class Coordinates {
  final double long;
  final double lat;

  Coordinates({required this.long, required this.lat});
}
