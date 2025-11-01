import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/styles/app_spacing.dart';

/// Widget that displays a movie poster with caching and placeholder
class MoviePoster extends StatelessWidget {
  final String? posterPath;
  final double width;
  final double height;

  const MoviePoster({
    super.key,
    required this.posterPath,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final posterUrl = posterPath != null
        ? '${ApiConstants.imageBaseUrl}w500$posterPath'
        : null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: posterUrl == null
            ? _buildPlaceholder(theme)
            : CachedNetworkImage(
                imageUrl: posterUrl,
                fit: BoxFit.cover,
                // Caching configuration
                memCacheWidth: (width * 2)
                    .toInt(), // Higher resolution for retina displays
                memCacheHeight: (height * 2).toInt(),
                maxWidthDiskCache: 1000,
                maxHeightDiskCache: 1500,
                // Shimmer placeholder while loading
                placeholder: (context, url) => _buildShimmerPlaceholder(theme),
                // Error widget if image fails to load
                errorWidget: (context, url, error) => _buildErrorWidget(theme),
                // Fade in animation
                fadeInDuration: const Duration(milliseconds: 300),
                fadeOutDuration: const Duration(milliseconds: 100),
              ),
      ),
    );
  }

  Widget _buildShimmerPlaceholder(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade700 : Colors.grey.shade100;

    return Shimmer(
      color: highlightColor,
      colorOpacity: 0.3,
      child: Container(
        color: baseColor,
        child: Center(
          child: Icon(
            Icons.image,
            color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
      child: Center(
        child: Icon(
          Icons.movie,
          color: isDark ? Colors.grey.shade600 : Colors.grey,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildErrorWidget(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
      child: Center(
        child: Icon(
          Icons.broken_image,
          color: isDark ? Colors.grey.shade600 : Colors.grey,
          size: 40,
        ),
      ),
    );
  }
}
