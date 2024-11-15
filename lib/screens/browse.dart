import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class _Navigation {
  final router = GoRoute(
    path: 'browse',
    name: 'browse',
    builder: (context, state) => const BrowseScreen(),
  );
}

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  static final navigation = _Navigation();

  @override
  Widget build(BuildContext context) {
    return const Text('Browse');
  }
}
