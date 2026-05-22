import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pantry_io_mobile/ui/widgets/barcode_scanner_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class BarcodePermissionsWidget extends StatefulWidget {
  const BarcodePermissionsWidget({super.key});

  @override
  State<BarcodePermissionsWidget> createState() => _BarcodePermissionsWidgetState();
}

class _BarcodePermissionsWidgetState extends State<BarcodePermissionsWidget> {

  PermissionStatus _permissionStatus = PermissionStatus.denied;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermission();
  }

  Future<void> _checkAndRequestPermission() async {
    setState(() => _isChecking = true);

    PermissionStatus status = await Permission.camera.status;

    if (status.isDenied) {
      status = await Permission.camera.request();
    }

    if (mounted) {
      setState(() {
        _permissionStatus = status;
        _isChecking = false;
      });

      // if (status.isGranted) {
      //   _controller.start();
      // }
    }
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Barcode')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isChecking) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_permissionStatus.isGranted) {
      return BarcodeScannerWidget(isAccessGranted: _permissionStatus);
    }

    return _buildPermissionDeniedUI();
  }

  Widget _buildPermissionDeniedUI() {
    final isPermanent = _permissionStatus.isPermanentlyDenied;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Camera Permission Required',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              isPermanent
                ? 'You have disabled camera permissions. Please enable them in your device settings.'
                : 'We need camera permissions to scan your pantry product barcodes.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(isPermanent ? Icons.settings : Icons.refresh),
              label: Text(isPermanent ? 'Open App Settings' : 'Grant Permission'),
              onPressed: () {
                if (isPermanent) {
                  openAppSettings();
                } else {
                  _checkAndRequestPermission();
                }
              }
            )
          ]
        )
      )
    );
  }
}