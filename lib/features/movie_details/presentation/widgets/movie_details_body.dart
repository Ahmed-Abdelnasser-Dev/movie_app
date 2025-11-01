import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_spacing.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../domain/entities/movie_details.dart';
import 'movie_backdrop.dart';
import 'movie_info_section.dart';
import '../../../movies/presentation/widgets/movie_poster.dart';
import 'cast_section.dart';

class MovieDetailsBody extends StatelessWidget {
  final MovieDetails? movieDetails;
  final bool isOffline;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;

  const MovieDetailsBody({
    super.key,
    this.movieDetails,
    this.isOffline = false,
    this.isLoading = false,
    this.isError = false,
    this.errorMessage,
  });

  const MovieDetailsBody.loading({super.key})
      : movieDetails = null,
        isOffline = false,
        isLoading = true,
        isError = false,
        errorMessage = null;

  const MovieDetailsBody.error({
    super.key,
    required String message,
  })  : movieDetails = null,
        isOffline = false,
        isLoading = false,
        isError = true,
        errorMessage = message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (isError) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64.r,
                color: theme.colorScheme.error,
              ),
              SizedBox(height: AppSpacing.md),
              Text(
                errorMessage ?? 'An error occurred',
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (movieDetails == null) {
      return const SizedBox.shrink();
    }

    return CustomScrollView(
      slivers: [
        MovieBackdrop(
          backdropPath: movieDetails!.backdropPath,
          posterPath: movieDetails!.posterPath,
          title: movieDetails!.title,
          showBackdrop: false, // keep only the poster Hero below
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster with Hero animation
              if (movieDetails!.posterPath != null)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.md,
                  ),
                  child: Center(
                    child: MoviePoster(
                      posterPath: movieDetails!.posterPath,
                      width: 240.w,
                      height: 320.h,
                      heroTag: 'poster_${movieDetails!.id}',
                    ),
                  ),
                ),
              if (isOffline)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  color: AppColors.offlineGray.withValues(alpha: 0.1),
                  child: Row(
                    children: [
                      Icon(
                        Icons.cloud_off,
                        size: 16.r,
                        color: AppColors.offlineGray,
                      ),
                      SizedBox(width: AppSpacing.xs),
                      Text(
                        'Viewing cached data',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.offlineGray,
                        ),
                      ),
                    ],
                  ),
                ),
              MovieInfoSection(movieDetails: movieDetails!),
              SizedBox(height: AppSpacing.lg),
              if (movieDetails!.cast.isNotEmpty) ...[
                CastSection(cast: movieDetails!.cast),
                SizedBox(height: AppSpacing.lg),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
