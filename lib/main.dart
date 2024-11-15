import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      title: 'Med Verify',
      theme: theme.light(),
      darkTheme: theme.dark(),
    );
  }
}
