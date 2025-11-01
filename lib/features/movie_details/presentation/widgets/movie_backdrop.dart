import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/styles/app_text_styles.dart';

class MovieBackdrop extends StatelessWidget {
  final String? backdropPath;
  final String? posterPath;
  final String title;

  const MovieBackdrop({
    super.key,
    this.backdropPath,
    this.posterPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      expandedHeight: 300.h,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          title,
          style: AppTextStyles.h3.copyWith(
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.7),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (backdropPath != null)
              CachedNetworkImage(
                imageUrl: '${ApiConstants.imageBaseUrl}w780$backdropPath',
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: theme.colorScheme.surface,
                ),
                errorWidget: (context, url, error) => Container(
                  color: theme.colorScheme.surface,
                  child: const Icon(Icons.movie),
                ),
              )
            else
              Container(
                color: theme.colorScheme.surface,
                child: const Icon(Icons.movie, size: 80),
              ),
            // Gradient overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
