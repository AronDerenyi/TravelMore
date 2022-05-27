import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:travel_more/bloc/trail_bloc.dart';

class TrailDetails extends StatelessWidget {
  const TrailDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrailBloc, TrailBlocState>(
      builder: (context, state) {
        var theme = Theme.of(context);
        var textTheme = theme.textTheme;
        var colors = theme.colorScheme;

        if (state is LoadingTrailState) {
          return const Center(child: Text("Loading..."));
        }

        if (state is TrailReadyState) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 16),
                    itemCount: state.images.length,
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Image.network(state.images[index]),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: [
                      Text("Distance", style: textTheme.labelLarge),
                      Text(
                        "${state.distance.toStringAsFixed(1)} km",
                        style: textTheme.titleLarge,
                      ),
                    ]),
                    Column(children: [
                      Text("Elevation", style: textTheme.labelLarge),
                      Text(
                        "${state.posElevation.toStringAsFixed(0)} m",
                        style: textTheme.titleLarge,
                      ),
                    ])
                  ],
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    state.description,
                    textAlign: TextAlign.justify,
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
