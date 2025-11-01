import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_spacing.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../domain/entities/movie.dart';
import 'movie_card.dart';
import 'load_more_button.dart';

/// List widget that displays movies with pagination support
class MoviesList extends StatelessWidget {
  final List<Movie> movies;
  final VoidCallback? onLoadMore;
  final bool isLoadingMore;
  final bool isOffline;
  final Future<void> Function()? onRefresh;

  const MoviesList({
    super.key,
    required this.movies,
    required this.onLoadMore,
    required this.isLoadingMore,
    this.isOffline = false,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        if (isOffline)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: AppSpacing.sm,
              horizontal: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.offlineGray.withValues(alpha: 0.3)
                  : AppColors.offlineGray,
              border: Border(
                bottom: BorderSide(
                  color:
                      isDark ? AppColors.dividerDark : AppColors.dividerLight,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_off_rounded,
                  color: Colors.white,
                  size: 16.sp,
                ),
                SizedBox(width: AppSpacing.sm),
                Text(
                  'Offline Mode - Showing cached data',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: onRefresh ?? () async {},
            color: theme.colorScheme.primary,
            backgroundColor: theme.colorScheme.surface,
            displacement: 32,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(AppSpacing.md),
              itemCount: movies.length + 1,
              separatorBuilder: (_, __) => SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                if (index == movies.length) {
                  if (onLoadMore == null) return const SizedBox.shrink();
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                      child: LoadMoreButton(
                        onPressed: onLoadMore,
                        isLoading: isLoadingMore,
                      ),
                    ),
                  );
                }
                final movie = movies[index];
                return MovieCard(movie: movie);
              },
            ),
          ),
        ),
      ],
    );
  }
}
