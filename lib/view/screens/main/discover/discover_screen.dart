import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/bloc/discover_bloc.dart';
import 'package:travel_more/view/screens/main/discover/discover_region_row.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return BlocBuilder<DiscoverBloc, DiscoverBlocState>(
      builder: (context, state) {
        var safeArea = MediaQuery.of(context).padding;

        if (state is LoadingDiscoverState) {
          return const Center(child: Text("Loading..."));
        }

        if (state is DiscoverReadyState) {
          return ListView.builder(
            padding: safeArea.add(const EdgeInsets.symmetric(vertical: 24)),
            itemCount: state.regions.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: Text(
                    "Discover",
                    style: textTheme.headlineMedium,
                  ),
                );
              } else {
                return DiscoverRegionRow(
                  region: state.regions[index - 1],
                );
              }
            },
          );
        }

        throw Exception();
      },
    );
  }
}
