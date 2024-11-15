import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class _Navigation {
  final router = GoRoute(
    path: '/',
    name: '/',
    builder: (context, state) => const LaunchScreen(),
  );
}

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  static final navigation = _Navigation();

  @override
  Widget build(BuildContext context) {
    return const Text('Launch');
  }
}
