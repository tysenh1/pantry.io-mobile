

import 'package:flutter/material.dart';

class StyledContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  const StyledContainer({
    super.key,
    required this.child,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color ?? Theme.of(context).colorScheme.primaryContainer
      ),
      child: child
    );
  }
}