import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'browse.dart';

class _Navigation {
  final router = GoRoute(
    path: '/dashboard',
    name: 'dashboard',
    builder: (context, state) => const DashboardScreen(),
    routes: [
      BrowseScreen.navigation.router,
    ],
  );
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static final navigation = _Navigation();

  @override
  Widget build(BuildContext context) {
    return const Text('Dashboard');
  }
}
