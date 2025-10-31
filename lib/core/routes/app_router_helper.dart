import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Helper methods for navigation
class AppRouterHelper {
  // Private constructor
  AppRouterHelper._();

  /// Navigate to a route
  static void navigateTo(BuildContext context, String route, {Object? extra}) {
    context.go(route, extra: extra);
  }

  /// Push a route
  static void pushTo(BuildContext context, String route, {Object? extra}) {
    context.push(route, extra: extra);
  }

  /// Navigate back
  static void pop(BuildContext context, {Object? result}) {
    context.pop(result);
  }

  /// Replace current route
  static void replaceTo(BuildContext context, String route, {Object? extra}) {
    context.pushReplacement(route, extra: extra);
  }

  /// Navigate to movie detail
  static void navigateToMovieDetail(BuildContext context, int movieId) {
    context.push('/movie-detail/$movieId');
  }

  /// Navigate to movies list
  static void navigateToMovies(BuildContext context) {
    context.go('/movies');
  }
}
