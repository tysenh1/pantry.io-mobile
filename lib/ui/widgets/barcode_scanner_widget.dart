import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class BarcodeScannerWidget extends StatefulWidget {
  final PermissionStatus isAccessGranted;
  const BarcodeScannerWidget({super.key, required this.isAccessGranted});

  @override
  State<BarcodeScannerWidget> createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> {
  final MobileScannerController _controller = MobileScannerController();
  final bool isScanning = true;

  @override
  Widget build(BuildContext context) {
    debugPrint("THIS IS RUNNING");
    return Stack(
      children: [
        MobileScanner(
          controller: _controller,
          onDetect: (capture) async {
            final barcode = capture.barcodes.firstOrNull;
            if (barcode?.rawValue != null) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Scanned'),
                  content: Text("Barcode is: ${barcode?.rawValue}"),
                )
              );
              await _controller.stop();
              // if (mounted) {
              //   Navigator.pop(context, barcode!.rawValue);
              // }
            }
          }
        ),
        Center(
          child: Container(
            width: 280,
            height: 160,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.greenAccent, width: 3),
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withValues(alpha: 0.1)
            )
          )
        )
      ]
    );
  }
}