import 'package:healtheye/feature/auth/auth.dart';
import 'package:healtheye/screens/dashboard/screen.dart';
import 'package:healtheye/screens/launch.dart';
import 'package:healtheye/screens/signup/signup.dart';
import 'package:healtheye/screens/welcome.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  refreshListenable: authChangeNotifier,
  routes: [
    // the root route
    LaunchScreen.navigation.route,
    WelcomeScreen.navigation.route,
    SignupScreen.navigation.route,
    DashboardScreen.navigation.route,
  ],
);
