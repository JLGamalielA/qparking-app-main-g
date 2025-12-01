/**
 * Company: CETAM
 * Project: QParking
 * File: app_dialog.dart
 * Created on: 27/11/2025
 * Created by: Daniel Mendoza
 * Approved by: Daniel Mendoza
 *
 * Changelog:
 * - ID: 1 | Modified on: 27/11/2025 |
 * Modified by: Gamaliel Alejandro Juarez Loyde |
 * Description: Generic Dialog component implementation  |
 * - ID: 2 | Modified on: 30/11/2025 |
 * Modified by: Carlos Adair Bautista Godinez |
 * Description: Standarization of icons |
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/icons/app_icons.dart';
import 'package:qparking/core/widgets/app_icon.dart';
import '../themes/app_theme.dart';

enum DialogType { warning, info, success, error, question }

class AppDialog extends StatelessWidget {
  final DialogType type;
  final String title;
  final String description;
  final String primaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;

  const AppDialog({
    super.key,
    required this.type,
    required this.title,
    required this.description,
    this.primaryButtonText = 'Aceptar',
    this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor;
    Color iconBgColor;
    AppIconName iconName;
    String defaultBtnText;
    Color primaryBtnColor;


    // Mapping types
    switch (type) {
      case DialogType.warning:
        iconColor = AppTheme.warning;
        iconBgColor = AppTheme.warning.withOpacity(0.1);
        iconName = AppIconName.warning;
        defaultBtnText = 'Revisar';
        primaryBtnColor = AppTheme.primary;
        break;
      case DialogType.info:
        iconColor = AppTheme.info;
        iconBgColor = AppTheme.info.withOpacity(0.1);
        iconName = AppIconName.info;
        defaultBtnText = 'Entendido';
        primaryBtnColor = AppTheme.primary;
        break;
      case DialogType.success:
        iconColor = AppTheme.success;
        iconBgColor = AppTheme.success.withOpacity(0.1);
        iconName = AppIconName.success;
        defaultBtnText = 'Aceptar';
        primaryBtnColor = AppTheme.primary;
        break;
      case DialogType.error:
        iconColor = AppTheme.danger;
        iconBgColor = AppTheme.danger.withOpacity(0.1);
        iconName = AppIconName.error;
        defaultBtnText = 'Cerrar';
        primaryBtnColor = AppTheme.danger;
        break;
      case DialogType.question:
        iconColor = AppTheme.primary;
        iconBgColor = AppTheme.primary.withOpacity(0.1);
        iconName = AppIconName.help;
        defaultBtnText = 'Continuar';
        primaryBtnColor = AppTheme.primary;
        break;
    }

    final btnText = primaryButtonText == 'Aceptar' ? defaultBtnText : primaryButtonText;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: AppIcon(name: iconName, color: iconColor, size: 28),
            ),
            const SizedBox(height: 24),

            // Title
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

            // Description / Microcopy
            Text(
              description,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 15,
                color: AppTheme.gray600,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                // Secondary Button
                if (secondaryButtonText != null) ...[
                  Expanded(
                    child: TextButton(
                      onPressed: onSecondaryPressed ?? () => context.pop(),
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.gray600,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      child: Text(secondaryButtonText!),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],

                // Primary Button (Action)
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPrimaryPressed ?? () => context.pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBtnColor,
                      foregroundColor: AppTheme.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    child: Text(btnText),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static void show(
      BuildContext context, {
        required DialogType type,
        required String title,
        required String description,
        String? primaryText,
        VoidCallback? onPrimary,
        String? secondaryText,
        VoidCallback? onSecondary,
      }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AppDialog(
        type: type,
        title: title,
        description: description,
        primaryButtonText: primaryText ?? 'Aceptar',
        onPrimaryPressed: onPrimary,
        secondaryButtonText: secondaryText,
        onSecondaryPressed: onSecondary,
      ),
    );
  }
}