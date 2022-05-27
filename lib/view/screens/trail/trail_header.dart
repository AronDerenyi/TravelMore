import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:travel_more/bloc/trail_bloc.dart';
import 'package:travel_more/view/screens/trail/trail_header_button.dart';

class TrailHeader extends StatelessWidget {
  const TrailHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = const EdgeInsets.fromLTRB(24, 24, 24, 0);
    var spacing = 4.0;

    return BlocBuilder<TrailBloc, TrailBlocState>(
      builder: (context, state) {
        var theme = Theme.of(context);
        var textTheme = theme.textTheme;
        var colors = theme.colorScheme;

        if (state is LoadingTrailState) {
          return const SizedBox();
        }

        if (state is TrailReadyState) {
          return Padding(
            padding: padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        state.title,
                        style: textTheme.titleLarge
                            ?.copyWith(color: colors.primary),
                      ),
                      SizedBox(height: spacing),
                      Text(
                        state.title,
                        style: textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
                Material(
                  type: MaterialType.circle,
                  color: Colors.transparent,
                  clipBehavior: Clip.hardEdge,
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      state.favorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      color: state.favorite
                          ? colors.primary
                          : colors.onSurfaceVariant,
                    ),
                    onPressed: () => context.read<TrailBloc>().add(
                        state.favorite
                            ? UnsetFavoriteEvent()
                            : SetFavoriteEvent()),
                  ),
                ),
              ],
            ),
          );
        }

        throw Exception();
      },
    );
  }
}
