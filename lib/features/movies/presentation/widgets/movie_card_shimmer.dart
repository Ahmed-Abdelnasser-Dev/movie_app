import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../core/styles/app_spacing.dart';

/// Shimmer loading placeholder for movie card
class MovieCardShimmer extends StatelessWidget {
  const MovieCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster shimmer
            Shimmer(
              color: highlightColor,
              colorOpacity: 0.3,
              child: Container(
                width: 80.w,
                height: 110.h,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                ),
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title shimmer
                  Shimmer(
                    color: highlightColor,
                    colorOpacity: 0.3,
                    child: Container(
                      height: 20.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: baseColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm),
                  // Rating shimmer
                  Shimmer(
                    color: highlightColor,
                    colorOpacity: 0.3,
                    child: Container(
                      height: 16.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: baseColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm),
                  // Overview line 1
                  Shimmer(
                    color: highlightColor,
                    colorOpacity: 0.3,
                    child: Container(
                      height: 14.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: baseColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  // Overview line 2
                  Shimmer(
                    color: highlightColor,
                    colorOpacity: 0.3,
                    child: Container(
                      height: 14.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: baseColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
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
