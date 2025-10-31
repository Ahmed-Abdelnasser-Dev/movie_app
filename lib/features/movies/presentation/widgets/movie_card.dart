import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/app_spacing.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../domain/entities/movie.dart';
import 'movie_poster.dart';
import 'movie_rating.dart';

/// Card widget that displays movie information (poster, title, rating, overview)
class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MoviePoster(
              posterPath: movie.posterPath,
              width: 80.w,
              height: 110.h,
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: AppTextStyles.title),
                  SizedBox(height: AppSpacing.sm),
                  MovieRating(rating: movie.voteAverage),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    movie.overview ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
