import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/domain/model/region.dart';
import 'package:travel_more/domain/repositories/region_repository.dart';

class RegionsBloc extends Bloc<RegionsBlocEvent, RegionsBlocState> {
  RegionsBloc(RegionRepository repository) : super(LoadingRegionsState()) {
    on<LoadRegionsEvent>((event, emit) async {
      emit(LoadingRegionsState());
      var regions = await repository.getRegions();
      emit(RegionsReadyState(regions));
    });
  }
}

abstract class RegionsBlocEvent {}

class LoadRegionsEvent extends RegionsBlocEvent {}

abstract class RegionsBlocState {}

class LoadingRegionsState extends RegionsBlocState {}

class RegionsReadyState extends RegionsBlocState {
  final List<Region> regions;

  RegionsReadyState(this.regions);
}
