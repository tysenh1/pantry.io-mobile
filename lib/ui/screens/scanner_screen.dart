import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/ui/widgets/barcode_permissions_widget.dart';
import 'package:pantry_io_mobile/ui/widgets/lazy_widget_wrapper.dart';

class ScannerScreen extends StatelessWidget {
  final bool isActiveTab;
  const ScannerScreen({super.key, required this.isActiveTab});

  @override
  Widget build(BuildContext context) {
    return Center(child: LazyWidgetWrapper(isVisible: isActiveTab, child: BarcodePermissionsWidget()));
  }
}
