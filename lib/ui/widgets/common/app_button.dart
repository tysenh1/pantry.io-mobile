

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppButtonType { primary, secondary }
enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.large,
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    final content = icon != null
      ? Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          Text(label)
        ]
      )
      : Text(label);

    final padding = switch (size) {
      AppButtonSize.small => const EdgeInsets.symmetric(horizontal: 12),
      AppButtonSize.medium => const EdgeInsets.symmetric(horizontal: 24),
      AppButtonSize.large => const EdgeInsets.symmetric(horizontal: 36),
    };

    final height = switch (size) {
      AppButtonSize.small => 32.0,
      AppButtonSize.medium => 44.0,
      AppButtonSize.large => 56.0,
    };

    final fontSize = switch (size) {
      AppButtonSize.small => 14.0,
      AppButtonSize.medium => 16.0,
      AppButtonSize.large => 20.0,
    };

    return switch (type) {
      AppButtonType.primary => FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          padding: padding,
          minimumSize: Size(0, height),
          backgroundColor: Theme.of(context).primaryColor,
          textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: fontSize,
            color: Colors.white,
          )
        ),
        child: content
      ),
      AppButtonType.secondary => OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: padding,
          minimumSize: Size(0, height),
          side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 3),
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
          textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: fontSize,
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Nunito',
          )
        ),
        child: content
      ),
    };
  }
}