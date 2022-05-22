import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/dependencies.dart';
import 'package:travel_more/domain/model/trail.dart';
import 'package:travel_more/domain/repositories/completed_trails_repository.dart';
import 'package:travel_more/domain/repositories/favorite_trails_repository.dart';
import 'package:travel_more/domain/repositories/trail_repository.dart';

class TrailBloc extends Bloc<TrailBlocEvent, TrailBlocState> {
  final TrailRepository _trailRepository = injector();
  final FavoriteTrailsRepository _favoritesRepository = injector();
  final CompletedTrailsRepository _completedRepository = injector();

  Trail? _trail;

  TrailBloc() : super(LoadingTrailState()) {
    on<LoadTrailEvent>((event, emit) async {
      emit(LoadingTrailState());
      var trail = _trailRepository.getTrail(event.trailId);
      var favorite = _favoritesRepository.isFavorite(event.trailId);
      var completed = _completedRepository.isCompleted(event.trailId);
      emit(TrailReadyState(
        await trail,
        await favorite,
        await completed,
      ));
    });

    on<AddToFavoritesEvent>((event, emit) async {
      var state = this.state;
      if (state is TrailReadyState) {
        if (!await _favoritesRepository.addFavorite(state.trail.id)) return;
        emit(TrailReadyState(state.trail, true, state.completed));
      }
    });

    on<RemoveFromFavoritesEvent>((event, emit) async {
      var state = this.state;
      if (state is TrailReadyState) {
        if (!await _favoritesRepository.removeFavorite(state.trail.id)) return;
        emit(TrailReadyState(state.trail, false, state.completed));
      }
    });

    on<SetCompletedEvent>((event, emit) async {
      var state = this.state;
      if (state is TrailReadyState) {
        if (!await _completedRepository.addCompleted(state.trail.id)) return;
        emit(TrailReadyState(state.trail, state.favorite, true));
      }
    });

    on<UnsetCompletedEvent>((event, emit) async {
      var state = this.state;
      if (state is TrailReadyState) {
        if (!await _completedRepository.removeCopmleted(state.trail.id)) return;
        emit(TrailReadyState(state.trail, state.favorite, false));
      }
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

class SetCompletedEvent extends TrailBlocEvent {}

class UnsetCompletedEvent extends TrailBlocEvent {}

abstract class TrailBlocState {}

class LoadingTrailState extends TrailBlocState {}

class TrailReadyState extends TrailBlocState {
  final Trail trail;
  final bool favorite;
  final bool completed;

  TrailReadyState(this.trail, this.favorite, this.completed);
}
