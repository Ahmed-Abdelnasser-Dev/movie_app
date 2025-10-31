import 'package:flutter/material.dart';
import '../../../../core/styles/app_spacing.dart';
import '../../domain/entities/movie.dart';
import 'movie_card.dart';
import 'load_more_button.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> movies;
  final VoidCallback? onLoadMore;
  final bool isLoadingMore;

  const MoviesList({
    super.key,
    required this.movies,
    required this.onLoadMore,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(AppSpacing.md),
      itemCount: movies.length + 1,
      separatorBuilder: (_, __) => SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        if (index == movies.length) {
          if (onLoadMore == null) return const SizedBox.shrink();
          return Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: LoadMoreButton(
              onPressed: onLoadMore,
              isLoading: isLoadingMore,
            ),
          );
        }
        final movie = movies[index];
        return MovieCard(movie: movie);
      },
    );
  }
}
