import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/app_colors.dart';
import '../styles/app_spacing.dart';
import '../styles/app_text_styles.dart';

/// Toast/Snackbar utility for showing feedback messages
class AppToast {
  /// Show success message
  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: AppColors.successGreen,
      icon: Icons.check_circle_rounded,
    );
  }

  /// Show error message
  static void showError(BuildContext context, String message) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: AppColors.errorRed,
      icon: Icons.error_rounded,
    );
  }

  /// Show info message
  static void showInfo(BuildContext context, String message) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: AppColors.infoBlue,
      icon: Icons.info_rounded,
    );
  }

  /// Show warning message
  static void showWarning(BuildContext context, String message) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: AppColors.warningOrange,
      icon: Icons.warning_rounded,
    );
  }

  /// Show offline mode message
  static void showOffline(BuildContext context) {
    _showSnackBar(
      context,
      message: 'You are offline. Showing cached data.',
      backgroundColor: AppColors.offlineGray,
      icon: Icons.cloud_off_rounded,
      duration: const Duration(seconds: 4),
    );
  }

  /// Show back online message
  static void showBackOnline(BuildContext context) {
    _showSnackBar(
      context,
      message: 'Connection restored!',
      backgroundColor: AppColors.onlineGreen,
      icon: Icons.cloud_done_rounded,
      duration: const Duration(seconds: 2),
    );
  }

  static void _showSnackBar(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required IconData icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20.sp),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.body.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(AppSpacing.md),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
        ),
        elevation: 4,
      ),
    );
  }
}
