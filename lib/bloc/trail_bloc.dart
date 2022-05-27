import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/dependencies.dart';
import 'package:travel_more/domain/model/trail.dart';
import 'package:travel_more/domain/model/coordinates.dart';
import 'package:travel_more/domain/repositories/favorite_trails_repository.dart';
import 'package:travel_more/domain/repositories/trail_repository.dart';

class TrailBloc extends Bloc<TrailBlocEvent, TrailBlocState> {
  final TrailRepository _trailRepository = injector();
  final FavoriteTrailsRepository _favoritesRepository = injector();

  Trail? _trail;

  TrailBloc() : super(LoadingTrailState()) {
    on<LoadTrailEvent>((event, emit) async {
      emit(LoadingTrailState());

      var trailFuture = _trailRepository.getTrail(event.trailId);
      var favoriteFuture = _favoritesRepository.isFavorite(event.trailId);
      var trail = await trailFuture;
      _trail = trail;

      emit(TrailReadyState(
        trail.title,
        trail.description,
        trail.distance,
        trail.elevation.up,
        trail.elevation.down,
        trail.images,
        trail.coordinates,
        await favoriteFuture,
      ));
    });

    on<SetFavoriteEvent>((event, emit) async {
      var trail = _trail;
      if (trail == null) return;
      if (!await _favoritesRepository.addFavorite(trail.id)) return;

      var state = this.state;
      if (state is! TrailReadyState) return;
      emit(state.copyWith(favorite: true));
    });

    on<UnsetFavoriteEvent>((event, emit) async {
      var trail = _trail;
      if (trail == null) return;
      if (!await _favoritesRepository.removeFavorite(trail.id)) return;

      var state = this.state;
      if (state is! TrailReadyState) return;
      emit(state.copyWith(favorite: false));
    });
  }
}

abstract class TrailBlocEvent {}

class LoadTrailEvent extends TrailBlocEvent {
  final String trailId;

  LoadTrailEvent(this.trailId);
}

class SetFavoriteEvent extends TrailBlocEvent {}

class UnsetFavoriteEvent extends TrailBlocEvent {}

abstract class TrailBlocState {}

class LoadingTrailState extends TrailBlocState {}

class TrailReadyState extends TrailBlocState {
  final String title;
  final String description;
  final double distance;
  final double posElevation;
  final double negElevation;
  final List<String> images;
  final List<Coordinates> coordinates;
  final bool favorite;

  TrailReadyState(
    this.title,
    this.description,
    this.distance,
    this.posElevation,
    this.negElevation,
    this.images,
    this.coordinates,
    this.favorite,
  );

  TrailReadyState copyWith({
    bool? favorite,
  }) =>
      TrailReadyState(
        title,
        description,
        distance,
        posElevation,
        negElevation,
        images,
        coordinates,
        favorite ?? this.favorite,
      );
}
