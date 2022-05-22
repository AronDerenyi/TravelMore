import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/dependencies.dart';
import 'package:travel_more/domain/model/trail.dart';
import 'package:travel_more/domain/repositories/favorite_trails_repository.dart';
import 'package:travel_more/domain/repositories/trail_repository.dart';

class TrailBloc extends Bloc<TrailBlocEvent, TrailBlocState> {
  final TrailRepository _trailRepository = injector();
  final FavoriteTrailsRepository _favoritesRepository = injector();

  Trail? _trail;

  TrailBloc() : super(LoadingTrailState()) {
    on<LoadTrailEvent>((event, emit) async {
      emit(LoadingTrailState());
      var trail = _trailRepository.getTrail(event.trailId);
      var favorite = _favoritesRepository.isFavorite(event.trailId);
      emit(TrailReadyState(
        _trail = await trail,
        await favorite
      ));
    });

    on<AddToFavoritesEvent>((event, emit) async {
      var trail = _trail;
      if (trail == null) return;
      if (!await _favoritesRepository.addFavorite(trail.id)) return;
      emit(TrailReadyState(trail, true));
    });

    on<RemoveFromFavoritesEvent>((event, emit) async {
      var trail = _trail;
      if (trail == null) return;
      if (!await _favoritesRepository.removeFavorite(trail.id)) return;
      emit(TrailReadyState(trail, false));
    });
  }
}

abstract class TrailBlocEvent {}

class LoadTrailEvent extends TrailBlocEvent {
  final String trailId;

  LoadTrailEvent(this.trailId);
}

class AddToFavoritesEvent extends TrailBlocEvent {}

class RemoveFromFavoritesEvent extends TrailBlocEvent {}

abstract class TrailBlocState {}

class LoadingTrailState extends TrailBlocState {}

class TrailReadyState extends TrailBlocState {
  final Trail trail;
  final bool favorite;

  TrailReadyState(this.trail, this.favorite);
}
