import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/dependencies.dart';
import 'package:travel_more/domain/model/featured.dart';
import 'package:travel_more/domain/repositories/featured_trails_repository.dart';
import 'package:travel_more/domain/repositories/region_repository.dart';
import 'package:travel_more/domain/repositories/trail_repository.dart';

class FeaturedTrailsBloc
    extends Bloc<FeaturedTrailsBlocEvent, FeaturedTrailsBlocState> {
  final FeaturedTrailsRepository _featuredTrailsRepository = injector();
  final TrailRepository _trailRepository = injector();
  final RegionRepository _regionRepository = injector();

  FeaturedTrailsBloc() : super(LoadingFeaturedState()) {
    on<LoadFeaturedEvent>((event, emit) async {
      emit(LoadingFeaturedState());
      var featured = await _featuredTrailsRepository.getFeaturedTrails();
      var featuredItems = await Future.wait(featured.map<Future<FeaturedItem>>(
        (featured) async {
          var trail = await _trailRepository.getTrail(featured.trailId);
          var region = await _regionRepository.getRegion(trail.regionId);
          return FeaturedItem(
            featured.image,
            featured.title,
            trail.title,
            region.title,
            featured.trailId,
          );
        },
      ));
      emit(FeaturedReadyState(featuredItems));
    });
  }
}

abstract class FeaturedTrailsBlocEvent {}

class LoadFeaturedEvent extends FeaturedTrailsBlocEvent {}

abstract class FeaturedTrailsBlocState {}

class LoadingFeaturedState extends FeaturedTrailsBlocState {}

class FeaturedReadyState extends FeaturedTrailsBlocState {
  final List<FeaturedItem> items;

  FeaturedReadyState(this.items);
}

class FeaturedItem {
  final String image;
  final String title;
  final String trailTitle;
  final String regionTitle;
  final String trailId;

  FeaturedItem(
    this.image,
    this.title,
    this.trailTitle,
    this.regionTitle,
    this.trailId,
  );
}
