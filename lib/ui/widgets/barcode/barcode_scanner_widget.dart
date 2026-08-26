import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerWidget extends StatefulWidget {
  final Function(String) onBarcodeScanned;
  final bool isProductLoading;

  const BarcodeScannerWidget({
    super.key,
    required this.onBarcodeScanned,
    required this.isProductLoading
  });

  @override
  State<BarcodeScannerWidget> createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> {
  final MobileScannerController _controller = MobileScannerController(
    autoStart: false,
  );
  PermissionStatus _permissionStatus = PermissionStatus.denied;
  bool _isChecking = true;

  final Map<String, int> _tally = {};
  static const int _sampleTarget = 4;
  static const int _maxSamples = 20;

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermission();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

      if (status.isGranted) {
        _controller.start();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Barcode')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isChecking || widget.isProductLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_permissionStatus.isGranted) {
      return MobileScanner(
        controller: _controller,
        onDetect: (capture) async {
          final value = capture.barcodes.firstOrNull?.rawValue;
          if (value == null) return;

          _tally[value] = (_tally[value] ?? 0) + 1;
          final totalSamples = _tally.values.fold(0, (a, b) => a + b);
          final leader = _tally.entries.reduce((a, b) => a.value >= b.value ? a : b);

          if (leader.value >= _sampleTarget || totalSamples >= _maxSamples) {
            await _controller.stop();
            widget.onBarcodeScanned(leader.key);
            _tally.clear();
          }
        }
        // onDetect: (capture) async {
        //   final barcode = capture.barcodes.firstOrNull;
        //   if (barcode?.rawValue != null) {
        //     await _controller.stop();
        //     widget.onBarcodeScanned(barcode!.rawValue as String);
        //   }
        // },
      );
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
              label: Text(
                isPermanent ? 'Open App Settings' : 'Grant Permission',
              ),
              onPressed: () {
                if (isPermanent) {
                  openAppSettings();
                } else {
                  _checkAndRequestPermission();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
