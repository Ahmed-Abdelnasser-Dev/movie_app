import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 18),
        SizedBox(width: 6.w),
        Text(
          '${rating?.toStringAsFixed(1) ?? '--'}/10',
          style: AppTextStyles.subtitle,
        ),
      ],
    );
  }
}
