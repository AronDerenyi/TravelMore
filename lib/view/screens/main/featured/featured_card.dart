import 'package:flutter/material.dart';
import 'package:travel_more/bloc/featured_trails_bloc.dart';
import 'package:travel_more/view/screens/trail/trail_screen.dart';

class FeaturedCard extends StatelessWidget {
  final FeaturedItem item;

  const FeaturedCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.primaryTextTheme;

    var aspectRatio = 1.5;
    var titlePadding = const Offset(20, 12);
    var borderRadius = const BorderRadius.all(Radius.circular(16));
    var boxShadow = const BoxShadow(
      color: Colors.black38,
      blurRadius: 24,
      offset: Offset(0, 12),
    );

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: [boxShadow],
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  item.image,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: titlePadding.dx,
                bottom: titlePadding.dy,
                child: Text(item.title, style: textTheme.headlineMedium),
              ),
              Positioned.fill(
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      TrailScreen.route(item.trailId),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
