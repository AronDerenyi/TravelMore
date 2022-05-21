import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/domain/model/elevation.dart';
import 'package:travel_more/domain/model/region.dart';
import 'package:travel_more/domain/model/trail.dart';

class TrailBloc extends Bloc<TrailBlocEvent, TrailBlocState> {
  TrailBloc()
      : super(TrailBlocState(
            trail: Trail(
                id: "trail",
                region: Region(id: "region", title: "Region"),
                title: "Trail",
                description: "This is a trail",
                images: [],
                distance: 0,
                elevation: Elevation(down: 0, up: 0),
                coordinates: [])));
}

class TrailBlocEvent {}

class TrailBlocState {
  final Trail trail;

  TrailBlocState({required this.trail});
}
