/// Company: CETAM
/// Project: QParking
/// File: app_theme.dart
/// Created on: 27/11/2025
/// Created by: Daniel Mendoza
/// Approved by: Daniel Mendoza
///
/// Changelog:
/// - ID: 1 | Modified on: 25/11/2025 |
/// Modified by: Gamaliel Alejandro Juarez Loyde |
/// Description: Implementation of colors and styles |
library;
import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkMode;

  AppTheme({this.isDarkMode = false});

  // --- Colors ---
  static const Color primary = Color(0xFF1F2937);
  static const Color secondary = Color(0xFFFB503B);
  static const Color tertiary = Color(0xFF31316A);
  static const Color success = Color(0xFF10B981);
  static const Color info = Color(0xFF2361CE);
  static const Color warning = Color(0xFFF3C78E);
  static const Color danger = Color(0xFFE11D48);
  static const Color indigo = Color(0xFF4F46E5);
  static const Color Purple = Color(0xFF7C3AED);
  static const Color red100 = Color(0xFFFBBAB5);
  static const Color red200 = Color(0xFFFBAEA7);

  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF8F9FA);
  static const Color gray100 = Color(0xFFF1F3F5);
  static const Color gray200 = Color(0xFFE9ECEF);
  static const Color gray300 = Color(0xFFDEE2E6);
  static const Color gray400 = Color(0xFFCED4DA);
  static const Color gray500 = Color(0xFFADB5BD);
  static const Color gray600 = Color(0xFF6C757D);
  static const Color gray700 = Color(0xFF495057);
  static const Color gray800 = Color(0xFF343A40);
  static const Color gray900 = Color(0xFF212529);

  ThemeData getTheme() {
    return ThemeData(
        useMaterial3: true,
        colorSchemeSeed: primary,
        scaffoldBackgroundColor: gray50,
        fontFamily: 'Roboto',

      // --- texts ---
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: primary,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: gray600,
            height: 1.5,
          ),
        ),

      // --- Text Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        labelStyle: const TextStyle(color: gray500, fontSize: 14),
        hintStyle: const TextStyle(color: gray400),
        prefixIconColor: primary,
        suffixIconColor: gray500,

        // Borders
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: gray300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: info, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: danger, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: danger, width: 1.5),
        ),
      ),

      // --- Buttons ---
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: white,
          elevation: 0,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
          ),
        ),
      ),

      // Text buttons
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
