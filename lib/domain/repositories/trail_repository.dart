import '../model/trail.dart';

abstract class TrailRepository {
  Future<Trail> getTrail(String id);
}
