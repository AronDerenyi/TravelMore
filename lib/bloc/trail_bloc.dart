import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/dependencies.dart';
import 'package:travel_more/domain/model/trail.dart';
import 'package:travel_more/domain/repositories/trail_repository.dart';

class TrailBloc extends Bloc<TrailBlocEvent, TrailBlocState> {
  TrailRepository repository = injector();

  TrailBloc() : super(LoadingTrailState()) {
    on<LoadTrailEvent>((event, emit) async {
      emit(LoadingTrailState());
      var trail = await repository.getTrail(event.trailId);
      emit(TrailReadyState(trail));
    });
  }
}

abstract class TrailBlocEvent {}

class LoadTrailEvent extends TrailBlocEvent {
  final String trailId;

  LoadTrailEvent(this.trailId);
}

abstract class TrailBlocState {}

class LoadingTrailState extends TrailBlocState {}

class TrailReadyState extends TrailBlocState {
  final Trail trail;

  TrailReadyState(this.trail);
}
