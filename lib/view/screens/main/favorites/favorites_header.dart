import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_more/bloc/favorite_trails_bloc.dart';
import 'package:travel_more/view/widgets/map_widget.dart';

class FavoritesHeader extends StatelessWidget {
  const FavoritesHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteTrailsBloc, FavoriteTrailsBlocState>(
      builder: (context, state) {
        if (state is FavoritesReadyState) {
          var theme = Theme.of(context);
          var textTheme = theme.textTheme;
          var colors = theme.colorScheme;
          var borderRadius = BorderRadius.circular(16);
          var decoration = BoxDecoration(
            color: colors.surface,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 24,
                offset: Offset(0, 12),
              ),
            ],
            borderRadius: borderRadius,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Favorites",
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              DecoratedBox(
                decoration: decoration,
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: SizedBox(
                    height: 300,
                    child: MapWidget(
                      padding: 0.1,
                      markers: state.trails
                          .map(
                            (trail) => MapMarker(
                              active: trail.completed,
                              coordinates: LatLng(
                                trail.coordinates.lat,
                                trail.coordinates.long,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        throw Exception();
      },
    );
  }
}
