import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_more/domain/model/coordinates.dart';
import 'package:travel_more/domain/model/elevation.dart';
import 'package:travel_more/domain/model/region.dart';
import 'package:travel_more/domain/model/trail.dart';
import 'package:travel_more/domain/repositories/trail_repository.dart';

class TrailRepositoryFirestore implements TrailRepository {
  @override
  Future<Trail> getTrail(String id) async {
    var db = FirebaseFirestore.instance;
    return TrailFromFirestore.fromFirestore(
      await db.collection("trails").doc(id).get(),
    );
  }
}

extension TrailFromFirestore on Trail {
  static Future<Trail> fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) async =>
      Trail(
        id: data.id,
        region: await RegionFromFirestore.fromFirestore(
          await data["region"].get(),
        ),
        title: data["title"],
        description: data["description"],
        images: List.from(data["images"]),
        distance: data["distance"].toDouble(),
        elevation: Elevation(
          down: data["elevation"][0].toDouble(),
          up: data["elevation"][1].toDouble(),
        ),
        coordinates: data["coordinates"]
            .map<Coordinates>((coordinates) => Coordinates(
                lat: coordinates.latitude, long: coordinates.longitude))
            .toList(),
      );
}

extension RegionFromFirestore on Region {
  static Future<Region> fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) async =>
      Region(
        id: data.id,
        title: data["title"],
      );
}
