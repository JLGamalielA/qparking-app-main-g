/**
 * Company: CETAM
 * Project: QParking
 * File: slide_menu.dart
 * Created on: 12/12/2025
 * Created by: Rodrigo Peña
 * Approved by: CETAM Dev Team
 *
 * Changelog:
 * - ID: 7 | Modified on: 13/12/2025 | Rodrigo Peña | Restored Company Logo, increased button size, and fixed vertical spacing.
 */
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_theme.dart';
import '../icons/app_icons.dart';
import 'app_icon.dart';

class SlideMenu extends StatelessWidget {
  const SlideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    const String userName = "Daniel Mendoza";
    const String userEmail = "daniel.mendoza@cetam.mx";

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
            // --- HEADER ---
            Container(
              padding: const EdgeInsets.fromLTRB(12, 30, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fila de Logo y Texto
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // CORRECCIÓN 1: LOGO DE LA EMPRESA
                        const CircleAvatar(
                          radius: 28, // Un poco más grande para destacar
                          backgroundColor: Colors.transparent, // Fondo transparente para el PNG
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
                  ),

                  // CORRECCIÓN 2: ESPACIADO AUMENTADO
                  // Antes era 8, ahora 24 para separar bien la info del botón
                  const SizedBox(height: 24),

                  // CORRECCIÓN 3: BOTÓN MÁS GRANDE Y LEGIBLE
                  SizedBox(
                    height: 48, // Altura aumentada (antes 40)
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: () {
                        context.pop();
                        context.push('/profile');
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.gray400,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const AppIcon(
                          name: AppIconName.user,
                          size: 22, // Icono más grande (antes 16)
                          color: AppTheme.gray400
                      ),
                      label: const Text(
                          'Mi perfil',
                          style: TextStyle(
                            fontWeight: FontWeight.w600, // Letra con más peso
                            fontSize: 15, // Letra más grande (antes 13)
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(color: AppTheme.gray600, height: 1),
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

            // Navigation Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _DrawerItem(
                    iconName: AppIconName.home,
                    label: 'Inicio',
                    isActive: true,
                    onTap: () {
                      context.pop();
                      context.go('/home');
                    },
                  ),

                  _DrawerItem(
                    iconName: AppIconName.card,
                    label: 'Tarjeta',
                    onTap: () {
                      context.pop();
                      context.push('/bank_card');
                    },
                  ),
                  _DrawerItem(
                    iconName: AppIconName.list,
                    label: 'Actividad',
                    onTap: () {
                      context.pop();
                      context.push('/activity');
                    },
                  ),
                  _DrawerItem(
                    iconName: AppIconName.star,
                    label: 'Suscripciones',
                    onTap: () {
                      context.pop();
                      context.push('/subscriptions');
                    },
                  ),
                  _DrawerItem(
                    iconName: AppIconName.userTie,
                    label: 'Solicitudes',
                    onTap: () {
                      context.pop();
                      context.push('/show_requests');
                    },
                  ),
                ],
              ),
            ),

            // Footer
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
  }) : assert(iconName != null || imagePath != null, 'Provide iconName or imagePath');

  @override
  Widget build(BuildContext context) {
    final finalIconColor = iconColor ?? (isActive ? AppTheme.white : AppTheme.gray400);
    final finalTextColor = textColor ?? (isActive ? AppTheme.white : AppTheme.gray50);

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
      return Image.asset(imagePath!, width: 24, height: 24, fit: BoxFit.contain);
    }
    return AppIcon(
      name: iconName!,
      size: 20,
      color: color,
    );
  }
}