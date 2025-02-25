import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourguard/core/theme/app_colors.dart';


class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.whiteColor,
    primaryColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      onPrimary: AppColors.whiteColor,
      error: AppColors.errorColor,
      onError: AppColors.whiteColor,
      surface: AppColors.whiteColor,
      onSurface: AppColors.blackColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.transparentColor,
      elevation: 0,
    ),
    textTheme: GoogleFonts.montserratTextTheme(const TextTheme()),
  );
}
