import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color secondary = Color(0xFF06B6D4);
  static const Color accent = Color(0xFF8B5CF6);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color pinkOne = Color(0xFFFC5672);
  static const Color pinkTwo = Color(0xFFFF4460);
  static const Color neutral50 = Color(0xFFF8FAFC);
  static const Color neutral100 = Color(0xFFF1F5F9);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral900 = Color(0xFF0F172A);
  static const Color whiteOne = Color(0xFFFFFFFF);
  static const Color whiteTwo = Color(0xFFFAFAFA);
  static const Color greyOne = Color(0xFFD0D0D0);
  static const Color greyTwo = Color(0xFFA7A2A3);
  static const Color greyThree = Color(0xFF42343C);
  static const Color blackOne = Color(0xFF000000);
  static const Color blackTwo = Color(0xFF40393A);
  static const Color blackThree = Color(0xFF13000A);
  static const Color transparent = Colors.transparent;
  static const Color redOne = Colors.red;
}

class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.neutral900,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.neutral900,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.neutral700,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.neutral700,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.neutral500,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.neutral500,
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.neutral50,
      ),
      scaffoldBackgroundColor: AppColors.whiteOne,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.whiteOne,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.neutral900),
        titleTextStyle: TextStyle(
          color: AppColors.neutral900,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}