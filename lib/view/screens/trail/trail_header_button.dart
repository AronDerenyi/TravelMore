import 'package:flutter/material.dart';

class TrailHeaderButton extends StatelessWidget {
  final IconData icon;
  final bool checked;
  final void Function(bool checked) onChanged;

  const TrailHeaderButton({
    Key? key,
    required this.icon,
    required this.checked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;

    return Material(
      type: MaterialType.circle,
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      child: IconButton(
        visualDensity: VisualDensity.compact,
        icon: Icon(
          icon,
          color: checked ? colors.primary : colors.onSurfaceVariant,
        ),
        onPressed: () => onChanged(!checked),
      ),
    );
  }
}
