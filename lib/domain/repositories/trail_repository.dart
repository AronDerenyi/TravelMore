import '../model/trail.dart';

abstract class TrailRepository {
  Future<List<Trail>> getTrails(String regionId);
  Future<Trail> getTrail(String id);
}
