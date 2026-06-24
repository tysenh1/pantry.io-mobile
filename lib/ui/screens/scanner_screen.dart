import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/ui/widgets/lazy_widget_wrapper.dart';
import 'package:pantry_io_mobile/ui/widgets/add_pantry_item_widget.dart';

class ScannerScreen extends StatelessWidget {
  final bool isActiveTab;
  const ScannerScreen({super.key, required this.isActiveTab});

  @override
  Widget build(BuildContext context) {
    return Center(child: LazyWidgetWrapper(isVisible: isActiveTab, child: PantryAddItemWidget()));
  }
}
