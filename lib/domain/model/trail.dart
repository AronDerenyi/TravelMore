import 'coordinates.dart';
import 'elevation.dart';
import 'region.dart';

class Trail {
  final String id;
  final Region region;

  final String title;
  final String description;
  final List<String> images;

  final double distance;
  final Elevation elevation;
  final List<Coordinates> coordinates;

  Trail(
      {required this.id,
      required this.region,
      required this.title,
      required this.description,
      required this.images,
      required this.distance,
      required this.elevation,
      required this.coordinates});
}
