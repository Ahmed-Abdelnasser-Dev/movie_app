import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_spacing.dart';
import '../../../../core/styles/app_text_styles.dart';

/// Widget that displays a movie rating with star icon
class MovieRating extends StatelessWidget {
  final double? rating;

  const MovieRating({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star_rounded,
          color: AppColors.starYellow,
          size: 18.sp,
        ),
        SizedBox(width: AppSpacing.xs),
        Text(
          '${rating?.toStringAsFixed(1) ?? '--'}/10',
          style: AppTextStyles.rating.copyWith(
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }
}
