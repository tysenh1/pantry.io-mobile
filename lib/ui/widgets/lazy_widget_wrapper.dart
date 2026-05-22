import 'package:flutter/material.dart';

class LazyWidgetWrapper extends StatefulWidget {
  final Widget child;
  final bool isVisible;

  const LazyWidgetWrapper({super.key, required this.child, required this.isVisible});

  @override
  State<LazyWidgetWrapper> createState() => _LazyWidgetWrapperState();
}

class _LazyWidgetWrapperState extends State<LazyWidgetWrapper> {
  bool _hasBeenRendered = false;

  @override
  Widget build(BuildContext build) {
    if (widget.isVisible && !_hasBeenRendered) {
      _hasBeenRendered = true;
    }

    if (_hasBeenRendered) {
      return widget.child;
    }

    return const SizedBox.shrink();
  }
}