import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  // Headings
  static TextStyle get h1 => TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        height: 1.2,
      );

  static TextStyle get h2 => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        height: 1.3,
      );

  static TextStyle get h3 => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        height: 1.3,
      );

  // Body text
  static TextStyle get title => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  static TextStyle get subtitle => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  static TextStyle get body => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        height: 1.5,
      );

  static TextStyle get bodySmall => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        height: 1.5,
      );

  static TextStyle get caption => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade600,
        height: 1.3,
      );

  // Special text styles
  static TextStyle get rating => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.2,
      );

  static TextStyle get button => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        height: 1.2,
      );

  static TextStyle get chipText => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        height: 1.2,
      );
}
