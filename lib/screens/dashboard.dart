import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frog/data/user.dart';
import 'package:frog/feature/auth/auth.dart';
import 'package:frog/feature/link/link_document.dart';
import 'package:frog/feature/link/validate.dart';
import 'package:frog/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:frog/logging.dart';

import 'browse.dart';

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
      BrowseScreen.navigation.router,
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
      appBar: AppBar(),
      body: Column(
        children: [
          UserProfileCard(user: user),
          LinkReportsSection(),
        ],
      ),
    );
  }
}

class LinkReportsSection extends ConsumerStatefulWidget {
  const LinkReportsSection({super.key});

  @override
  ConsumerState<LinkReportsSection> createState() => _LinkReportsSectionState();
}

class _LinkReportsSectionState extends ConsumerState<LinkReportsSection> {
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  VerifiedDocument? _recentlyVerifiedDocument;

  Future<void> _onUpdate(LinkDocumentVerificationUpdate update) async {
    $logger.child('onUpdate').info('Document verification update', update);
  }

  Future<void> startVerification(String url) async {
    final log = $logger.child('startVerification');
    final sm = ScaffoldMessenger.of(context);
    final linkDocumentService = ref.read(linkDocumentServiceProvider);
    try {
      final document = await linkDocumentService.getDocument(url, _onUpdate);
      log.info('Document verified', document);
      setState(() {
        _recentlyVerifiedDocument = document;
      });
      sm.showSnackBar(SnackBar(content: Text('Document verified')));
    } catch (e, s) {
      log.severe('Error during verification', e, s);
      sm.showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MedicalReportUrlInput(controller: _urlController),
            const SizedBox(height: 16),
            AnimatedBuilder(
              animation: _urlController,
              builder: (context, snapshot) {
                final url = _urlController.text.trim();
                return FilledButton.icon(
                  onPressed: !UrlValidator.isValid(url)
                      ? null
                      : () {
                          final url = _urlController.text.trim();
                          if (url.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(context.l10n.makeSureUrlIsValid),
                              ),
                            );
                            return;
                          }
                          startVerification(url);
                        },
                  icon: const Icon(Icons.verified),
                  label: const Text('Verify and Link Document'),
                );
              },
            ),
            if (_recentlyVerifiedDocument != null)
              SingleChildScrollView(
                child: SelectableText(
                  json.encode(_recentlyVerifiedDocument!.properties),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class UserProfileCard extends StatelessWidget {
  final User user;

  const UserProfileCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
