import 'package:flutter/material.dart';

class MyAppTextTheme {
  static const String _fontFamilyTitle = 'times';
  static const String _fontFamilyBody = 'arial';
  static const String _fontFamilyLabel = 'courier';
  static const List<String> _fontFamilyFallBack = ['sofia', 'arial'];

  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamilyTitle,
    fontFamilyFallback: _fontFamilyFallBack,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamilyTitle,
    fontFamilyFallback: _fontFamilyFallBack,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamilyTitle,
    fontFamilyFallback: _fontFamilyFallBack,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamilyTitle,
    fontFamilyFallback: _fontFamilyFallBack,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamilyTitle,
    fontFamilyFallback: _fontFamilyFallBack,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    fontFamily: _fontFamilyBody,
    fontFamilyFallback: _fontFamilyFallBack,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontFamily: _fontFamilyBody,
    fontFamilyFallback: _fontFamilyFallBack,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontFamily: _fontFamilyBody,
    fontFamilyFallback: _fontFamilyFallBack,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 18,
    fontFamily: _fontFamilyLabel,
    fontFamilyFallback: _fontFamilyFallBack,
  );

  static TextTheme getTextTheme() {
    return const TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelMedium: labelMedium,
    );
  }
}
