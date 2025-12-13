/**
 * Company: CETAM
 * Project: QParking
 * File: app_alerts.dart
 * Created on: 13/12/2025
 * Created by: Rodrigo Peña
 * Description: Standardized Dialogs and Snackbars based on UI Manual Section 7.4.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/theme/app_theme.dart';

// Enum to control the alert type internally
enum _AlertType { success, error, warning, info }

class AppAlerts {

  // ---------------------------------------------------------------------------
  // 7.4.1 SUCCESS ALERTS
  // Usage: Operations completed, successful save, email sent.
  // ---------------------------------------------------------------------------
  static void showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onOk,
  }) {
    _showDialog(
      context: context,
      type: _AlertType.success,
      title: title,
      message: message,
      onOk: onOk,
    );
  }

  // ---------------------------------------------------------------------------
  // 7.4.2 ERROR ALERTS (Danger)
  // Usage: Network failure, incorrect validation, payment rejected.
  // ---------------------------------------------------------------------------
  static void showError({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onOk,
  }) {
    _showDialog(
      context: context,
      type: _AlertType.error,
      title: title,
      message: message,
      onOk: onOk,
    );
  }

  // ---------------------------------------------------------------------------
  // 7.4.3 WARNING / INFO ALERTS
  // Usage: Delete confirmations, session notices, important info.
  // ---------------------------------------------------------------------------
  static void showWarning({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onOk,
    bool isDismissible = true,
  }) {
    _showDialog(
      context: context,
      type: _AlertType.warning,
      title: title,
      message: message,
      onOk: onOk,
      isDismissible: isDismissible,
    );
  }

  // PRIVATE METHOD: DIALOG GENERATOR
  // This builds the UI consistent across all alert types
  static void _showDialog({
    required BuildContext context,
    required _AlertType type,
    required String title,
    required String message,
    VoidCallback? onOk,
    bool isDismissible = true,
  }) {
    // Define colors and icons based on type
    Color mainColor;
    IconData iconData;
    String btnText;

    switch (type) {
      case _AlertType.success:
        mainColor = AppTheme.success;
        iconData = Icons.check_circle_outline;
        btnText = "Continue";
        break;
      case _AlertType.error:
        mainColor = AppTheme.danger; // Using the alias 'error' -> 'danger'
        iconData = Icons.error_outline;
        btnText = "Understood";
        break;
      case _AlertType.warning:
        mainColor = AppTheme.warning;
        iconData = Icons.warning_amber_rounded;
        btnText = "Accept";
        break;
      case _AlertType.info:
        mainColor = AppTheme.info;
        iconData = Icons.info_outline;
        btnText = "Accept";
        break;
    }

    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(16), // Standard border radius
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Adjusts height to content
              children: [
                // 1. Circular Icon Header
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.1), // Soft background color
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    iconData,
                    size: 36,
                    color: mainColor, // Strong main color
                  ),
                ),

                const SizedBox(height: 24),

                // 2. Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primary,
                  ),
                ),

                const SizedBox(height: 12),

                // 3. Message Body
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppTheme.gray600,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 32),

                // 4. Action Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor, // Button inherits alert color
                      foregroundColor: AppTheme.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      context.pop(); // Close the dialog
                      if (onOk != null) onOk(); // Execute extra action if provided
                    },
                    child: Text(
                      btnText,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // TOAST / SNACKBAR (Quick bottom notifications)
  // ---------------------------------------------------------------------------
  static void showToast({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.white),
        ),
        backgroundColor: isError ? AppTheme.danger : AppTheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}