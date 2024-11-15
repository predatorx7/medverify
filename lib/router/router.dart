import 'package:frog/screens/dashboard.dart';
import 'package:frog/screens/launch.dart';
import 'package:frog/screens/signup.dart';
import 'package:frog/screens/welcome.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    // the root route
    LaunchScreen.navigation.router,
    WelcomeScreen.navigation.router,
    SignupScreen.navigation.router,
    DashboardScreen.navigation.router,
  ],
);
