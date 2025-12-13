/// Company: CETAM
/// Project: QParking
/// File: app_theme.dart
/// Created on: 13/12/2025
/// Created by: Rodrigo Peña
/// Approved by: Gamaliel Juarez
///
/// Changelog:
/// - ID: 3 | Modified on: 13/12/2025 | Rodrigo Peña | Added 'error' alias pointing to 'danger' for semantic compatibility.
library;

import 'package:flutter/material.dart';

class AppTheme {
  // ---------------------------------------------------------------------------
  // INSTITUTIONAL COLOR PALETTE
  // ---------------------------------------------------------------------------

  static const Color primary = Color(0xFF1F2937);
  static const Color secondary = Color(0xFFFB503B);
  static const Color tertiary = Color(0xFF31316A);


  static const Color indigo = Color(0xFF4F46E5);

  // --- Neutrals ---
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray900 = Color(0xFF111827);

  // --- Semantic States ---
  static const Color success = Color(0xFF10B981);
  static const Color danger = Color(0xFFE11D48);
  static const Color warning = Color(0xFFFBA918);
  static const Color info = Color(0xFF1E90FF);
  static const Color error = danger;

  // ---------------------------------------------------------------------------
  // GLOBAL THEME CONFIGURATION
  // ---------------------------------------------------------------------------

  final bool isDarkMode;

  AppTheme({this.isDarkMode = false});

  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: primary,
      scaffoldBackgroundColor: gray50,
      fontFamily: 'Roboto',

      // --- Text Theme ---
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

      // --- Input Decoration ---
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        labelStyle: const TextStyle(color: gray500, fontSize: 14),
        hintStyle: const TextStyle(color: gray400),
        prefixIconColor: primary,
        suffixIconColor: gray500,
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

      // --- Elevated Button ---
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
    );
  }
}