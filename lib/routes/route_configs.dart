import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kurdistan_food_network/routes/route_constants.dart';
import 'package:kurdistan_food_network/screens/audit_screen.dart';
import 'package:kurdistan_food_network/screens/contact_screen.dart';
import 'package:kurdistan_food_network/screens/home_screen.dart';
import 'package:kurdistan_food_network/screens/auth/login_screen.dart';
import 'package:kurdistan_food_network/screens/not_found_screen.dart';
import 'package:kurdistan_food_network/screens/producer_public_screen.dart';
import 'package:kurdistan_food_network/screens/producer_screen.dart';
import 'package:kurdistan_food_network/screens/product_screen.dart';
import 'package:kurdistan_food_network/screens/profile_screen.dart';
import 'package:kurdistan_food_network/screens/auth/registeration_screen.dart';
import 'package:kurdistan_food_network/screens/shop_screen.dart';
import 'package:kurdistan_food_network/screens/shopping_bag_screen.dart';
import 'package:kurdistan_food_network/utils/auth_helpers.dart';
import 'package:kurdistan_food_network/utils/constants.dart';

class RouteConfigs {
  GoRouter router = GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) => const NotFoundScreen(),
    routes: [
      GoRoute(
        name: RouteConstants.home,
        path: '/',
        builder: (context, state) => const HomeScreen(),
        pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        name: RouteConstants.shop,
        path: '/${RouteConstants.shop}',
        builder: (context, state) => const ShopScreen(),
        pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const ShopScreen(),
        ),
        routes: [
          GoRoute(
            name: RouteConstants.producerPublic,
            path: '${RouteConstants.producerPublic}/:id',
            builder: (context, state) => ProducerPublicScreen(
              id: state.pathParameters['id']!,
            ),
            pageBuilder: (context, state) =>
                buildScreenWithDefaultTransition<void>(
              context: context,
              state: state,
              child: ProducerPublicScreen(
                id: state.pathParameters['id']!,
              ),
            ),
          ),
          GoRoute(
            name: RouteConstants.product,
            path: '${RouteConstants.product}/:id',
            builder: (context, state) => ProductScreen(
              id: state.pathParameters['id']!,
            ),
            pageBuilder: (context, state) =>
                buildScreenWithDefaultTransition<void>(
              context: context,
              state: state,
              child: ProductScreen(
                id: state.pathParameters['id']!,
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        name: RouteConstants.profile,
        path: '/${RouteConstants.profile}',
        builder: (context, state) => const ProfileScreen(),
        pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const ProfileScreen(),
        ),
      ),
      GoRoute(
        name: RouteConstants.producer,
        path: '/${RouteConstants.producer}',
        builder: (context, state) => const ProducerScreen(),
        pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const ProducerScreen(),
        ),
      ),
      GoRoute(
        name: RouteConstants.shoppingBag,
        path: '/${RouteConstants.shoppingBag}',
        builder: (context, state) => const ShoppingBagScreen(),
        pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const ShoppingBagScreen(),
        ),
      ),
      GoRoute(
        name: RouteConstants.contact,
        path: '/${RouteConstants.contact}',
        builder: (context, state) => const ContactScreen(),
        pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const ContactScreen(),
        ),
      ),
      GoRoute(
        name: RouteConstants.audit,
        path: '/${RouteConstants.audit}',
        builder: (context, state) => const AuditScreen(),
        pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const AuditScreen(),
        ),
      ),
      GoRoute(
        name: RouteConstants.login,
        path: '/${RouteConstants.login}',
        builder: (context, state) => const LoginScreen(),
        pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        name: RouteConstants.register,
        path: '/${RouteConstants.register}',
        builder: (context, state) => const RegistrationScreen(),
        pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const RegistrationScreen(),
        ),
      )
    ],
    redirect: (context, state) {
      kCurrentHeight = MediaQuery.of(context).size.height;
      kCurrentWidth = MediaQuery.of(context).size.width;

      var newUrl = '';
      var location = state.location.substring(1);
      var pathParameters = state.pathParameters;

      if (pathParameters.isNotEmpty) {
        var parts = location.split('/');

        newUrl = '${parts[0]}/';

        for (var i = 1; i < (parts.length - pathParameters.length); i++) {
          newUrl = '$newUrl${parts[i]}/';
        }

        newUrl = '/${newUrl.substring(0, newUrl.length - 1)}';
      } else {
        newUrl = state.location;
      }

      if (!isAuth() && !publicRoutes.contains(newUrl)) {
        return '/login';
      }

      if (isAuth() &&
          (state.location == '/login' || state.location == '/register')) {
        return '/';
      }

      return null;
    },
  );
}

// =========== Custom Transition ===========

CustomTransitionPage buildScreenWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
    transitionDuration: const Duration(milliseconds: 300),
  );
}
