import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/bloc/trail_bloc.dart';

class TrailScreen extends StatelessWidget {
  final String trailId;

  const TrailScreen({Key? key, required this.trailId}) : super(key: key);

  static MaterialPageRoute route(String trailId) => MaterialPageRoute(
        builder: (context) => TrailScreen(trailId: trailId),
        settings: const RouteSettings(name: "/trail"),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrailBloc()..add(LoadTrailEvent(trailId)),
      child: Scaffold(
        appBar: AppBar(title: const Text("Region")),
        body: BlocBuilder<TrailBloc, TrailBlocState>(
          builder: (context, state) {
            if (state is LoadingTrailState) {
              return const Center(
                child: Text("Loading..."),
              );
            }

            if (state is TrailReadyState) {
              var trail = state.trail;
              return SingleChildScrollView(
                child: Column(children: [
                  Text(trail.title),
                  Text(trail.description),
                  for (var image in trail.images) Image.network(image),
                  Text("Distance: ${trail.distance}"),
                  Text("Elevation +: ${trail.elevation.up}"),
                  Text("Elevation -: ${trail.elevation.down}"),
                ]),
              );
            }

            throw Exception();
          },
        ),
      ),
    );
  }
}
