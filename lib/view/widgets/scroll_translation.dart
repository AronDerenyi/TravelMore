import 'package:flutter/material.dart';

class ScrollTranslation extends StatelessWidget {
  final Widget child;
  final ScrollController controller;
  final Offset direction;

  const ScrollTranslation({
    Key? key,
    required this.child,
    required this.controller,
    required this.direction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: child,
      builder: (context, child) {
        var hasClients = controller.hasClients;
        var scroll = hasClients ? controller.offset : 0.0;
        var offset = direction.scale(-scroll, -scroll);
        return Transform.translate(
          offset: offset,
          child: child,
        );
      },
    );
  }
}
