import 'package:flutter/material.dart';
import 'package:vizmo_app/utils/app_constants.dart';

class AppTheme {
  static ThemeData defaultTheme = ThemeData(
    useMaterial3: true,
    textTheme: textTheme,
    fontFamily: 'Roboto',
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple),
    iconTheme: IconThemeData(
      applyTextScaling: true,
      size: AppConstants.fontSize14,
    ),
  );

  static TextTheme textTheme = const TextTheme(
    titleSmall: TextStyle(
      fontSize: 18,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w800,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
    ),
    bodySmall: TextStyle(
      fontSize: 18,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      fontSize: 20,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w800,
    ),
    bodyLarge: TextStyle(
      fontSize: 22,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w800,
    ),
    displayLarge: TextStyle(
      fontSize: 22,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
    ),
  );
}
