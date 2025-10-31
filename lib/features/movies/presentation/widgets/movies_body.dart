import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movies_cubit.dart';
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
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (msg) => Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
          success: (movies, page, hasMore, isLoadingMore) => MoviesList(
            movies: movies,
            onLoadMore:
                hasMore ? () => context.read<MoviesCubit>().loadMore() : null,
            isLoadingMore: isLoadingMore,
          ),
        );
      },
    );
  }
}
