import 'coordinates.dart';
import 'elevation.dart';

class Trail {
  final String id;
  final String regionId;

  final String title;
  final String description;
  final List<String> images;

  final double distance;
  final Elevation elevation;
  final List<Coordinates> coordinates;

  Trail(
      {required this.id,
      required this.regionId,
      required this.title,
      required this.description,
      required this.images,
      required this.distance,
      required this.elevation,
      required this.coordinates});
}
