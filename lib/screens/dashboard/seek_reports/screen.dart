import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healtheye/feature/auth/auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:reclaim_flutter_sdk/reclaim_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

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
  Timer? _pollTimer;
  final referenceId = generateAttestationId();
  bool _isPolling = false;

  String? get publicKey => ref.watch(authProvider).keys?.publicKey;

  // Combine public key and attestation ID with # separator
  String get qrData => '$publicKey#$referenceId';

  @override
  void initState() {
    super.initState();
    print({'SeekReportsScreen.initState': 'initState'});
    _startPolling();
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  void _startPolling() {
    setState(() {
      _isPolling = true;
    });
    print({'SeekReportsScreen._startPolling': 'startPolling'});
    // Poll every 5 seconds
    _pollTimer =
        Timer.periodic(const Duration(seconds: 5), (_) => _checkReports());
  }

  dynamic sharedResult = null;

  Future<void> _checkReports() async {
    print({
      'SeekReportsScreen._checkReports': 'checkReports',
      'publicKey': publicKey
    });
    if (publicKey == null) return;

    try {
      final response = await http.get(
        Uri.parse(
            '${String.fromEnvironment('RECLAIM_BACKEND_URL', defaultValue: 'https://aa40-27-131-162-179.ngrok-free.app')}/api/status?referenceId=$referenceId'),
        headers: {'Content-Type': 'application/json'},
      );
      print({
        'SeekReportsScreen._checkReports': 'response',
        'response': response.statusCode,
        'body': response.body,
      });
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == "success") {
          sharedResult = result;
          _pollTimer?.cancel(); // Stop polling once we get a true response
          onReceiveReport();
          Future.microtask(() {
            if (mounted) {
              setState(() {});
            }
          });
        }
      }
    } catch (e) {
      debugPrint('Error checking reports: $e');
    }
  }

  void onReceiveReport() {
    setState(() {
      _isPolling = false;
    });
    // Add any additional logic for handling the received report
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
            if (_isPolling) ...[
              const SizedBox(height: 24),
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Waiting for reports to be shared...',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
