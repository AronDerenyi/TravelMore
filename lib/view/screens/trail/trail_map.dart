import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_more/bloc/trail_bloc.dart';
import 'package:travel_more/config.dart';

class TrailMap extends StatelessWidget {
  const TrailMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrailBloc, TrailBlocState>(
      builder: (context, state) {
        var colors = Theme.of(context).colorScheme;

        if (state is LoadingTrailState) {
          return Container(color: colors.background);
        }

        if (state is TrailReadyState) {
          var points = state.coordinates
              .map((coord) => LatLng(coord.lat, coord.long))
              .toList();

          var options = MapOptions(
            bounds: LatLngBounds.fromPoints(points)..pad(0.4),
          );

          return Stack(children: [
            Positioned.fill(child: Container(color: colors.surface)),
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: const ColorFilter.matrix([
                  0.2126 * 1.2,
                  0.7152 * 1.2,
                  0.0722 * 1.2,
                  0,
                  0,
                  0.2126 * 1.2,
                  0.7152 * 1.2,
                  0.0722 * 1.2,
                  0,
                  0,
                  0.2126 * 1.2,
                  0.7152 * 1.2,
                  0.0722 * 1.2,
                  0,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                ]),
                child: FlutterMap(
                  options: options,
                  layers: [TileLayerOptions(urlTemplate: Config.mapUrl)],
                ),
              ),
            ),
            Positioned.fill(
              child: FlutterMap(
                options: options,
                layers: [
                  PolylineLayerOptions(polylines: [
                    Polyline(
                      points: points,
                      color: colors.primary,
                      strokeWidth: 2,
                    )
                  ])
                ],
              ),
            ),
          ]);
        }

        throw Exception();
      },
    );
  }
}
