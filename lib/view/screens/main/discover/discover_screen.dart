import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/bloc/regions_bloc.dart';
import 'package:travel_more/view/screens/region/region_screen.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionsBloc, RegionsBlocState>(
      builder: (context, state) {
        if (state is LoadingRegionsState) {
          return const Center(child: Text("Loading..."));
        }

        if (state is RegionsReadyState) {
          return ListView.builder(
            itemCount: state.regions.length,
            itemBuilder: (context, index) {
              var region = state.regions[index];
              return ElevatedButton(
                onPressed: () =>
                    Navigator.push(context, RegionScreen.route(region.id)),
                child: Text(region.title),
              );
            },
          );
        }

        throw Exception();
      },
    );
  }
}
