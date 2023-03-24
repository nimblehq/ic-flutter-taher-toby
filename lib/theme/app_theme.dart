import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/fonts.gen.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';

class AppTheme {
  static ThemeData light() => ThemeData(
        scaffoldBackgroundColor: Colors.grey,
        colorScheme: const ColorScheme.light(
          primary: AppColors.blackRussian,
        ),
        fontFamily: FontFamily.neuzeit,
        textTheme: const TextTheme(
          titleSmall: TextStyle(
            /** xSmall / Tag All Caps */
            color: Colors.white,
            fontSize: AppDimensions.textSize13,
            fontWeight: FontWeight.w800,
          ),
          headlineSmall: TextStyle(
            /** Small / Tag All Caps */
            color: Colors.white,
            fontSize: AppDimensions.textSize15,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            /** Regular / Paragraph */
            color: Colors.white,
            fontSize: AppDimensions.textSize17,
            fontWeight: FontWeight.w400,
          ),
          labelSmall: TextStyle(
            /** Regular / Semi Bold */
            color: Colors.white,
            fontSize: AppDimensions.textSize17,
            fontWeight: FontWeight.w800,
          ),
          bodyMedium: TextStyle(
            /** Medium / Link */
            color: Colors.white,
            fontSize: AppDimensions.textSize17,
            fontWeight: FontWeight.w400,
          ),
          labelMedium: TextStyle(
            /** Medium / Bold */
            color: Colors.white,
            fontSize: AppDimensions.textSize20,
            fontWeight: FontWeight.w800,
          ),
          displayLarge: TextStyle(
            /** Display / 2 */
            color: Colors.white,
            fontSize: AppDimensions.textSize28,
            fontWeight: FontWeight.w400,
          ),
          titleLarge: TextStyle(
            /** Large Title */
            color: Colors.white,
            fontSize: AppDimensions.textSize34,
            fontWeight: FontWeight.w800,
          ),
        ),
      );
}