import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/domain/model/region.dart';
import 'package:travel_more/domain/repositories/region_repository.dart';

class RegionsBloc extends Bloc<RegionsBlocEvent, RegionsBlocState> {
  RegionsBloc(RegionRepository repository) : super(LoadingState()) {
    on<LoadEvent>((event, emit) async {
      emit(LoadingState());
      var regions = await repository.getRegions();
      emit(ReadyState(regions));
    });
  }
}

abstract class RegionsBlocEvent {}

class LoadEvent extends RegionsBlocEvent {}

abstract class RegionsBlocState {}

class LoadingState extends RegionsBlocState {}

class ReadyState extends RegionsBlocState {
  final List<Region> regions;

  ReadyState(this.regions);
}
