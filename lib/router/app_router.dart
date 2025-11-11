import 'package:flutter_hb_salesforce/router/not_found_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hb_salesforce/router/go_router_refresh_stream.dart';
import 'package:flutter_hb_salesforce/features/features.dart';

enum AppRoute { home, login, register, account }

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      final path = state.uri.path;
      if (isLoggedIn) {
        if (path == '/login') {
          return '/account';
        }
      } else {
        if (path == '/account' || path == '/orders') {
          return '/login';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(
      authRepository.authStateChanges.asBroadcastStream(),
    ),

    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: AppRoute.login.name,
        builder: (context, state) =>
            LoginScreen(formType: EmailPasswordSignInFormType.signIn),
      ),
      GoRoute(
        path: '/register',
        name: AppRoute.register.name,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/account',
        name: AppRoute.account.name,
        // builder: (context, state) => AccountScreen(),
        pageBuilder: (context, state) =>
            const MaterialPage(fullscreenDialog: true, child: AccountScreen()),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
