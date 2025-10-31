import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle get title => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get subtitle => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get body => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get caption => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get rating => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      );
}
