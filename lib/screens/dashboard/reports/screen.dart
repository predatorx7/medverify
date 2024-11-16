import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healtheye/feature/auth/auth.dart';
import 'package:healtheye/feature/reports/reports.dart';
import 'package:healtheye/screens/dashboard/reports/share_reports/screen.dart';

class _Navigation {
  final route = GoRoute(
    path: 'report/:report_id',
    name: 'report',
    builder: (context, state) => const ReportsScreen(),
    routes: [
      ShareReportsScreen.navigation.route,
    ],
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
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              try {
                final ShareReportsResponse? recipientResponse =
                    await context.pushNamed(
                  'share-report',
                  pathParameters: {'report_id': reportId},
                );
                if (recipientResponse != null) {
                  final success = report.shareProof(
                      ref.read(authProvider.notifier), recipientResponse);
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error generating share proof: $e')),
                );
              }
            },
          ),
        ],
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
