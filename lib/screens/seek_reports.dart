import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:healtheye/logging.dart';

class _Navigation {
  final route = GoRoute(
    path: 'seek-reports',
    name: 'seek-reports',
    builder: (context, state) => const SeekReportsScreen(),
  );
}

class SeekReportsScreen extends ConsumerStatefulWidget {
  const SeekReportsScreen({super.key});

  static final navigation = _Navigation();

  @override
  ConsumerState<SeekReportsScreen> createState() => _SeekReportsScreenState();
}

class _SeekReportsScreenState extends ConsumerState<SeekReportsScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isFlashOn = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off),
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {
                isFlashOn = !isFlashOn;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Theme.of(context).colorScheme.primary,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        $logger.info('QR Code scanned: ${scanData.code}');
        // Handle the scanned QR code here
        // You might want to navigate to a specific report or show details
      }
    });
  }
}
