import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/ui/widgets/pantry_quick_add_widget.dart';

class QuickAddScreen extends StatelessWidget {
  const QuickAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: PantryQuickAddWidget());
  }
}
