import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_spacing.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../domain/entities/movie_details.dart';

class MovieInfoSection extends StatelessWidget {
  final MovieDetails movieDetails;

  const MovieInfoSection({
    super.key,
    required this.movieDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            movieDetails.title,
            style: AppTextStyles.h2.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: AppSpacing.sm),

          // Tagline
          if (movieDetails.tagline?.isNotEmpty == true) ...[
            Text(
              movieDetails.tagline!,
              style: AppTextStyles.subtitle.copyWith(
                fontStyle: FontStyle.italic,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: AppSpacing.md),
          ],

          // Rating, Runtime, Release Date
          Row(
            children: [
              if (movieDetails.voteAverage != null) ...[
                Icon(
                  Icons.star,
                  color: AppColors.starYellow,
                  size: 20.r,
                ),
                SizedBox(width: 4.w),
                Text(
                  movieDetails.voteAverage!.toStringAsFixed(1),
                  style: AppTextStyles.rating.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
              ],
              if (movieDetails.runtime != null) ...[
                Icon(
                  Icons.access_time,
                  size: 18.r,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                SizedBox(width: 4.w),
                Text(
                  '${movieDetails.runtime} min',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
              ],
              if (movieDetails.releaseDate != null) ...[
                Icon(
                  Icons.calendar_today,
                  size: 16.r,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                SizedBox(width: 4.w),
                Text(
                  movieDetails.releaseDate!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: AppSpacing.md),

          // Genres
          if (movieDetails.genres.isNotEmpty) ...[
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: movieDetails.genres.map((genre) {
                return Chip(
                  label: Text(
                    genre.name,
                    style: AppTextStyles.chipText.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  backgroundColor: theme.colorScheme.primaryContainer,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: 0,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: AppSpacing.md),
          ],

          // Overview
          if (movieDetails.overview?.isNotEmpty == true) ...[
            Text(
              'Overview',
              style: AppTextStyles.h3.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              movieDetails.overview!,
              style: AppTextStyles.body.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
                height: 1.6,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
