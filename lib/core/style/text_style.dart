import 'package:cars/core/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle headLine() => TextStyle(
        fontSize: 23.0.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.textColor,
      );

  static TextStyle appBarText() => TextStyle(
        color: AppColors.textColor,
        fontSize: 20.0.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle bodyText() => TextStyle(
        fontSize: 16.0.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondaryColor,
      );
  static TextStyle subTitle() => TextStyle(
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.textSecondaryColor,
        height: 1.3.h,
      );
  static TextStyle caption() => TextStyle(
        fontSize: 13.0.sp,
        color: AppColors.textSecondaryColor,
      );
}
