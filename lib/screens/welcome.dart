import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class _Navigation {
  final router = GoRoute(
    path: '/welcome',
    name: 'welcome',
    builder: (context, state) => const WelcomeScreen(),
  );
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static final navigation = _Navigation();

  @override
  Widget build(BuildContext context) {
    return const Text('Welcome');
  }
}
