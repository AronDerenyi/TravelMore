import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/dependencies.dart';
import 'package:travel_more/domain/model/coordinates.dart';
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
    _favoriteListener = _favoritesRepository.listen((favoriteIds) {
      add(_UpdateFavoritesEvent(favoriteIds));
    });

    _completedListener = _completedRepository.listen((completedIds) {
      add(_UpdateCompletedEvent(completedIds));
    });

    on<LoadFavoritesEvent>((event, emit) async {
      emit(LoadingFavoritesState());
      var favoriteIds = await _favoritesRepository.getFavoriteTrailIds();
      add(_UpdateFavoritesEvent(favoriteIds));
    });

    on<SetCompletedEvent>((event, emit) {
      _completedRepository.addCompleted(event.trailId);
    });

    on<UnsetCompletedEvent>((event, emit) {
      _completedRepository.removeCompleted(event.trailId);
    });

    on<_UpdateFavoritesEvent>((event, emit) async {
      var favoriteIds = event.favoriteTrailIds;
      var state = this.state;

      var trails = state is FavoritesReadyState
          ? List<FavoriteTrailItem>.from(state.trails)
          : <FavoriteTrailItem>[];

      trails.removeWhere((trail) => !favoriteIds.contains(trail.trailId));
      for (var trail in trails) {
        favoriteIds.remove(trail.trailId);
      }

      await Future.wait(favoriteIds.map<Future<void>>((trailId) async {
        var trail = await _trailRepository.getTrail(trailId);
        trails.add(FavoriteTrailItem(
          trail.title,
          trail.images[0],
          trail.distance,
          trail.coordinates[trail.coordinates.length ~/ 2],
          await _completedRepository.isCompleted(trail.id),
          trail.id,
        ));
      }));

      trails.sort((a, b) => a.title.compareTo(b.title));
      emit(FavoritesReadyState(trails));
    });

    on<_UpdateCompletedEvent>((event, emit) {
      var completedIds = event.completedTrailIds;
      var state = this.state;

      if (state is FavoritesReadyState) {
        var trails = state.trails
            .map(
              (trail) => trail.copyWith(
                completed: completedIds.contains(trail.trailId),
              ),
            )
            .toList();

        emit(FavoritesReadyState(trails));
      }
    });
  }

  @override
  Future<void> close() async {
    super.close();
    _favoriteListener?.cancel();
    _completedListener?.cancel();
  }
}

// Events

abstract class FavoriteTrailsBlocEvent {}

class LoadFavoritesEvent extends FavoriteTrailsBlocEvent {}

class SetCompletedEvent extends FavoriteTrailsBlocEvent {
  final String trailId;

  SetCompletedEvent(this.trailId);
}

class UnsetCompletedEvent extends FavoriteTrailsBlocEvent {
  final String trailId;

  UnsetCompletedEvent(this.trailId);
}

class _UpdateFavoritesEvent extends FavoriteTrailsBlocEvent {
  final Set<String> favoriteTrailIds;

  _UpdateFavoritesEvent(this.favoriteTrailIds);
}

class _UpdateCompletedEvent extends FavoriteTrailsBlocEvent {
  final Set<String> completedTrailIds;

  _UpdateCompletedEvent(this.completedTrailIds);
}

// States

abstract class FavoriteTrailsBlocState {}

class LoadingFavoritesState extends FavoriteTrailsBlocState {}

class FavoritesReadyState extends FavoriteTrailsBlocState {
  final List<FavoriteTrailItem> trails;
  late final double distance;
  late final double completed;

  FavoritesReadyState(
    this.trails,
  ) {
    distance = trails.fold<double>(0, (dist, trail) => dist + trail.distance);
    completed = trails
        .where((trail) => trail.completed)
        .fold<double>(0, (dist, trail) => dist + trail.distance);
  }
}

class FavoriteTrailItem {
  final String title;
  final String image;
  final double distance;
  final Coordinates coordinates;
  final bool completed;
  final String trailId;

  FavoriteTrailItem(
    this.title,
    this.image,
    this.distance,
    this.coordinates,
    this.completed,
    this.trailId,
  );

  FavoriteTrailItem copyWith({
    bool? completed,
  }) =>
      FavoriteTrailItem(
        title,
        image,
        distance,
        coordinates,
        completed ?? this.completed,
        trailId,
      );
}
