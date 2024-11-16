import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healtheye/feature/reports/reports.dart';
import 'package:qr_flutter/qr_flutter.dart';

class _Navigation {
  final route = GoRoute(
    path: 'report/:report_id',
    name: 'report',
    builder: (context, state) => const ReportsScreen(),
  );
}

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  static final navigation = _Navigation();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportId = GoRouterState.of(context).pathParameters['report_id']!;
    final report = ref
        .watch(userReportsProvider)
        .firstWhere((report) => report.id == reportId);

    return Scaffold(
      appBar: AppBar(
        title: Text(report.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      report.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    QrImageView(
                      data: reportId,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Report ID: $reportId',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Created: ${report.createdAt.toString().split('.')[0]}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
