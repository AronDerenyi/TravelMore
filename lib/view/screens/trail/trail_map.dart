import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_more/bloc/trail_bloc.dart';
import 'package:travel_more/view/widgets/map_widget.dart';

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
          var trail = MapTrail(
            coordinates: state.coordinates
                .map((coord) => LatLng(coord.lat, coord.long))
                .toList(),
          );

          return MapWidget(padding: 0.4, trails: [trail]);
        }

        throw Exception();
      },
    );
  }
}
