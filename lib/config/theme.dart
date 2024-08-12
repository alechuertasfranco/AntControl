import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF607D8B);

  // Primary Colors
  static const Color primary050 = Color(0xFFE2E8E9);
  static const Color primary100 = Color(0xFFC5D0D1);
  static const Color primary200 = Color(0xFFA8B7B8);
  static const Color primary300 = Color(0xFF8A9D9D);
  static const Color primary400 = Color(0xFF6C8C8C);
  static const Color primary500 = Color(0xFF4E7B7B);
  static const Color primary600 = Color(0xFF4A7373);
  static const Color primary700 = Color(0xFF436B6B);
  static const Color primary800 = Color(0xFF3B6161);
  static const Color primary900 = Color(0xFF314C4C);

  // Secondary Colors
  static const Color secondary050 = Color(0xFFC7C8D1);
  static const Color secondary100 = Color(0xFFB1B2B9);
  static const Color secondary200 = Color(0xFF9B9CA0);
  static const Color secondary300 = Color(0xFF86868B);
  static const Color secondary400 = Color(0xFF6D6F7B);
  static const Color secondary500 = Color(0xFF555D6B);
  static const Color secondary600 = Color(0xFF434A58);
  static const Color secondary700 = Color(0xFF3C4152);
  static const Color secondary800 = Color(0xFF333746);
  static const Color secondary900 = Color(0xFF2A2D39);

  // Complementary Colors 01
  static const Color complementary01_050 = Color(0xFFE3E8F0);
  static const Color complementary01_100 = Color(0xFFC5D0F1);
  static const Color complementary01_200 = Color(0xFFA7B8F2);
  static const Color complementary01_300 = Color(0xFF8AA0F3);
  static const Color complementary01_400 = Color(0xFF6D8BF0);
  static const Color complementary01_500 = Color(0xFF5673D0);
  static const Color complementary01_600 = Color(0xFF4A65B2);
  static const Color complementary01_700 = Color(0xFF3D5494);
  static const Color complementary01_800 = Color(0xFF2F4475);
  static const Color complementary01_900 = Color(0xFF1F3556);

  // Complementary Colors 02
  static const Color complementary02_050 = Color(0xFFF6F7F9);
  static const Color complementary02_100 = Color(0xFFE3E4E8);
  static const Color complementary02_200 = Color(0xFFD0D2D6);
  static const Color complementary02_300 = Color(0xFFB3B4C4);
  static const Color complementary02_400 = Color(0xFF9E9FAF);
  static const Color complementary02_500 = Color(0xFF8A8C9A);
  static const Color complementary02_600 = Color(0xFF8A8C9A);
  static const Color complementary02_700 = Color(0xFF6E6F7F);
  static const Color complementary02_800 = Color(0xFF5C5E6A);
  static const Color complementary02_900 = Color(0xFF4B4D57);

  // Complementary Colors 03
  static const Color complementary03_050 = Color(0xFFE9E2FF);
  static const Color complementary03_100 = Color(0xFFD2AFFF);
  static const Color complementary03_200 = Color(0xFFB79DFF);
  static const Color complementary03_300 = Color(0xFF9C8CFF);
  static const Color complementary03_400 = Color(0xFF8264FF);
  static const Color complementary03_500 = Color(0xFF5F3CFF);
  static const Color complementary03_600 = Color(0xFF5F3CFF);
  static const Color complementary03_700 = Color(0xFF4E2DFF);
  static const Color complementary03_800 = Color(0xFF3D1FEC);
  static const Color complementary03_900 = Color(0xFF2D0FB5);

  // State Colors
  static const Color errorLight = Color(0xFFFCE4E4);
  static const Color error = Color(0xFFE30425);
  static const Color successLight = Color(0xFFEAF9E6);
  static const Color success = Color(0xFF4CAF50);
  static const Color successDark = Color(0xFF388E3C);
  static const Color attentionLight = Color(0xFFE9F2FF);
  static const Color attention = Color(0xFF1976D2);
  static const Color alertLight = Color(0xFFFFF7E4);
  static const Color alert = Color(0xFFFBC02D);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color text = Color(0xFF202E44);
}

final ThemeData appTheme = ThemeData(
  appBarTheme: appBarTheme,
  textTheme: textTheme,
);

final TextTheme textTheme = TextTheme(
  displayLarge: GoogleFonts.ebGaramond(fontSize: 34.0, fontWeight: FontWeight.bold, color: AppColors.text),
  displayMedium: GoogleFonts.ebGaramond(fontSize: 24.0, fontWeight: FontWeight.bold, color: AppColors.text),
  displaySmall: GoogleFonts.ebGaramond(fontSize: 20.0, fontWeight: FontWeight.bold, color: AppColors.text),
  headlineLarge: GoogleFonts.ebGaramond(fontSize: 24.0, fontWeight: FontWeight.w500, color: AppColors.text),
  headlineMedium: GoogleFonts.ebGaramond(fontSize: 20.0, fontWeight: FontWeight.w500, color: AppColors.text),
  headlineSmall: GoogleFonts.ebGaramond(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppColors.text),
  titleLarge: GoogleFonts.ebGaramond(fontSize: 24.0, color: AppColors.text),
  titleMedium: GoogleFonts.ebGaramond(fontSize: 20.0, color: AppColors.text),
  titleSmall: GoogleFonts.ebGaramond(fontSize: 16.0, color: AppColors.text),
  bodyLarge: GoogleFonts.montserrat(fontSize: 20.0, color: AppColors.text),
  bodyMedium: GoogleFonts.montserrat(fontSize: 16.0, color: AppColors.text),
  bodySmall: GoogleFonts.montserrat(fontSize: 14.0, color: AppColors.text),
  labelLarge: GoogleFonts.montserrat(fontSize: 16.0, fontWeight: FontWeight.w600, color: AppColors.text),
  labelMedium: GoogleFonts.montserrat(fontSize: 14.0, fontWeight: FontWeight.w600, color: AppColors.text),
  labelSmall: GoogleFonts.montserrat(fontSize: 12.0, fontWeight: FontWeight.w600, color: AppColors.text),
);

const AppBarTheme appBarTheme = AppBarTheme(backgroundColor: AppColors.primary700);
