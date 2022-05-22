import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/dependencies.dart';
import 'package:travel_more/domain/model/trail.dart';
import 'package:travel_more/domain/repositories/favorite_trails_repository.dart';
import 'package:travel_more/domain/repositories/trail_repository.dart';

class FavoriteTrailsBloc
    extends Bloc<FavoriteTrailsBlocEvent, FavoriteTrailsBlocState> {
  final TrailRepository _trailRepository = injector();
  final FavoriteTrailsRepository _favoritesRepository = injector();
  
  StreamSubscription ?_listener;

  FavoriteTrailsBloc() : super(LoadingFavoritesState()) {
    _listener = _favoritesRepository.listen((event) {
      add(LoadFavoritesEvent());
    });

    on<LoadFavoritesEvent>((event, emit) async {
      emit(LoadingFavoritesState());
      List<Trail> trails = [];
      for (var trailId in await _favoritesRepository.getFavoriteTrailIds()) {
        trails.add(await _trailRepository.getTrail(trailId));
      }
      trails.sort((a, b) => a.title.compareTo(b.title));
      emit(FavoritesReadyState(trails));
    });
  }

  @override
  Future<void> close() async {
    super.close();
    _listener?.cancel();
  }
}

abstract class FavoriteTrailsBlocEvent {}

class LoadFavoritesEvent extends FavoriteTrailsBlocEvent {}

abstract class FavoriteTrailsBlocState {}

class LoadingFavoritesState extends FavoriteTrailsBlocState {}

class FavoritesReadyState extends FavoriteTrailsBlocState {
  final List<Trail> favoriteTrails;

  FavoritesReadyState(this.favoriteTrails);
}
