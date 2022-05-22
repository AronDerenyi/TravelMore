import 'package:flutter/material.dart';

class FeaturedCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const FeaturedCard({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
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
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: titlePadding.dx,
                bottom: titlePadding.dy,
                child: Text(title, style: textTheme.headlineMedium),
              ),
              Positioned.fill(
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(onTap: onTap),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
