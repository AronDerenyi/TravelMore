import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/dependencies.dart';
import 'package:travel_more/domain/model/featured.dart';
import 'package:travel_more/domain/repositories/featured_trails_repository.dart';

class FeaturedTrailsBloc
    extends Bloc<FeaturedTrailsBlocEvent, FeaturedTrailsBlocState> {
  FeaturedTrailsRepository repository = injector();

  FeaturedTrailsBloc() : super(LoadingTrailsState()) {
    on<LoadTrailsEvent>((event, emit) async {
      emit(LoadingTrailsState());
      var trails = await repository.getFeaturedTrails();
      emit(TrailsReadyState(trails));
    });
  }
}

abstract class FeaturedTrailsBlocEvent {}

class LoadTrailsEvent extends FeaturedTrailsBlocEvent {}

abstract class FeaturedTrailsBlocState {}

class LoadingTrailsState extends FeaturedTrailsBlocState {}

class TrailsReadyState extends FeaturedTrailsBlocState {
  final List<Featured> featuredTrails;

  TrailsReadyState(this.featuredTrails);
}
