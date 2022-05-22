import 'package:flutter/material.dart';
import 'package:travel_more/bloc/discover_bloc.dart';
import 'package:travel_more/view/screens/main/discover/discover_trail_card.dart';

class DiscoverRegionRow extends StatelessWidget {
  final RegionItem region;

  const DiscoverRegionRow({
    Key? key,
    required this.region,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            region.title,
            style: textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 240,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 16),
            itemCount: region.trails.length,
            itemBuilder: (context, index) => DiscoverTrailCard(
              trail: region.trails[index],
            ),
          ),
        ),
      ],
    );
  }
}
