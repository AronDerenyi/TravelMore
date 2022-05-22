import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/domain/model/trail.dart';
import 'package:travel_more/domain/repositories/trail_repository.dart';

class RegionBloc
    extends Bloc<RegionBlocEvent, RegionBlocState> {
  RegionBloc(TrailRepository repository) : super(LoadingRegionState()) {
    on<LoadRegionEvent>((event, emit) async {
      emit(LoadingRegionState());
      var trails = await repository.getTrails(event.regionId);
      emit(RegionReadyState(trails));
    });
  }
}

abstract class RegionBlocEvent {}

class LoadRegionEvent extends RegionBlocEvent {
  final String regionId;

  LoadRegionEvent(this.regionId);
}

abstract class RegionBlocState {}

class LoadingRegionState extends RegionBlocState {}

class RegionReadyState extends RegionBlocState {
  final List<Trail> trails;

  RegionReadyState(this.trails);
}
