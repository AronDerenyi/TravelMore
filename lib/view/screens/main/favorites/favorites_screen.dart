import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/bloc/favorite_trails_bloc.dart';
import 'package:travel_more/view/screens/main/favorites/favorite_card.dart';
import 'package:travel_more/view/screens/main/favorites/favorites_header.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteTrailsBloc, FavoriteTrailsBlocState>(
      builder: (context, state) {
        if (state is LoadingFavoritesState) {
          return const Center(child: Text("Loading..."));
        }

        if (state is FavoritesReadyState) {
          var safeArea = MediaQuery.of(context).padding;

          return ListView.separated(
            padding: safeArea.add(const EdgeInsets.all(24)),
            itemCount: state.trails.length + 1,
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            itemBuilder: (context, index) {
              if (index == 0) {
                return const FavoritesHeader();
              } else {
                var trail = state.trails[index - 1];
                return FavoriteCard(
                  key: ValueKey(trail.trailId),
                  trail: trail
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
