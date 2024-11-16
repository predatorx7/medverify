import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healtheye/data/user.dart';
import 'package:healtheye/feature/auth/auth.dart';
import 'package:healtheye/feature/link/link_document.dart';
import 'package:healtheye/feature/link/validate.dart';
import 'package:healtheye/feature/reports/data/report.dart';
import 'package:healtheye/feature/reports/reports.dart';
import 'package:healtheye/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:healtheye/logging.dart';
import 'package:healtheye/screens/dashboard/seek_reports/screen.dart';
import 'package:intl/intl.dart';

import 'reports/screen.dart';

class _Navigation {
  final route = GoRoute(
    redirect: (context, state) {
      final authState = ProviderScope.containerOf(context).read(authProvider);
      if (!authState.isAuthenticated) {
        return '/';
      }
      return null;
    },
    path: '/dashboard',
    name: 'dashboard',
    builder: (context, state) => const DashboardScreen(),
    routes: [
      ReportsScreen.navigation.route,
      SeekReportsScreen.navigation.route,
    ],
  );
}

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  static final navigation = _Navigation();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final user = auth.user!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Reports'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              context.goNamed('seek-reports');
            },
            tooltip: 'Share Reports',
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Show profile menu
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  MediaQuery.of(context).size.width,
                  kToolbarHeight,
                  0,
                  0,
                ),
                items: [
                  PopupMenuItem(
                    child: const Text('Sign Out'),
                    onTap: () {
                      ref.read(authProvider.notifier).signOut();
                    },
                  ),
                ],
              );
            },
            tooltip: 'Profile Menu',
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          UserProfileCardSliver(user: user),
          LinkReportsSectionSliver(),
          UserReportsListSliver(),
        ],
      ),
    );
  }
}

class LinkReportsSectionSliver extends ConsumerStatefulWidget {
  const LinkReportsSectionSliver({super.key});

  @override
  ConsumerState<LinkReportsSectionSliver> createState() =>
      _LinkReportsSectionState();
}

class _LinkReportsSectionState extends ConsumerState<LinkReportsSectionSliver> {
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  VerifiedDocument? _recentlyVerifiedDocument;
  VerifiedFile? _recentlyVerifiedFile;

  Future<void> _onDocumentVerificationUpdate(
      LinkDocumentVerificationUpdate update) async {
    $logger.child('_onDocumentVerificationUpdate').info(update.info);
  }

  Future<void> _onFileVerificationUpdate(
      LinkDocumentFileVerificationUpdate update) async {
    $logger.child('_onFileVerificationUpdate').info(update.file);
  }

  Future<VerifiedFile> startFileVerification(String url) async {
    final log = $logger.child('startVerification');
    final sm = ScaffoldMessenger.of(context);
    final linkDocumentService = ref.read(linkDocumentServiceProvider);
    try {
      final file = await linkDocumentService.getFileAttestation(
          url, _onFileVerificationUpdate);
      log.info('File verified', file);
      setState(() {
        _recentlyVerifiedFile = file;
      });
      sm.showSnackBar(SnackBar(content: Text('File verified')));
      return file;
    } catch (e, s) {
      log.severe('Error during verification', e, s);
      sm.showSnackBar(SnackBar(content: Text(e.toString())));
      rethrow;
    }
  }

  Future<void> startDocumentVerification(String url, VerifiedFile file) async {
    final log = $logger.child('startVerification');
    final sm = ScaffoldMessenger.of(context);
    final linkDocumentService = ref.read(linkDocumentServiceProvider);
    try {
      final document = await linkDocumentService.getDocument(
        url,
        file,
        _onDocumentVerificationUpdate,
      );

      log.info('Document verified', document);

      setState(() {
        _recentlyVerifiedDocument = document;
      });

      sm.showSnackBar(SnackBar(content: Text('Document verified')));

      ref.read(userReportsProvider.notifier).addReport(file, document);
    } catch (e, s) {
      log.severe('Error during verification', e, s);
      sm.showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void startVerification() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.makeSureUrlIsValid),
        ),
      );
      return;
    }
    final _recentlyVerifiedFile = await startFileVerification(url);
    await startDocumentVerification(url, _recentlyVerifiedFile);
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: MedicalReportUrlInput(
                  controller: _urlController,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _urlController,
              builder: (context, snapshot) {
                final url = _urlController.text.trim();
                return FilledButton.icon(
                  onPressed:
                      !UrlValidator.isValid(url) ? null : startVerification,
                  icon: const Icon(Icons.verified),
                  label: const Text('Verify and Link Document'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserReportsListSliver extends ConsumerWidget {
  const UserReportsListSliver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(userReportsProvider);
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1.5,
      ),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];
        return ReportCard(
          report: report,
        );
      },
    );
  }
}

class ReportCard extends StatelessWidget {
  final Report report;

  const ReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed('report', pathParameters: {
          'report_id': report.id,
        });
      },
      child: GridTile(
        header: GridTileBar(
          title: Text(report.title),
          subtitle: Text(report.description),
        ),
        footer: Text(DateFormat('dd MMM, yyyy').format(report.createdAt)),
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.memory(base64.decode(report.file.base64Data)),
        ),
      ),
    );
  }
}

class UserProfileCardSliver extends StatelessWidget {
  final User user;

  const UserProfileCardSliver({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        margin: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const UserAvatar(),
              const SizedBox(width: 16),
              UserInfo(user: user),
            ],
          ),
        ),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 30,
      child: Icon(Icons.person, size: 35),
    );
  }
}

class UserInfo extends StatelessWidget {
  final User user;

  const UserInfo({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.fullName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          if (user.email != null)
            Text(
              user.email!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
        ],
      ),
    );
  }
}

class MedicalReportUrlInput extends StatelessWidget {
  final TextEditingController controller;

  const MedicalReportUrlInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter medical report URL for verification',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: UrlTextField(controller: controller),
            ),
            const SizedBox(width: 8),
            PasteButton(controller: controller),
          ],
        ),
      ],
    );
  }
}

class UrlTextField extends StatelessWidget {
  final TextEditingController controller;

  const UrlTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Paste or type URL here',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return context.l10n.provideTheDocumentUrl;
        }
        if (!UrlValidator.isValid(value)) {
          return context.l10n.makeSureUrlIsValid;
        }
        return null;
      },
    );
  }
}

class PasteButton extends StatelessWidget {
  final TextEditingController controller;

  const PasteButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () async {
        final data = await Clipboard.getData('text/plain');
        if (data?.text?.isNotEmpty == true) {
          controller.text = data!.text!;
        }
      },
      icon: const Icon(Icons.paste),
      tooltip: 'Paste from clipboard',
    );
  }
}
