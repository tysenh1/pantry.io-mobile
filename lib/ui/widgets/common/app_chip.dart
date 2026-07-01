import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppChipMode { display, removable, selectable }

class AppChip extends StatelessWidget {
  final String label;
  final AppChipMode mode;
  final bool isSelected;
  final VoidCallback? onSelect;
  final VoidCallback? onRemoved;

  const AppChip({
    super.key,
    required this.label,
    this.mode = AppChipMode.display,
    this.isSelected = false,
    this.onSelect,
    this.onRemoved,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = switch (mode) {
      AppChipMode.selectable when isSelected =>
        Theme.of(context).colorScheme.primary,
      _ => Theme.of(context).colorScheme.surfaceContainerLow
    };

    final Color textColor = switch (mode) {
      AppChipMode.selectable when isSelected =>
        Colors.white,
      _ => Theme.of(context).colorScheme.secondary
    };

    return GestureDetector(
      onTap: mode == AppChipMode.selectable ? onSelect : null,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: textColor,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
            if (mode == AppChipMode.removable && onRemoved != null) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onRemoved,
                child: Icon(
                  Icons.close,
                  size: 12,
                  color: textColor
                )
              )
            ]
          ]
        )
      )
    );
  }
}