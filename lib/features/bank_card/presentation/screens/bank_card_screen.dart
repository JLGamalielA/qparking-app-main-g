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
 * - ID: 2 | Modified on: 13/12/2025 | Rodrigo Peña | Added notification bell and user initials to AppBar actions.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/theme/app_theme.dart';
import 'package:qparking/core/widgets/app_icon.dart';
import 'package:qparking/core/icons/app_icons.dart';

const double _kStandardBorderRadius = 12.0;

class BankCardScreen extends StatelessWidget {
  const BankCardScreen({super.key});

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
  Widget build(BuildContext context) {
    // Iniciales fijas para consistencia
    const String userInitials = "DM";

    return Scaffold(
      backgroundColor: AppTheme.gray50,

      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTheme.white),
        title: const Text(
          'Pago con Tarjeta',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.white,
          ),
        ),
        // --- NUEVO: ACCIONES (Campana + Iniciales) ---
        actions: [
          IconButton(
            onPressed: () {},
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
                          context.go('/home');
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