import '../model/featured.dart';

abstract class FeaturedTrailsRepository {
  Future<List<Featured>> getFeaturedTrails();
}
