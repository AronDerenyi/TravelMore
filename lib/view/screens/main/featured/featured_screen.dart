import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/bloc/featured_trails_bloc.dart';
import 'package:travel_more/view/screens/main/featured/featured_card.dart';

class FeaturedScreen extends StatelessWidget {
  const FeaturedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedTrailsBloc, FeaturedTrailsBlocState>(
      builder: (context, state) {
        var safeArea = MediaQuery.of(context).padding;

        if (state is LoadingFeaturedState) {
          return const Center(child: Text("Loading..."));
        }

        if (state is FeaturedReadyState) {
          return ListView.separated(
            padding: safeArea.add(const EdgeInsets.all(24)),
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            itemCount: state.items.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                var textTheme = Theme.of(context).textTheme;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(children: [
                      const Icon(
                        Icons.directions_walk_rounded,
                        size: 16,
                      ),
                      Text(
                        "Looking for a trip?",
                        style: textTheme.bodyLarge,
                      ),
                    ]),
                    Text(
                      "Popular Hikes",
                      style: textTheme.headlineMedium,
                    ),
                  ],
                );
              } else {
                return FeaturedCard(
                  item: state.items[index - 1],
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
