import 'package:flutter/material.dart';

import '../appColors/app_colors.dart';

class AppShadows {
  static List<BoxShadow> customSoftShadow = [
    BoxShadow(
      color: AppColors.shadowColor.withOpacity(0.02),
      spreadRadius: 0,
      blurRadius: 5,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: AppColors.shadowColor.withOpacity(0.02),
      spreadRadius: 0,
      blurRadius: 10,
      offset: Offset(-1, 10),
    ),
    BoxShadow(
      color: AppColors.shadowColor.withOpacity(0.01),
      spreadRadius: 0,
      blurRadius: 13,
      offset: Offset(-13, 22),
    ),
    BoxShadow(
      color: AppColors.shadowColor,
      spreadRadius: 0,
      blurRadius: 16,
      offset: Offset(-5, 39),
    ),
    BoxShadow(
      color: AppColors.shadowColor,
      spreadRadius: 0,
      blurRadius: 17,
      offset: Offset(-8, 61),
    ),
  ];
}