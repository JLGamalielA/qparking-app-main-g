/**
 * Company: CETAM
 * Project: QParking
 * File: register_screen.dart
 * Created on: 13/12/2025
 * Created by: Rodrigo Peña
 * Modified by: Rodrigo Peña
 * Approved by: Gamaliel Juarez
 *
 * Changelog:
 * - ID: 5 | Modified on: 13/12/2025 | Rodrigo Peña |
 * Translated UI to Spanish. Added fields: Name, Last Name, Email, and Phone.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/theme/app_theme.dart';
import 'package:qparking/core/widgets/app_icon.dart';
import 'package:qparking/core/icons/app_icons.dart';
import 'package:qparking/core/utils/app_alerts.dart';
import 'package:qparking/core/utils/app_alerts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Global key for form validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for user input fields
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  // Standardized input decoration according to manual 7.4
  InputDecoration _inputDecoration({required String label, required AppIconName icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: AppIcon(name: icon, size: 20, color: AppTheme.primary),
    );
  }

  // Logic to handle registration process
  void _handleRegister() {
    if (_formKey.currentState!.validate()) {

      // VALIDATION SUCCESS -> SHOW SUCCESS ALERT (7.4.1)
      AppAlerts.showSuccess(
        context: context,
        title: "Registro Exitoso",
        message: "Tu cuenta ha sido creada correctamente. Por favor inicia sesión.",
        onOk: () {
          context.go('/login');
        },
      );

    } else {
      // FORM ERROR -> SHOW ERROR ALERT (7.4.2)
      AppAlerts.showError(
        context: context,
        title: "Datos Incompletos",
        message: "Por favor verifica que todos los campos estén llenos correctamente.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          'Crear Cuenta',
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
              // --- Register Form Container ---
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Únete a QParking',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Completa tus datos para comenzar.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: AppTheme.gray600),
                      ),
                      const SizedBox(height: 32),

                      // First Name Input
                      TextFormField(
                        controller: _firstNameCtrl,
                        decoration: _inputDecoration(
                          label: 'Nombre',
                          icon: AppIconName.user,
                        ),
                        validator: (v) => v!.isEmpty ? 'El nombre es obligatorio' : null,
                      ),
                      const SizedBox(height: 20),

                      // Last Name Input
                      TextFormField(
                        controller: _lastNameCtrl,
                        decoration: _inputDecoration(
                          label: 'Apellidos',
                          icon: AppIconName.user,
                        ),
                        validator: (v) => v!.isEmpty ? 'Los apellidos son obligatorios' : null,
                      ),
                      const SizedBox(height: 20),

                      // Email Input
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDecoration(
                          label: 'Correo Electrónico',
                          icon: AppIconName.email,
                        ),
                        validator: (v) => v!.isEmpty ? 'El correo es obligatorio' : null,
                      ),
                      const SizedBox(height: 20),

                      // Phone Number Input
                      TextFormField(
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        decoration: _inputDecoration(
                          label: 'Número de Teléfono',
                          icon: AppIconName.phone, // Ensure phone is in your AppIconName enum
                        ),
                        validator: (v) => v!.isEmpty ? 'El teléfono es obligatorio' : null,
                      ),
                      const SizedBox(height: 20),

                      // Password Input
                      TextFormField(
                        controller: _passCtrl,
                        obscureText: true,
                        decoration: _inputDecoration(
                          label: 'Contraseña',
                          icon: AppIconName.lock,
                        ),
                        validator: (v) => v!.length < 6 ? 'Mínimo 6 caracteres' : null,
                      ),
                      const SizedBox(height: 32),

                      // Submit Button
                      ElevatedButton(
                        onPressed: _handleRegister,
                        child: const Text('Registrarse'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}