import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_more/bloc/favorite_trails_bloc.dart';
import 'package:travel_more/view/screens/trail/trail_screen.dart';

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
          return ListView.builder(
            itemCount: state.favoriteTrails.length,
            itemBuilder: (context, index) {
              var trail = state.favoriteTrails[index];
              return ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  TrailScreen.route(trail.id),
                ),
                child: Text(trail.title),
              );
            },
          );
        }

        throw Exception();
      },
    );
  }
}
