import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/domain/model/trail.dart';
import 'package:travel_more/domain/repositories/trail_repository.dart';

class TrailBloc extends Bloc<TrailBlocEvent, TrailBlocState> {
  TrailBloc(TrailRepository trailRepository) : super(LoadingState()) {
    on<LoadEvent>((event, emit) async {
      var trail = await trailRepository.getTrail(event.trailId);
      emit(TrailState(trail: trail));
    });

    add(LoadEvent(trailId: "ak_05"));
  }
}

abstract class TrailBlocEvent {}

class LoadEvent extends TrailBlocEvent {
  final String trailId;

  LoadEvent({required this.trailId});
}

abstract class TrailBlocState {}

class LoadingState extends TrailBlocState {}

class TrailState extends TrailBlocState {
  final Trail trail;

  TrailState({required this.trail});
}
