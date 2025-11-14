import 'package:flutter_hb_salesforce/router/not_found_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hb_salesforce/router/go_router_refresh_stream.dart';
import 'package:flutter_hb_salesforce/features/features.dart';

enum AppRoute {
  home,
  login,
  register,
  account,
  product,
  orders,
  cart,
  checkout,
  leaveReview,
}

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
          return '/';
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
        builder: (context, state) => ProductsListScreen(),
        routes: [
          GoRoute(
            path: 'account',
            name: AppRoute.account.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: AccountScreen(),
            ),
          ),
          GoRoute(
            path: 'product/:id',
            name: AppRoute.product.name,
            builder: (context, state) {
              final productId = state.pathParameters['id']!;
              return ProductScreen(productId: productId);
            },
            // routes: [
            //   GoRoute(
            //     path: 'review',
            //     name: AppRoute.leaveReview.name,
            //     pageBuilder: (context, state) {
            //       final productId = state.pathParameters['id']!;
            //       return MaterialPage(
            //         fullscreenDialog: true,
            //         child: LeaveReviewScreen(productId: productId),
            //       );
            //     },
            //   ),
            // ],
          ),
          GoRoute(
            path: 'cart',
            name: AppRoute.cart.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: ShoppingCartScreen(),
            ),
            routes: [
              GoRoute(
                path: 'checkout',
                name: AppRoute.checkout.name,
                pageBuilder: (context, state) => const MaterialPage(
                  fullscreenDialog: true,
                  child: CheckoutScreen(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: 'orders',
            name: AppRoute.orders.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: OrdersListScreen(),
            ),
          ),
        ],
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
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
