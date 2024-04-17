import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

const String fontFamilyInter = "Inter";

class AppTextStyles {
  static const headlineLarge = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    fontFamily: fontFamilyInter,
    color: Colors.black,
  );
  static const headlineMedium = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    fontFamily: fontFamilyInter,
    color: Colors.black,
  );
  static const headlineSmall = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    fontFamily: fontFamilyInter,
    color: Colors.black,
  );

  static const title = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    fontFamily: fontFamilyInter,
    color: AppColors.titleColor,
  );
  static const bodySemiBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    fontFamily: fontFamilyInter,
    color: Colors.black,
  );
  static const titleSmall = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    fontFamily: fontFamilyInter,
    color: Colors.black,
  );
  static const bodyLarge = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 18,
    fontFamily: fontFamilyInter,
    color: Colors.black,
  );
  static const bodyMedium = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    fontFamily: fontFamilyInter,
    color: AppColors.boxColor,
  );
  static const bodySmall = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    fontFamily: fontFamilyInter,
    color: AppColors.blackColor,
  );
  static const drawerTitle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    fontFamily: fontFamilyInter,
    color: AppColors.whiteColor,
  );
  static const primaryColorText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    fontFamily: fontFamilyInter,
    color: AppColors.primaryColor,
  );
}