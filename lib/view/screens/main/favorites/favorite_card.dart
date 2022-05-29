import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:travel_more/bloc/favorite_trails_bloc.dart';
import 'package:travel_more/view/screens/trail/trail_screen.dart';

class FavoriteCard extends StatelessWidget {
  final FavoriteTrailItem trail;

  const FavoriteCard({
    Key? key,
    required this.trail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var colors = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Image.network(
                    trail.image,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        trail.title,
                        style: textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        trail.title,
                        style: textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: Icon(
                    trail.completed
                        ? Icons.check
                        : Icons.directions_walk,
                    color: trail.completed
                        ? colors.primary
                        : colors.onSurfaceVariant,
                  ),
                  onPressed: () {
                    context.read<FavoriteTrailsBloc>().add(trail.completed
                        ? UnsetCompletedEvent(trail.trailId)
                        : SetCompletedEvent(trail.trailId));
                  },
                )
              ],
            ),
          ),
          onTap: () => Navigator.push(
            context,
            TrailScreen.route(trail.trailId),
          ),
        ),
      ),
    );
  }
}
