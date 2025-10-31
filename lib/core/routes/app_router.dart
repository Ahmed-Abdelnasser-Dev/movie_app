import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

/// App router configuration using GoRouter
class AppRouter {
  // Private constructor
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: Routes.initial,
    debugLogDiagnostics: true,
    routes: [
      // Initial/Splash route
      GoRoute(
        path: Routes.initial,
        name: Routes.initial,
        builder: (context, state) => const _PlaceholderScreen(title: 'Home'),
      ),

      // Movies list route
      GoRoute(
        path: Routes.movies,
        name: Routes.movies,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Movies List'),
      ),

      // Movie detail route
      GoRoute(
        path: '${Routes.movieDetail}/:${Routes.movieIdParam}',
        name: Routes.movieDetail,
        builder: (context, state) {
          final movieId = state.pathParameters[Routes.movieIdParam];
          return _PlaceholderScreen(title: 'Movie Detail: $movieId');
        },
      ),
    ],
    errorBuilder: (context, state) => const _ErrorScreen(),
  );
}

// Placeholder screens (will be replaced with actual feature screens)
class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Screen placeholder - to be implemented'),
          ],
        ),
      ),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: const Center(
        child: Text('Page not found'),
      ),
    );
  }
}
