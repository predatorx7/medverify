import 'package:frog/feature/auth/auth.dart';
import 'package:frog/screens/dashboard.dart';
import 'package:frog/screens/launch.dart';
import 'package:frog/screens/signup/signup.dart';
import 'package:frog/screens/welcome.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  refreshListenable: authChangeNotifier,
  routes: [
    // the root route
    LaunchScreen.navigation.route,
    WelcomeScreen.navigation.route,
    SignupScreen.navigation.route,
    DashboardScreen.navigation.route,
  ],
);
