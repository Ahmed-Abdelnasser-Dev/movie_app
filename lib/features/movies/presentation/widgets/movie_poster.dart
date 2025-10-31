import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    final posterUrl = posterPath != null
        ? '${ApiConstants.imageBaseUrl}w500$posterPath'
        : null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: posterUrl == null
            ? _buildPlaceholder()
            : CachedNetworkImage(
                imageUrl: posterUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildPlaceholder(),
                errorWidget: (context, url, error) => _buildErrorWidget(),
              ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey.shade300,
      child: const Center(
        child: Icon(Icons.movie, color: Colors.grey, size: 40),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(Icons.broken_image, color: Colors.grey, size: 40),
      ),
    );
  }
}
