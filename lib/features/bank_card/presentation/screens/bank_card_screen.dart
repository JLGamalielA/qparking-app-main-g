/**
 * Company: CETAM
 * Project: QParking
 * File: bank_card_screen.dart
 * Created on: 13/12/2025
 * Created by: Rodrigo Peña
 * Modified by: Rodrigo Peña
 * Approved by: Gamaliel Juarez
 *
 * Changelog:
 * - ID: 3 | Modified on: 13/12/2025 | Rodrigo Peña |
 * Implemented subscription activation logic on payment confirmation.
 * Standardized comments to English and ensured UI consistency.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/theme/app_theme.dart';
import 'package:qparking/core/widgets/app_icon.dart';
import 'package:qparking/core/icons/app_icons.dart';
import 'package:qparking/core/utils/app_alerts.dart';
import 'package:qparking/features/subscriptions/subscriptions_exports.dart';

// Standard border radius used across the application
const double _kStandardBorderRadius = 12.0;

class BankCardScreen extends ConsumerWidget {
  const BankCardScreen({super.key});

  // Helper widget for input field labels
  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppTheme.gray700,
        ),
      ),
    );
  }

  // Standard decoration for form text fields based on manual 7.4
  InputDecoration _inputDecoration({String? hint, AppIconName? icon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14, color: AppTheme.gray400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      filled: true,
      fillColor: AppTheme.gray50,
      prefixIcon: icon != null
          ? AppIcon(name: icon, size: 20, color: AppTheme.gray500)
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppTheme.gray200, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppTheme.gray200, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Current user initials for the header
    const String userInitials = "DM";
    // Access the subscription state to handle mandatory flow
    final bool hasPlan = ref.watch(hasActivePlanProvider);

    return Scaffold(
      backgroundColor: AppTheme.gray50,

      // --- STANDARD DARK HEADER ---
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        elevation: 0,
        centerTitle: true,
        // Show back button only if the user already has a plan (normal update)
        automaticallyImplyLeading: hasPlan,
        iconTheme: const IconThemeData(color: AppTheme.white),
        title: const Text(
          'Pago con Tarjeta',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Notification logic placeholder
            },
            icon: const AppIcon(name: AppIconName.bell, color: AppTheme.white, size: 22),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 4.0),
            child: InkWell(
              onTap: () => context.push('/profile'),
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

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Main Card Information Container
              Container(
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: AppIcon(
                        name: AppIconName.card,
                        size: 48,
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Card Number Input Section
                    _sectionLabel('Número de Tarjeta'),
                    SizedBox(
                      height: 60,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration(
                          hint: '0000 0000 0000 0000',
                          icon: AppIconName.card,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Card Holder Name Input Section
                    _sectionLabel('Nombre del Titular'),
                    SizedBox(
                      height: 60,
                      child: TextField(
                        decoration: _inputDecoration(
                          hint: 'Como aparece en la tarjeta',
                          icon: AppIconName.user,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Expiration and CVV Row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _sectionLabel('Vencimiento'),
                              SizedBox(
                                height: 60,
                                child: TextField(
                                  keyboardType: TextInputType.datetime,
                                  decoration: _inputDecoration(hint: 'MM/AA'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _sectionLabel('CVV / CVC'),
                              SizedBox(
                                height: 60,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  obscureText: true,
                                  decoration: _inputDecoration(
                                      hint: '123',
                                      icon: AppIconName.lock
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Standard Security Message Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        AppIcon(name: AppIconName.lock, size: 14, color: AppTheme.success),
                        SizedBox(width: 8),
                        Text(
                          'Transacción segura y encriptada',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.gray500,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Main Action Button
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: AppTheme.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(_kStandardBorderRadius),
                          ),
                        ),
                        onPressed: () {
                          // Update global state: Mark user as subscribed
                          ref.read(hasActivePlanProvider.notifier).state = true;

                          // Show standard success alert (Manual 7.4.1)
                          AppAlerts.showSuccess(
                            context: context,
                            title: "¡Pago Exitoso!",
                            message: "Tu tarjeta ha sido registrada y tu plan activado correctamente.",
                            onOk: () {
                              // Direct navigation to Home now that the plan is active
                              context.go('/home');
                            },
                          );
                        },
                        child: const Text(
                          'Confirmar Pago',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}