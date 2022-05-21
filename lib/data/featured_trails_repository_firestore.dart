import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_more/domain/model/featured.dart';
import 'package:travel_more/domain/repositories/featured_trails_repository.dart';

class FeaturedTrailsRepositoryFirestore implements FeaturedTrailsRepository {
  @override
  Future<List<Featured>> getFeaturedTrails() async {
    var db = FirebaseFirestore.instance;
    var data = await db
        .collection("featured")
        .orderBy("priority", descending: true)
        .get();

    return data.docs
        .map<Featured>(
          (featured) => FeaturedFirestore.fromFirestore(featured),
        )
        .toList();
  }
}

extension FeaturedFirestore on Featured {
  static Featured fromFirestore(DocumentSnapshot<Map<String, dynamic>> data) =>
      Featured(
        id: data.id,
        title: data["title"],
        trailId: data["trail"].id,
      );
}
