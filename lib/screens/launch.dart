import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frog/feature/auth/auth.dart';
import 'package:frog/screens/dashboard.dart';
import 'package:frog/screens/welcome.dart';
import 'package:go_router/go_router.dart';

class _Navigation {
  final route = GoRoute(
    path: '/',
    name: '/',
    builder: (context, state) => const LaunchScreen(),
  );
}

class LaunchScreen extends ConsumerStatefulWidget {
  const LaunchScreen({super.key});

  static final navigation = _Navigation();

  @override
  ConsumerState<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends ConsumerState<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    // preinitialize the auth state
    ref.read(authProvider);
    Future.delayed(const Duration(milliseconds: 700), _navigateNext);
  }

  void _navigateNext() {
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated) {
      return context.goNamed(WelcomeScreen.navigation.route.name!);
    }
    return context.goNamed(DashboardScreen.navigation.route.name!);
  }

  @override
  Widget build(BuildContext context) {
    return const Text('Launch');
  }
}
