import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/dependencies.dart';
import 'package:travel_more/domain/model/trail.dart';
import 'package:travel_more/domain/repositories/completed_trails_repository.dart';
import 'package:travel_more/domain/repositories/favorite_trails_repository.dart';
import 'package:travel_more/domain/repositories/trail_repository.dart';

class FavoriteTrailsBloc
    extends Bloc<FavoriteTrailsBlocEvent, FavoriteTrailsBlocState> {
  final TrailRepository _trailRepository = injector();
  final FavoriteTrailsRepository _favoritesRepository = injector();
  final CompletedTrailsRepository _completedRepository = injector();

  StreamSubscription? _favoriteListener;
  StreamSubscription? _completedListener;

  FavoriteTrailsBloc() : super(LoadingFavoritesState()) {
    _favoriteListener = _favoritesRepository.listen((event) {
      add(LoadFavoritesEvent());
    });

    _completedListener = _completedRepository.listen((event) {
      add(LoadFavoritesEvent());
    });

    on<LoadFavoritesEvent>((event, emit) async {
      emit(LoadingFavoritesState());
      List<Trail> trails = await Future.wait(
        (await _favoritesRepository.getFavoriteTrailIds())
            .map((id) async => _trailRepository.getTrail(id)),
      );

      var distance = 0.0;
      var completed = 0.0;
      trails.sort((a, b) => a.title.compareTo(b.title));
      for (var trail in trails) {
        distance += trail.distance;
        if (await _completedRepository.isCompleted(trail.id)) {
          completed += trail.distance;
        }
      }

      emit(FavoritesReadyState(trails, distance, completed));
    });
  }

  @override
  Future<void> close() async {
    super.close();
    _favoriteListener?.cancel();
    _completedListener?.cancel();
  }
}

abstract class FavoriteTrailsBlocEvent {}

class LoadFavoritesEvent extends FavoriteTrailsBlocEvent {}

abstract class FavoriteTrailsBlocState {}

class LoadingFavoritesState extends FavoriteTrailsBlocState {}

class FavoritesReadyState extends FavoriteTrailsBlocState {
  final List<Trail> favoriteTrails;
  final double distance;
  final double completed;

  FavoritesReadyState(
    this.favoriteTrails,
    this.distance,
    this.completed,
  );
}
