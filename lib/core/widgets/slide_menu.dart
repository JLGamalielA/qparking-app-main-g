/// Company: CETAM
/// Project: QParking
/// File: slide_menu.dart
/// Created on: 15/11/2025
/// Created by: Daniel Mendoza
/// Approved by: Daniel Mendoza
///
/// Changelog:
/// - ID: 1 | Modified on: 25/11/2025 |
/// Modified by: Gamaliel Alejandro Juarez Lodye |
/// Description: Implementation of Drawer/Navigation Rail |
///
///  * Changelog:
/// - ID: 2 | Modified on: 27/11/2025 |
/// Modified by: Gamaliel Alejandro Juarez Lodye |
/// Description: Replaced profile icon with profile image |
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../themes/app_theme.dart';

class SlideMenu extends StatelessWidget {
  const SlideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Visual Style
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
            // --- User Header ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: AppTheme.gray600,
                    backgroundImage: AssetImage('assets/images/logo_qparking.png'),
                  ),
                  const SizedBox(height: 16),

                  // "My Profile" button
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
                      icon: const Icon(Icons.badge_outlined, size: 18),
                      label: const Text(
                        'Mi perfil',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Operación',
                  style: TextStyle(
                    color: AppTheme.gray500,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),

            // --- Navigation Options ---
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _DrawerItem(
                    icon: Icons.home_outlined,
                    label: 'Inicio',
                    onTap: () {
                      context.pop();
                      context.go('/home');
                    },
                    isActive: true,
                  ),
                  _DrawerItem(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Recargar Saldo',
                    onTap: () {
                      context.pop();
                      context.push('/add_credit');
                    },
                  ),
                  // 2. Elemento nuevo (Actividad) - Lo agregamos justo debajo
                  _DrawerItem(
                    icon: Icons.history, // Usamos un icono de reloj/historial más apropiado
                    label: 'Actividad',
                    onTap: () {
                      context.pop(); // Cierra el menú lateral
                      context.push('/activity'); // Navega a la nueva pantalla de actividad
                    },
                  ),
                  /*_DrawerItem(
                    icon: Icons.bar_chart,
                    label: 'Historial',
                    onTap: () {
                      context.pop();
                      context.push('/statistics');
                    },
                  ),
                   */
                ],
              ),
            ),

            // --- Footer / Sign Out ---
            Padding(
              padding: const EdgeInsets.all(24),
              child: _DrawerItem(
                icon: Icons.exit_to_app,
                label: 'Cerrar sesión',
                onTap: () {
                  context.go('/login');
                },
                textColor: AppTheme.gray400,
                iconColor: AppTheme.gray400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// dark menu items
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;
  final Color? textColor;
  final Color? iconColor;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? (isActive ? AppTheme.white : AppTheme.gray400),
        size: 24,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          color: textColor ?? (isActive ? AppTheme.white : AppTheme.gray100),
        ),
      ),
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: isActive ? AppTheme.white.withOpacity(0.1) : null,
    );
  }
}