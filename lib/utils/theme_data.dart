import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sphere/utils/colors.dart';

class ThemeClass {
  static ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.dmSans().fontFamily,
    primaryColor: ThemeData.dark().primaryColor,
    scaffoldBackgroundColor: AppColors.kBgColor,
    colorScheme: ColorScheme.dark().copyWith(primary: AppColors.kWhiteColor),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kBgColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.kWhiteColor),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.kFabColor,
    ),
  );
}
