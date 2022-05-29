import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_more/config.dart';

class MapWidget extends StatelessWidget {
  List<MapTrail> trails;
  List<MapMarker> markers;
  double padding;

  MapWidget(
      {Key? key,
      this.trails = const [],
      this.markers = const [],
      this.padding = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;

    var bounds = LatLngBounds();
    for (var trail in trails) {
      bounds.extendBounds(LatLngBounds.fromPoints(trail.coordinates));
    }
    for (var marker in markers) {
      bounds.extend(marker.coordinates);
    }
    bounds.pad(padding);

    var options = MapOptions(
      bounds: bounds,
      interactiveFlags: InteractiveFlag.none,
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
            PolylineLayerOptions(
              polylines: trails
                  .map(
                    (trail) => Polyline(
                      points: trail.coordinates,
                      color: trail.active
                          ? colors.primary
                          : colors.onSurfaceVariant,
                      strokeWidth: 2,
                    ),
                  )
                  .toList(),
            ),
            MarkerLayerOptions(
              markers: markers
                  .map(
                    (marker) => Marker(
                      point: marker.coordinates,
                      width: 24,
                      height: 24,
                      anchorPos: AnchorPos.align(AnchorAlign.top),
                      builder: (context) => marker.active
                          ? Icon(
                              Icons.where_to_vote_rounded,
                              color: colors.primary,
                              size: 24,
                            )
                          : Icon(
                              Icons.fmd_good_rounded,
                              color: colors.onSurfaceVariant,
                              size: 24,
                            ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      const Positioned.fill(child: SizedBox()),
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

class MapMarker {
  LatLng coordinates;
  bool active;

  MapMarker({
    required this.coordinates,
    this.active = true,
  });
}
