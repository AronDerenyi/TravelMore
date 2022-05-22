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
      var items = (await repository.getFeaturedTrails())
          .map<FeaturedItem>(
            (data) => FeaturedItem(data.title, data.image, data.trailId),
          )
          .toList();
      emit(TrailsReadyState(items));
    });
  }
}

abstract class FeaturedTrailsBlocEvent {}

class LoadTrailsEvent extends FeaturedTrailsBlocEvent {}

abstract class FeaturedTrailsBlocState {}

class LoadingTrailsState extends FeaturedTrailsBlocState {}

class TrailsReadyState extends FeaturedTrailsBlocState {
  final List<FeaturedItem> items;

  TrailsReadyState(this.items);
}

class FeaturedItem {
  final String title;
  final String image;
  final String trailId;

  FeaturedItem(this.title, this.image, this.trailId);
}
