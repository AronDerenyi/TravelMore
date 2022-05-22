import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/dependencies.dart';
import 'package:travel_more/domain/model/region.dart';
import 'package:travel_more/domain/model/trail.dart';
import 'package:travel_more/domain/repositories/favorite_trails_repository.dart';
import 'package:travel_more/domain/repositories/region_repository.dart';
import 'package:travel_more/domain/repositories/trail_repository.dart';

class DiscoverBloc extends Bloc<DiscoverBlocEvent, DiscoverBlocState> {
  final RegionRepository _regionRepository = injector();
  final TrailRepository _trailRepository = injector();
  final FavoriteTrailsRepository _favoriteRepository = injector();

  StreamSubscription? _favoriteListener;
  List<Region>? _regions;
  Map<String, List<Trail>>? _trails;

  DiscoverBloc() : super(LoadingDiscoverState()) {
    _favoriteListener = _favoriteRepository.listen((favoriteTrailIds) {
      add(_UpdateFavoritesEvent(favoriteTrailIds));
    });

    on<LoadDiscoverEvent>((event, emit) async {
      emit(LoadingDiscoverState());

      var regions = await _regionRepository.getRegions();
      var trails = Map.fromEntries(await Future.wait(
        regions.map<Future<MapEntry<String, List<Trail>>>>(
          (region) async {
            var trails = await _trailRepository.getTrails(region.id);
            return MapEntry(region.id, trails);
          },
        ),
      ));

      _regions = regions;
      _trails = trails;

      add(_UpdateFavoritesEvent(
        await _favoriteRepository.getFavoriteTrailIds(),
      ));
    });

    on<_UpdateFavoritesEvent>((event, emit) {
      var regionItems = _regions
              ?.map<RegionItem>(
                (region) => RegionItem(
                  region.title,
                  _trails?[region.id]
                          ?.map<TrailItem>(
                            (trail) => TrailItem(
                              trail.title,
                              trail.images[0],
                              trail.distance,
                              event.favoriteTrailIds.contains(trail.id),
                              trail.id,
                            ),
                          )
                          .toList() ??
                      [],
                ),
              )
              .toList() ??
          [];

      emit(DiscoverReadyState(regionItems));
    });
  }

  @override
  Future<void> close() async {
    super.close();
    _favoriteListener?.cancel();
  }
}

abstract class DiscoverBlocEvent {}

class LoadDiscoverEvent extends DiscoverBlocEvent {}

class _UpdateFavoritesEvent extends DiscoverBlocEvent {
  final Set<String> favoriteTrailIds;

  _UpdateFavoritesEvent(this.favoriteTrailIds);
}

abstract class DiscoverBlocState {}

class LoadingDiscoverState extends DiscoverBlocState {}

class DiscoverReadyState extends DiscoverBlocState {
  final List<RegionItem> regions;

  DiscoverReadyState(this.regions);
}

class RegionItem {
  final String title;
  final List<TrailItem> trails;

  RegionItem(
    this.title,
    this.trails,
  );
}

class TrailItem {
  final String title;
  final String image;
  final double distance;
  final bool favorite;
  final String trailId;

  TrailItem(
    this.title,
    this.image,
    this.distance,
    this.favorite,
    this.trailId,
  );
}
