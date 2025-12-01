/// Company: CETAM
/// Project: QParking
/// File: home_screen.dart
/// Created on: 15/11/2025
/// Created by: Daniel Yair Mendoza Alvarez
/// Approved by: Daniel Yair Mendoza Alvarez
///
/// Changelog:
/// - ID: 1 | Modified on: 25/11/2025 |
/// Modified by: Gamaliel Alejandro Juarez |
/// Description: Main screen layout |
/// - ID: 2 | Modified on: 30/11/2025 |
/// Modified by: Carlos Adair Bautista Godinez |
/// Description: Standarization of icons |
library;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/icons/app_icons.dart';
import 'package:qparking/core/widgets/app_icon.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/slide_menu.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.gray50,

      // --- Dark AppBar ---
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTheme.white),
        title: const Text(
          'Inicio',
          style: TextStyle(
            color: AppTheme.white,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: AppIcon(name: AppIconName.notification),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 8),
            child: InkWell(
              onTap: () {
                context.push('/profile');
              },
              borderRadius: BorderRadius.circular(18),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppTheme.gray700,
                child: const Text(
                  'US',
                  style: TextStyle(
                    color: AppTheme.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      drawer: const SlideMenu(),

      // --- Content ---
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              const Text(
                'Bienvenido a QParking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                'Gestiona tu acceso y saldo de manera sencilla.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.gray700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),

              // --- Quick Action Card (QParking) ---
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(12),
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
                    IconTheme(
                      data: IconTheme.of(context).copyWith(size: 48.0),
                      child: AppIcon(name: AppIconName.qrCode),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Acceso Rápido',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      height: 52,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.push('/qr_generator');
                        },
                        icon: AppIcon(name: AppIconName.qrCode),
                        label: const Text('Generar Código QR'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: AppTheme.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Resumen de Cuenta',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.gray700,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _InfoCard(
                      title: 'Saldo',
                      value: '\$150.00',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _InfoCard(
                      title: 'Visitas',
                      value: '12',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//  Widget InfoCard
class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  // Icon and Color removed

  const _InfoCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.gray600,
            ),
          ),
        ],
      ),
    );
  }
}