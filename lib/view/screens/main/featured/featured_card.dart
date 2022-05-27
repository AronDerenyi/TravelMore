import 'dart:ui';

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
    var textTheme = theme.textTheme;
    var primaryTextTheme = theme.primaryTextTheme;
    var colors = theme.colorScheme;

    var aspectRatio = 1.0;
    var headlinePadding =
        const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
    var titlePadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
    var titleSpacing = 2.0;
    var borderRadius = const BorderRadius.all(Radius.circular(16));
    var boxShadow = const BoxShadow(
      color: Colors.black26,
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
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: headlinePadding,
                      child: Text(
                        item.title,
                        style: primaryTextTheme.headlineMedium,
                      ),
                    ),
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.compose(
                          inner: ImageFilter.blur(
                            sigmaX: 8.0,
                            sigmaY: 8.0,
                          ),
                          outer: ColorFilter.mode(
                            colors.surface.withAlpha(200),
                            BlendMode.srcOver,
                          ),
                        ),
                        child: Padding(
                          padding: titlePadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                item.trailTitle,
                                style: textTheme.titleMedium,
                              ),
                              SizedBox(height: titleSpacing),
                              Text(
                                item.regionTitle,
                                style: textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
