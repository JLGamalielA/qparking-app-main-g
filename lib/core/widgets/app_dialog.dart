/// Company: CETAM
/// Project: QParking
/// File: app_dialog.dart
/// Created on: 13/12/2025
/// Created by: Rodrigo Peña
/// Approved by: Gamaliel Juarez
///
/// Changelog:
/// - ID: 1 | Modified on: 13/12/2025 |
/// Modified by: Rodrigo Peña |
/// Description: Refactored to use Factory Constructors according to Manual V4.0 Section 7.4. |
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Imports Institucionales
import '../theme/app_theme.dart';
import '../icons/app_icons.dart';
import 'app_icon.dart';

/// Institutional Dialog Widget based on Material Design 3.
/// Implements standard alerts defined in Manual Section 7.4.
class AppDialog extends StatelessWidget {
  final String title;
  final String message;
  final AppIconName? icon;
  final Color? iconColor;
  final String? primaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;
  final bool isDestructive;

  const AppDialog({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.iconColor,
    this.primaryButtonText,
    this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
    this.isDestructive = false,
  });

  // ---------------------------------------------------------------------------
  // CONSTRUCTORES DE FÁBRICA (SEGÚN MANUAL SECCIÓN 7.4)
  // ---------------------------------------------------------------------------

  /// 1. Success Alert (Figura 41)
  /// Uso: Operaciones exitosas. Color: Verde.
  factory AppDialog.success({
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    return AppDialog(
      title: title,
      message: message,
      icon: AppIconName.success,
      iconColor: AppTheme.success,
      primaryButtonText: "Aceptar",
      onPrimaryPressed: onConfirm,
    );
  }

  /// 2. Danger/Error Alert (Figura 42)
  /// Uso: Errores críticos. Color: Rojo.
  factory AppDialog.danger({
    required String title,
    required String message,
    VoidCallback? onRetry,
  }) {
    return AppDialog(
      title: title,
      message: message,
      icon: AppIconName.error,
      iconColor: AppTheme.danger,
      primaryButtonText: "Cerrar", // o "Reintentar"
      onPrimaryPressed: onRetry,
      isDestructive: true,
    );
  }

  /// 3. Warning Alert (Figura 43)
  /// Uso: Precaución. Color: Ámbar.
  factory AppDialog.warning({
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    return AppDialog(
      title: title,
      message: message,
      icon: AppIconName.warning,
      iconColor: AppTheme.warning,
      primaryButtonText: "Revisar",
      onPrimaryPressed: onConfirm,
    );
  }

  /// 4. Info Alert (Figura 40)
  /// Uso: Información neutral. Color: Azul.
  factory AppDialog.info({
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    return AppDialog(
      title: title,
      message: message,
      icon: AppIconName.info,
      iconColor: AppTheme.info,
      primaryButtonText: "Entendido",
      onPrimaryPressed: onConfirm,
    );
  }

  /// 5. Question/Confirm Alert (Figura 44)
  /// Uso: Confirmar acciones destructivas.
  factory AppDialog.confirm({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    return AppDialog(
      title: title,
      message: message,
      icon: AppIconName.help,
      iconColor: AppTheme.primary,
      primaryButtonText: "Confirmar",
      onPrimaryPressed: onConfirm,
      secondaryButtonText: "Cancelar",
      onSecondaryPressed: onCancel,
      isDestructive: true, // Pone el botón primario en rojo según manual
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.white,
      surfaceTintColor: AppTheme.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      // Icono superior centrado
      icon: icon != null
          ? AppIcon(
        name: icon!,
        size: 48,
        color: iconColor ?? AppTheme.primary,
      )
          : null,

      // Título
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppTheme.primary,
        ),
      ),

      // Mensaje
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15,
          color: AppTheme.gray600,
          height: 1.5,
        ),
      ),

      // Botones de acción (Orden: Cancelar a la izq, Confirmar a la der)
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        if (secondaryButtonText != null)
          TextButton(
            onPressed: onSecondaryPressed ?? () => context.pop(),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.gray500,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: Text(secondaryButtonText!),
          ),

        if (primaryButtonText != null)
          ElevatedButton(
            onPressed: onPrimaryPressed ?? () => context.pop(),
            style: ElevatedButton.styleFrom(
              // Si es destructivo (Eliminar), el botón es Rojo (Manual Secc 7.5.1)
              backgroundColor: isDestructive ? AppTheme.danger : AppTheme.primary,
              foregroundColor: AppTheme.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(primaryButtonText!),
          ),
      ],
    );
  }
}