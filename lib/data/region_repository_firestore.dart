import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_more/domain/model/region.dart';
import 'package:travel_more/domain/repositories/region_repository.dart';

class RegionRepositoryFirestore extends RegionRepository {
  @override
  Future<List<Region>> getRegions() async {
    var db = FirebaseFirestore.instance;
    var data = await db.collection("regions").orderBy("title").get();

    return data.docs
        .map<Region>(
          (featured) => RegionFirestore.fromFirestore(featured),
        )
        .toList();
  }
  
  @override
  Future<Region> getRegion(String id) async {
    var db = FirebaseFirestore.instance;
    var data = await db.collection("regions").doc(id).get();
    return RegionFirestore.fromFirestore(data);
  }
}

extension RegionFirestore on Region {
  static Region fromFirestore(DocumentSnapshot<Map<String, dynamic>> data) =>
      Region(
        id: data.id,
        title: data["title"],
      );
}
