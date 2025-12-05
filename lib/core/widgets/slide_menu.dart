/// Company: CETAM
/// Project: QParking
/// File: slide_menu.dart
/// Modified on: 05/12/2025
/// Description: Side menu with corrected navigation items and standardized icons.
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../themes/app_theme.dart';
import '../icons/app_icons.dart';
import 'app_icon.dart';

class SlideMenu extends StatelessWidget {
  const SlideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Connect with AuthProvider for real user data
    const String userName = "QParking Admin";
    const String userEmail = "admin@qparking.mx";

    return Drawer(
      backgroundColor: AppTheme.primary,
      surfaceTintColor: AppTheme.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // --- 1. User Header (Logo & Info) ---
            Container(
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: AppTheme.gray600,
                        // Main Logo from Assets
                        backgroundImage: AssetImage('assets/images/logo_qparking.png'),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              userName,
                              style: TextStyle(
                                color: AppTheme.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              userEmail,
                              style: TextStyle(
                                color: AppTheme.gray400,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Profile Button
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.pop();
                        context.push('/profile');
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.gray500),
                        foregroundColor: AppTheme.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      icon: const AppIcon(
                          name: AppIconName.userTie,
                          size: 16,
                          color: AppTheme.white
                      ),
                      label: const Text(
                        'Mi perfil', // Text can remain in Spanish for UI
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(color: AppTheme.gray700, height: 1),
            const SizedBox(height: 10),

            // Section Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'OPERACIÓN',
                  style: TextStyle(
                    color: AppTheme.gray500,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),

            // --- 2. Navigation Options ---
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _DrawerItem(
                    iconName: AppIconName.home,
                    label: 'Inicio',
                    isActive: true, // Logic to determine active state
                    onTap: () {
                      context.pop();
                      context.go('/home');
                    },
                  ),
                  _DrawerItem(
                    iconName: AppIconName.money,
                    label: 'Recargar Saldo',
                    onTap: () {
                      context.pop();
                      context.push('/add_credit');
                    },
                  ),
                  // FIX 1: Bank Card uses AppIconName.card (ICON), not ImagePath
                  _DrawerItem(
                    iconName: AppIconName.card,
                    label: 'Tarjeta',
                    onTap: () {
                      context.pop();
                      context.push('/bank_card');
                    },
                  ),
                  // FIX 2: Restored "Activity" item pointing to /activity
                  _DrawerItem(
                    iconName: AppIconName.list, // Using 'list' icon for activity table
                    label: 'Actividad',
                    onTap: () {
                      context.pop();
                      context.push('/activity');
                    },
                  ),
                ],
              ),
            ),

            // --- 3. Footer ---
            Padding(
              padding: const EdgeInsets.all(24),
              child: _DrawerItem(
                iconName: AppIconName.logout,
                label: 'Cerrar sesión',
                textColor: AppTheme.gray400,
                iconColor: AppTheme.gray400,
                onTap: () {
                  context.go('/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper Widget for Drawer Items
class _DrawerItem extends StatelessWidget {
  final AppIconName? iconName;
  final String? imagePath;
  final String label;
  final VoidCallback onTap;
  final bool isActive;
  final Color? textColor;
  final Color? iconColor;

  const _DrawerItem({
    super.key,
    this.iconName,
    this.imagePath,
    required this.label,
    required this.onTap,
    this.isActive = false,
    this.textColor,
    this.iconColor,
  }) : assert(iconName != null || imagePath != null, 'You must provide either iconName or imagePath');

  @override
  Widget build(BuildContext context) {
    final finalIconColor = iconColor ?? (isActive ? AppTheme.white : AppTheme.gray400);
    final finalTextColor = textColor ?? (isActive ? AppTheme.white : AppTheme.gray100);

    return ListTile(
      leading: _buildLeadingIcon(finalIconColor),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          color: finalTextColor,
        ),
      ),
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: isActive ? AppTheme.white.withOpacity(0.1) : null,
    );
  }

  Widget _buildLeadingIcon(Color color) {
    if (imagePath != null) {
      return Image.asset(
        imagePath!,
        width: 24, // Standard size
        height: 24,
        fit: BoxFit.contain,
      );
    }
    return AppIcon(
      name: iconName!,
      size: 20,
      color: color,
    );
  }
}