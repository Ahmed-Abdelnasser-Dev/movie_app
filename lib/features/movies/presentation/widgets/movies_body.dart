import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/styles/app_spacing.dart';
import '../bloc/movies_cubit.dart';
import 'movie_card_shimmer.dart';
import 'movies_list.dart';

/// Body widget that handles BLoC state changes for the movies screen
class MoviesBody extends StatelessWidget {
  const MoviesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => _buildShimmerLoading(),
          error: (msg) => Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ),
          success: (movies, page, hasMore, isLoadingMore, isOffline) =>
              MoviesList(
            movies: movies,
            onLoadMore:
                hasMore ? () => context.read<MoviesCubit>().loadMore() : null,
            isLoadingMore: isLoadingMore,
            isOffline: isOffline,
          ),
        );
      },
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.separated(
      padding: EdgeInsets.all(AppSpacing.md),
      itemCount: 5,
      separatorBuilder: (_, __) => SizedBox(height: AppSpacing.md),
      itemBuilder: (_, __) => const MovieCardShimmer(),
    );
  }
}
