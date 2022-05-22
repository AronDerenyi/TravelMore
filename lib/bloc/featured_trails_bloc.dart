import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/dependencies.dart';
import 'package:travel_more/domain/model/featured.dart';
import 'package:travel_more/domain/repositories/featured_trails_repository.dart';

class FeaturedTrailsBloc
    extends Bloc<FeaturedTrailsBlocEvent, FeaturedTrailsBlocState> {
  FeaturedTrailsRepository repository = injector();

  FeaturedTrailsBloc() : super(LoadingFeaturedState()) {
    on<LoadFeaturedEvent>((event, emit) async {
      emit(LoadingFeaturedState());
      var items = (await repository.getFeaturedTrails())
          .map<FeaturedItem>(
            (data) => FeaturedItem(data.title, data.image, data.trailId),
          )
          .toList();
      emit(FeaturedReadyState(items));
    });
  }
}

abstract class FeaturedTrailsBlocEvent {}

class LoadFeaturedEvent extends FeaturedTrailsBlocEvent {}

abstract class FeaturedTrailsBlocState {}

class LoadingFeaturedState extends FeaturedTrailsBlocState {}

class FeaturedReadyState extends FeaturedTrailsBlocState {
  final List<FeaturedItem> items;

  FeaturedReadyState(this.items);
}

class FeaturedItem {
  final String title;
  final String image;
  final String trailId;

  FeaturedItem(this.title, this.image, this.trailId);
}
