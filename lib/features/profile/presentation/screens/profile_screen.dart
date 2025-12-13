/**
 * Company: CETAM
 * Project: QParking
 * File: profile_screen.dart
 * Created on: 13/12/2025
 * Created by: Rodrigo Peña
 * Modified by: Rodrigo Peña
 * Approved by: Gamaliel Juarez
 *
 * Changelog:
 * - ID: 2 | Modified on: 13/12/2025 | Rodrigo Peña | Added 'Membership & User Type' section and dynamic initials logic.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/theme/app_theme.dart';
import 'package:qparking/core/widgets/app_icon.dart';
import 'package:qparking/core/icons/app_icons.dart';

const double _kStandardBorderRadius = 12.0;

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ---Simulated Data ---
    final String userName = "Daniel Mendoza";
    final String userEmail = "daniel.mendoza@cetam.mx";
    final String userType = "Usuario Especial"; // Dato dinámico
    final String currentPlan = "Plan Pro"; // Dato dinámico

    //Logic to get auto name
    final String userInitials = userName.trim().split(' ').length >= 2
        ? '${userName.trim().split(' ')[0][0]}${userName.trim().split(' ')[1][0]}'
        : userName.isNotEmpty ? userName[0] : "?";

    return Scaffold(
      backgroundColor: AppTheme.gray50,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTheme.white),
        title: const Text(
          'Mi Perfil',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // --- Header Card ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.gray200),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppTheme.primary.withOpacity(0.1),
                      child: Text(
                        userInitials, // Ahora usa la variable calculada
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userEmail,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.gray600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // --- Personal Information Section ---
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Información Personal',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.gray200),
                ),
                child: Column(
                  children: [
                    _ProfileListTile(
                      icon: AppIconName.user,
                      label: 'Nombre completo',
                      value: userName,
                    ),
                    const Divider(height: 1, color: AppTheme.gray200),
                    _ProfileListTile(
                      icon: AppIconName.email,
                      label: 'Correo electrónico',
                      value: userEmail,
                    ),
                    const Divider(height: 1, color: AppTheme.gray200),
                    const _ProfileListTile(
                      icon: AppIconName.phone,
                      label: 'Teléfono',
                      value: '+52 55 1234 5678',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // --- Type of Membership ---
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Membresía y Nivel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.gray200),
                ),
                child: Column(
                  children: [
                    _ProfileListTile(
                      icon: AppIconName.userTie, // Icono para tipo de usuario (userTie o shield)
                      label: 'Tipo de usuario',
                      value: userType, // Variable dinámica
                      valueColor: AppTheme.tertiary, // Resaltado visual (opcional)
                    ),
                    const Divider(height: 1, color: AppTheme.gray200),
                    _ProfileListTile(
                      icon: AppIconName.card, // Icono para plan
                      label: 'Plan actual',
                      value: currentPlan, // Variable dinámica
                      valueColor: AppTheme.success, // Verde para indicar activo
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // --- Logout Button ---
              SizedBox(
                height: 52,
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.gray300),
                    foregroundColor: AppTheme.gray600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_kStandardBorderRadius),
                    ),
                  ),
                  onPressed: () {
                    context.go('/login');
                  },
                  icon: const AppIcon(
                    name: AppIconName.logout,
                    size: 20,
                    color: AppTheme.gray600,
                  ),
                  label: const Text(
                    'Cerrar sesión',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget auxiliar
class _ProfileListTile extends StatelessWidget {
  final AppIconName icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _ProfileListTile({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.gray50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: AppIcon(name: icon, size: 20, color: AppTheme.primary),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.gray500,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          fontSize: 15,
          color: valueColor ?? AppTheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}