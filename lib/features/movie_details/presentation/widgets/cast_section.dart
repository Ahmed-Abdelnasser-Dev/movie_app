import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/styles/app_spacing.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../domain/entities/cast_member.dart';

class CastSection extends StatelessWidget {
  final List<CastMember> cast;

  const CastSection({
    super.key,
    required this.cast,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'Cast',
            style: AppTextStyles.h3.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 180.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: cast.length,
            itemBuilder: (context, index) {
              final member = cast[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index < cast.length - 1 ? AppSpacing.sm : 0,
                ),
                child: CastCard(castMember: member),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CastCard extends StatelessWidget {
  final CastMember castMember;

  const CastCard({
    super.key,
    required this.castMember,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 100.w,
      child: Column(
        children: [
          // Profile image
          Container(
            width: 100.w,
            height: 120.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              color: theme.colorScheme.surfaceContainerHighest,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              child: castMember.profilePath != null
                  ? CachedNetworkImage(
                      imageUrl:
                          '${ApiConstants.imageBaseUrl}w185${castMember.profilePath}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.person,
                          size: 40.r,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.3),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.person,
                          size: 40.r,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.3),
                        ),
                      ),
                    )
                  : Icon(
                      Icons.person,
                      size: 40.r,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          // Name
          Text(
            castMember.name,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          // Character
          Text(
            castMember.character,
            style: AppTextStyles.caption.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
