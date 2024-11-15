import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frog/l10n/gen/app_localizations.dart';
import 'package:frog/l10n/l10n.dart';
import 'package:frog/theme.dart';
import 'package:frog/util.dart';

import 'logging.dart';
import 'router/router.dart';

void main() async {
  initializeAppLogging();

  runApp(
    const ProviderScope(
      child: MedVerifyApp(),
    ),
  );
}

class MedVerifyApp extends StatelessWidget {
  const MedVerifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = MaterialTheme(createTextTheme(
      context,
      "Markazi Text",
      "Lexend",
    ));

    return MaterialApp.router(
      routerConfig: router,
      onGenerateTitle: (context) => context.l10n.appTitle,
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        FirebaseUILocalizationDelegate(),
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // debug properties
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
    );
  }
}
