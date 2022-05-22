import 'package:flutter/material.dart';
import 'package:travel_more/bloc/discover_bloc.dart';
import 'package:travel_more/view/screens/trail/trail_screen.dart';

class DiscoverTrailCard extends StatelessWidget {
  final TrailItem trail;

  const DiscoverTrailCard({
    Key? key,
    required this.trail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var colors = theme.colorScheme;

    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Stack(children: [
                Positioned.fill(
                  child: Image.network(
                    trail.image,
                    fit: BoxFit.cover,
                  ),
                ),
                if (trail.favorite)
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Icon(
                      Icons.favorite,
                      color: colors.onPrimary,
                    ),
                  ),
                Positioned.fill(
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        TrailScreen.route(trail.trailId),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 8),
          Text(trail.title, style: textTheme.titleSmall),
          const SizedBox(height: 4),
          Row(children: [
            const Icon(
              Icons.directions_walk,
              size: 14,
            ),
            Text(
              trail.distance.toStringAsFixed(0) + " km",
              style: textTheme.labelMedium,
            ),
          ]),
        ],
      ),
    );
  }
}
