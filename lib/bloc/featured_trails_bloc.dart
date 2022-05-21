import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/domain/model/featured.dart';
import 'package:travel_more/domain/repositories/featured_trails_repository.dart';

class FeaturedTrailsBloc
    extends Bloc<FeaturedTrailsBlocEvent, FeaturedTrailsBlocState> {

  FeaturedTrailsBloc(FeaturedTrailsRepository repository) : super(LoadingState()) {
    on<LoadEvent>((event, emit) async {
      emit(LoadingState());
      var trails = await repository.getFeaturedTrails();
      emit(ReadyState(trails));
    });
  }
}

abstract class FeaturedTrailsBlocEvent {}

class LoadEvent extends FeaturedTrailsBlocEvent {}

abstract class FeaturedTrailsBlocState {}

class LoadingState extends FeaturedTrailsBlocState {}

class ReadyState extends FeaturedTrailsBlocState {
  final List<Featured> featuredTrails;

  ReadyState(this.featuredTrails);
}
