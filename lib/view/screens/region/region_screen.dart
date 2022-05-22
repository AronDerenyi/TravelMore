import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/bloc/region_bloc.dart';
import 'package:travel_more/data/trail_repository_firestore.dart';

class RegionScreen extends StatelessWidget {
  final String regionId;

  const RegionScreen({Key? key, required this.regionId}) : super(key: key);

  static MaterialPageRoute route(String regionId) => MaterialPageRoute(
        builder: (context) => RegionScreen(regionId: regionId),
        settings: const RouteSettings(name: "/region"),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return RegionBloc(TrailRepositoryFirestore())
          ..add(LoadRegionEvent(regionId));
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Region")),
        body: BlocBuilder<RegionBloc, RegionBlocState>(
          builder: (context, state) {
            if (state is LoadingRegionState) {
              return const Center(
                child: Text("Loading..."),
              );
            }

            if (state is RegionReadyState) {
              return ListView.builder(
                itemCount: state.trails.length,
                itemBuilder: (context, index) {
                  var trail = state.trails[index];
                  return ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      RegionScreen.route(trail.id),
                    ),
                    child: Text(trail.title),
                  );
                },
              );
            }

            throw Exception();
          },
        ),
      ),
    );
  }
}
