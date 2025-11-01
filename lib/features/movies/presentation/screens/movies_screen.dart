import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../bloc/movies_cubit.dart';
import '../widgets/movies_body.dart';

/// Main screen for displaying the list of movies
class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _wasOffline = false;
  bool _hasShownOfflineToast = false;

  @override
  void initState() {
    super.initState();
    _setupConnectivityListener();
  }

  void _setupConnectivityListener() {
    final connectivityService = getIt<ConnectivityService>();

    _connectivitySubscription =
        connectivityService.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) async {
        final isConnected = results.contains(ConnectivityResult.mobile) ||
            results.contains(ConnectivityResult.wifi) ||
            results.contains(ConnectivityResult.ethernet);

        if (isConnected && _wasOffline) {
          // Connection restored
          if (mounted) {
            AppToast.showBackOnline(context);
            // Refresh data when coming back online to update UI
            await Future.delayed(const Duration(milliseconds: 500));
            if (mounted) {
              context.read<MoviesCubit>().fetchInitial();
            }
          }
          _wasOffline = false;
          _hasShownOfflineToast = false;
        } else if (!isConnected && !_wasOffline) {
          // Connection lost
          if (mounted && !_hasShownOfflineToast) {
            AppToast.showOffline(context);
            _hasShownOfflineToast = true;
          }
          _wasOffline = true;
        }
      },
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MoviesCubit>()..fetchInitial(),
      child: BlocListener<MoviesCubit, MoviesState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (movies, page, hasMore, isLoadingMore, isOffline) {
              // Only show offline toast on initial load if we haven't shown it yet
              if (isOffline && page == 1 && !_hasShownOfflineToast) {
                _wasOffline = true;
                _hasShownOfflineToast = true;
                AppToast.showOffline(context);
              } else if (!isOffline && _wasOffline) {
                // State changed from offline to online through refresh
                _wasOffline = false;
                _hasShownOfflineToast = false;
              }
            },
            error: (message) {
              AppToast.showError(context, message);
            },
            orElse: () {},
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              '🎬 Top Rated Movies',
              style: AppTextStyles.h3,
            ),
            elevation: 2,
            centerTitle: false,
            actions: [
              Builder(
                builder: (context) {
                  final theme = Theme.of(context);
                  final isDark = theme.brightness == Brightness.dark;
                  return IconButton(
                    tooltip:
                        isDark ? 'Switch to light mode' : 'Switch to dark mode',
                    onPressed: () => context.read<ThemeCubit>().toggle(),
                    icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                  );
                },
              ),
            ],
          ),
          body: const MoviesBody(),
        ),
      ),
    );
  }
}
