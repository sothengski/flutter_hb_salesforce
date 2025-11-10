import 'package:go_router/go_router.dart';
import 'package:flutter_hb_salesforce/features/features.dart';

enum AppRoute { home, login, register }

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: AppRoute.login.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: AppRoute.register.name,
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
