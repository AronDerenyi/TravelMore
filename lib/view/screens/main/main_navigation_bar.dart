import 'dart:ui';

import 'package:flutter/material.dart';

class MainNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int selectedIndex) onSelected;

  const MainNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colors = theme.colorScheme;

    var paddingVertical = 6.0;
    var paddingHorizontal = 12.0;
    var spacing = 8.0;
    var boxShadow = const BoxShadow(
      color: Colors.black12,
      blurRadius: 24,
      offset: Offset(0, 12),
    );

    Color iconColor(active) {
      return active ? colors.primary : colors.onSurface.withAlpha(63);
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: [boxShadow],
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 16,
          sigmaY: 16,
        ),
        child: Opacity(
          opacity: 0.75,
          child: Material(
            color: colors.surface,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: paddingVertical,
                horizontal: paddingHorizontal,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home_rounded),
                    color: iconColor(selectedIndex == 0),
                    onPressed: () => onSelected(0),
                  ),
                  SizedBox(width: spacing),
                  IconButton(
                    icon: const Icon(Icons.explore_rounded),
                    color: iconColor(selectedIndex == 1),
                    onPressed: () => onSelected(1),
                  ),
                  SizedBox(width: spacing),
                  IconButton(
                    icon: const Icon(Icons.favorite_rounded),
                    color: iconColor(selectedIndex == 2),
                    onPressed: () => onSelected(2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
