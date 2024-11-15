import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class _Navigation {
  final router = GoRoute(
    path: '/signup',
    name: 'signup',
    builder: (context, state) => const SignupScreen(),
  );
}

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  static final navigation = _Navigation();

  @override
  Widget build(BuildContext context) {
    return const Text('Signup');
  }
}
