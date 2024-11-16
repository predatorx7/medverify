import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class _Navigation {
  final route = GoRoute(
    path: 'share',
    name: 'share',
    builder: (context, state) => const ShareReportsScreen(),
  );
}

typedef ShareReportsResponse = ({String attestationId, String receiverId});

class ShareReportsScreen extends ConsumerStatefulWidget {
  const ShareReportsScreen({super.key});

  static final navigation = _Navigation();

  @override
  ConsumerState<ShareReportsScreen> createState() => _SeekReportsScreenState();
}

class _SeekReportsScreenState extends ConsumerState<ShareReportsScreen>
    with WidgetsBindingObserver {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final controller = MobileScannerController(
    useNewCameraSelector: true,
  );

  bool isFlashOn = false;

  late StreamSubscription<BarcodeCapture>? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _subscription = controller.barcodes.listen(_handleBarcode);

    unawaited(controller.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  Barcode? _barcode;

  void _handleBarcode(BarcodeCapture barcodes) {
    print(barcodes.barcodes.firstOrNull);
    if (mounted) {
      setState(() {
        final barcode = barcodes.barcodes.firstOrNull;
        _barcode = barcode;
        if (barcode != null) {
          _onBarcodeFound(barcode);
        }
      });
    }
  }

  void _onBarcodeFound(Barcode barcode) {
    print(barcode);
    final bytes = barcode.rawBytes;
    if (bytes == null) return;
    final decoded = utf8.decode(bytes);
    final parts = decoded.split('#');
    final [receiverId, attestationId] = parts;
    final ShareReportsResponse response =
        (receiverId: receiverId, attestationId: attestationId);
    context.pop(response);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    controller.dispose();
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
              await controller.toggleTorch();
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
            child: Material(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 10,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: MobileScanner(
                key: qrKey,
                controller: controller,
                errorBuilder: (context, error, child) {
                  return ScannerErrorWidget(error: error);
                },
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({super.key, required this.error});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = 'Controller not ready.';
      case MobileScannerErrorCode.permissionDenied:
        errorMessage = 'Permission denied';
      case MobileScannerErrorCode.unsupported:
        errorMessage = 'Scanning is unsupported on this device';
      default:
        errorMessage = 'Generic Error';
        break;
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Icon(Icons.error, color: Colors.white),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              error.errorDetails?.message ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
