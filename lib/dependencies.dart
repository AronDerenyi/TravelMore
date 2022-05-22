import 'package:get_it/get_it.dart';
import 'package:travel_more/data/featured_trails_repository_firestore.dart';
import 'package:travel_more/data/region_repository_firestore.dart';
import 'package:travel_more/data/trail_repository_firestore.dart';
import 'package:travel_more/domain/repositories/featured_trails_repository.dart';
import 'package:travel_more/domain/repositories/region_repository.dart';
import 'package:travel_more/domain/repositories/trail_repository.dart';

final injector = GetIt.instance;

Future<void> initDependencies() async {
  injector.registerSingleton<FeaturedTrailsRepository>(
    FeaturedTrailsRepositoryFirestore(),
  );

  injector.registerSingleton<RegionRepository>(
    RegionRepositoryFirestore(),
  );

  injector.registerSingleton<TrailRepository>(
    TrailRepositoryFirestore(),
  );

  return injector.allReady();
}
