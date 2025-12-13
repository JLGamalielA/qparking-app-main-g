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
 * - ID: 2 | Modified on: 13/12/2025 | Rodrigo Peña |
 * Added 'Membership & User Type' section and dynamic initials logic.
 * Translated all code comments to English.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/theme/app_theme.dart';
import 'package:qparking/core/widgets/app_icon.dart';
import 'package:qparking/core/icons/app_icons.dart';

// Standard border radius used across the application
const double _kStandardBorderRadius = 12.0;

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- Simulated Data (Future Backend Integration) ---
    final String userName = "Daniel Mendoza";
    final String userEmail = "daniel.mendoza@cetam.mx";
    final String userType = "Usuario Especial"; // Dynamic user level
    final String currentPlan = "Plan Pro"; // Dynamic subscription plan

    // Logic to automatically extract initials from the full name
    final String userInitials = userName.trim().split(' ').length >= 2
        ? '${userName.trim().split(' ')[0][0]}${userName.trim().split(' ')[1][0]}'
        : userName.isNotEmpty ? userName[0] : "?";

    return Scaffold(
      backgroundColor: AppTheme.gray50,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        elevation: 0,
        centerTitle: true,
        // Ensure navigation icons are white to match the dark theme
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
              // --- Profile Summary Header Card ---
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
                    // Main Avatar Circle
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppTheme.primary.withOpacity(0.1),
                      child: Text(
                        userInitials, // Display computed initials
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // User Display Name
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // User Email
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
                      value: '+52 55 1234 5678', // Placeholder data
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // --- Membership and Tier Section ---
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
                      icon: AppIconName.userTie, // Icon representing professional or special status
                      label: 'Tipo de usuario',
                      value: userType,
                      valueColor: AppTheme.tertiary, // Emphasis for special status
                    ),
                    const Divider(height: 1, color: AppTheme.gray200),
                    _ProfileListTile(
                      icon: AppIconName.card, // Icon representing subscription status
                      label: 'Plan actual',
                      value: currentPlan,
                      valueColor: AppTheme.success, // Success color for active plans
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // --- Session Management ---
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
                    // Logic to clear user session and redirect to Login
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

/// Helper widget to display profile items consistently
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