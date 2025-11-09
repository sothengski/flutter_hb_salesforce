import 'package:go_router/go_router.dart';
import 'package:flutter_hb_salesforce/features/features.dart';

enum AppRoute { home }

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
