import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healtheye/feature/auth/auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:reclaim_flutter_sdk/reclaim_flutter_sdk.dart';

class _Navigation {
  final route = GoRoute(
    path: 'seek',
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
  final attestationId = generateAttestationId();

  String? get publicKey => ref.watch(authProvider).keys?.publicKey;

  // Combine public key and attestation ID with # separator
  String get qrData => '$publicKey#$attestationId';

  @override
  void initState() {
    super.initState();
  }

  

  void onReceiveReport() {
    // TODO: Implement
  }

  @override
  Widget build(BuildContext context) {
    if (publicKey == null) {
      return const Scaffold(
        body: Center(
          child: Text('No public key available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan to Share Report'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Scan this QR code to share reports with me',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'The sender will need to scan this code\nto share their report with you',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
