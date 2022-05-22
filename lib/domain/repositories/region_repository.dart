import '../model/region.dart';

abstract class RegionRepository {
  Future<List<Region>> getRegions();
}
