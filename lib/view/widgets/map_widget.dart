import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_more/config.dart';

class MapWidget extends StatelessWidget {
  List<MapTrail> trails;

  MapWidget({
    Key? key,
    required this.trails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;

    var bounds = LatLngBounds();
    for (var trail in trails) {
      bounds.extendBounds(LatLngBounds.fromPoints(trail.coordinates));
    }
    bounds.pad(0.4);

    var options = MapOptions(bounds: bounds);

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
            PolylineLayerOptions(
              polylines: trails
                  .map((trail) => Polyline(
                        points: trail.coordinates,
                        color: trail.active
                            ? colors.primary
                            : colors.onSurfaceVariant,
                        strokeWidth: 2,
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    ]);
  }
}

class MapTrail {
  List<LatLng> coordinates;
  bool active;

  MapTrail({
    required this.coordinates,
    this.active = true,
  });
}
