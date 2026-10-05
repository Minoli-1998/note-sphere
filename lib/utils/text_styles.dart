import 'package:flutter/material.dart';
import 'package:note_sphere/utils/colors.dart';

class AppTextStyles {
  // title styles
  static final TextStyle appTitle = TextStyle(
    fontSize: 28,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.bold,
  );

  // subtitle styles
  static final TextStyle appSubTitle = TextStyle(
    fontSize: 24,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.w500,
  );

  // description large style
  static final TextStyle appDescriptionLargeStyle = TextStyle(
    fontSize: 20,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.w400,
  );

  // description small style
  static final TextStyle appDescriptionSmallStyle = TextStyle(
    fontSize: 14,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.w400,
  );

  // app body styles
  static final TextStyle appBody = TextStyle(
    fontSize: 16,
    color: AppColors.kWhiteColor,
  );

  // app button styles
  static final TextStyle appButton = TextStyle(
    fontSize: 16,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.bold,
  );
}
