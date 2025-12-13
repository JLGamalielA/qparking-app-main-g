/**
 * Company: CETAM
 * Project: QParking
 * File: create_special_user_request.dart
 * Created on: 13/12/2025
 * Created by: Rodrigo Peña
 * Modified by: Rodrigo Peña
 * Approved by: Gamaliel Juarez
 *
 * Changelog:
 * - ID: 3 | Modified on: 13/12/2025 | Rodrigo Peña |
 * Removed vehicle plates field and moved parking selection to the first position.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/theme/app_theme.dart';
import 'package:qparking/core/widgets/app_icon.dart';
import 'package:qparking/core/icons/app_icons.dart';
import 'package:qparking/core/utils/app_alerts.dart';

// Standard border radius constant
const double _kStandardBorderRadius = 12.0;

class CreateSpecialUserRequest extends StatelessWidget {
  const CreateSpecialUserRequest({super.key});

  // Helper for Section Labels
  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppTheme.primary,
        ),
      ),
    );
  }

  // Standardized Input Decoration
  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14, color: AppTheme.gray400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      filled: true,
      fillColor: AppTheme.gray50,
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
    const String userInitials = "DM";

    return Scaffold(
      backgroundColor: AppTheme.gray50,

      // --- STANDARD DARK HEADER ---
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const AppIcon(name: AppIconName.back, color: AppTheme.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Solicitud Especial',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.white,
          ),
        ),
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
              // --- Form Container ---
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(_kStandardBorderRadius),
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
                    // 1. Select Parking (NOW FIRST OPTION)
                    _sectionLabel('Seleccionar Estacionamiento'),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration(hint: 'Seleccione una opción'),
                      icon: const Icon(Icons.keyboard_arrow_down, color: AppTheme.gray500),
                      dropdownColor: AppTheme.white,
                      items: ['Plaza Central', 'Torre Norte', 'Centro Histórico']
                          .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e, style: const TextStyle(fontSize: 14))
                      ))
                          .toList(),
                      onChanged: (val) {},
                    ),
                    const SizedBox(height: 24),

                    // 2. User Type
                    _sectionLabel('Tipo de usuario solicitado'),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration(hint: 'Seleccione un tipo'),
                      icon: const Icon(Icons.keyboard_arrow_down, color: AppTheme.gray500),
                      dropdownColor: AppTheme.white,
                      items: ['Proveedor', 'Taxista', 'Empleado', 'Residente']
                          .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e, style: const TextStyle(fontSize: 14))
                      ))
                          .toList(),
                      onChanged: (val) {},
                    ),
                    const SizedBox(height: 24),

                    // 3. Justification / Description
                    _sectionLabel('Descripción de la solicitud'),
                    TextField(
                      decoration: _inputDecoration(hint: 'Añada una breve justificación...'),
                      maxLines: 5,
                      maxLength: 250, // Character limit as per instructions
                    ),
                    const SizedBox(height: 32),

                    // 4. Submit Button
                    SizedBox(
                      height: 52,
                      width: double.infinity,
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
                          // Standard Success Alert 7.4.1
                          AppAlerts.showSuccess(
                            context: context,
                            title: "Solicitud Enviada",
                            message: "Tu solicitud ha sido recibida y será revisada por un administrador.",
                            onOk: () => context.pop(),
                          );
                        },
                        child: const Text(
                          'Enviar Solicitud',
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