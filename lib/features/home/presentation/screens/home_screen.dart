/**
 * Company: CETAM
 * Project: QParking
 * File: home_screen.dart
 * Created on: 13/12/2025
 * Created by: Rodrigo Peña
 * Modified by: Rodrigo Peña
 * Approved by: Gamaliel Juarez
 *
 * Changelog:
 * - ID: 8 | Modified on: 13/12/2025 | Rodrigo Peña | Enabled navigation to ProfileScreen on user initials tap in AppBar.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/theme/app_theme.dart';
import 'package:qparking/core/widgets/app_icon.dart';
import 'package:qparking/core/icons/app_icons.dart';
import 'package:qparking/core/widgets/slide_menu.dart';

// Standard border radius constant
const double _kStandardBorderRadius = 12.0;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Hardcoded initials for demo purposes
    const String userInitials = "DM";

    return Scaffold(
      backgroundColor: AppTheme.gray50,

      // --- APP BAR ---
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        elevation: 0,
        centerTitle: true,
        // Iconos del AppBar (hamburguesa) en blanco
        iconTheme: const IconThemeData(color: AppTheme.white),
        title: const Text(
          'Inicio',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.white,
          ),
        ),
        actions: [
          // Notification Bell
          IconButton(
            onPressed: () {
              // Acción para notificaciones (pendiente)
            },
            icon: const AppIcon(
              name: AppIconName.bell,
              color: AppTheme.white,
              size: 22,
            ),
          ),

          // User Initials Avatar (AHORA CON NAVEGACIÓN)
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 4.0),
            child: InkWell(
              // ACCIÓN DE NAVEGACIÓN AL PERFIL
              onTap: () {
                context.push('/profile');
              },
              // Borde redondeado para el efecto de "splash" al tocar
              borderRadius: BorderRadius.circular(18),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppTheme.white.withOpacity(0.2),
                child: const Text(
                  userInitials,
                  style: TextStyle(
                    color: AppTheme.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      drawer: const SlideMenu(),

      // --- BODY ---
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Welcome Header
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: '¡Bienvenido a QParking,\n',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primary,
                          height: 1.3,
                        ),
                      ),
                      TextSpan(
                        text: 'Daniel Mendoza!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primary,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. Big QR Icon
              const Center(
                child: AppIcon(
                  name: AppIconName.qrCode,
                  size: 120,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 32),

              // 3. Action Buttons

              // Generate QR Button
              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: AppTheme.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_kStandardBorderRadius),
                    ),
                  ),
                  onPressed: () => context.push('/qr_generator'),
                  icon: const AppIcon(
                      name: AppIconName.qrCode,
                      color: AppTheme.white,
                      size: 24
                  ),
                  label: const Text(
                    'Generar Código QR',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Subscription Button
              SizedBox(
                height: 56,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.primary, width: 1.5),
                    foregroundColor: AppTheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_kStandardBorderRadius),
                    ),
                  ),
                  onPressed: () => context.push('/subscriptions'),
                  child: const Text(
                    'Consultar Suscripción',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // 4. Payment Method Card
              const Text(
                'Método de pago activo',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.gray600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),

              Material(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(_kStandardBorderRadius),
                child: InkWell(
                  onTap: () => context.push('/bank_card'),
                  borderRadius: BorderRadius.circular(_kStandardBorderRadius),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_kStandardBorderRadius),
                      border: Border.all(color: AppTheme.gray200),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const AppIcon(
                            name: AppIconName.card,
                            color: AppTheme.primary,
                            size: 28
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Visa',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.primary,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '**** **** **** 1234',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.gray600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const AppIcon(
                            name: AppIconName.forward,
                            size: 20,
                            color: AppTheme.gray400
                        ),
                      ],
                    ),
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