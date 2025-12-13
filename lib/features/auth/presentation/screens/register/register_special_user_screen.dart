/// Company: CETAM
/// Project: QParking
/// File: register_normal_user_screen.dart
/// Created on: 15/11/2025
/// Created by: Daniel Yair Mendoza Alvarez
/// Approved by: Daniel Yair Mendoza Alvarez
///
/// Changelog:
/// - ID: 1 | Modified on: 25/11/2025 |
/// Modified by: Gamaliel Alejandro Juarez |
/// Description: UI standardization  (Forms & Layout) |
/// - ID: 2 | Modified on: 30/11/2025 |
/// Modified by: Carlos Adair Bautista Godinez |
/// Description: Standarization of icons and form corrections |
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/icons/app_icons.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/widgets/app_icon.dart';

final specialRegisterLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);

class RegisterSpecialUserScreen extends ConsumerStatefulWidget {
  const RegisterSpecialUserScreen({super.key});

  @override
  ConsumerState<RegisterSpecialUserScreen> createState() => _RegisterSpecialUserScreenState();
}

class _RegisterSpecialUserScreenState extends ConsumerState<RegisterSpecialUserScreen> {
  // Business Controllers
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  final _parkingCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final bool _isObscure = true;

  //Provisional
  final List<String> _parkingOptions = [];
  String? _selectedParking;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  Future<void> _onRegister() async {
    if (!_formKey.currentState!.validate()) return;
    ref.read(specialRegisterLoadingProvider.notifier).state = true;
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    ref.read(specialRegisterLoadingProvider.notifier).state = false;
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(specialRegisterLoadingProvider);

    return Scaffold(
      backgroundColor: AppTheme.gray50,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: AppIcon(name: AppIconName.back),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Registro Empresarial',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 450),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Usuario Especial',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Completa tus datos personales para comenzar.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.gray600
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Input: Full Name
                    SizedBox(
                      height: 60,
                      child: TextFormField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Nombre Completo',
                        ),
                        validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Input: Email
                    SizedBox(
                      height: 60,
                      child: TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Correo Electrónico',
                        ),
                        validator: (v) => v!.contains('@') ? null : 'Correo inválido',
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Input: Phone
                    SizedBox(
                      height: 60,
                      child: TextFormField(
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Teléfono',
                        ),
                        validator: (v) => v!.length < 10 ? 'Teléfono inválido' : null,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Input: Password
                    SizedBox(
                      height: 60,
                      child: TextFormField(
                        controller: _passCtrl,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                        ),
                        validator: (v) => v!.length < 6 ? 'Mínimo 6 caracteres' : null,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Input: Confirm Password
                    SizedBox(
                      height: 60,
                      child: TextFormField(
                        controller: _confirmPassCtrl,
                        obscureText: _isObscure,
                        decoration: const InputDecoration(
                          labelText: 'Confirmar Contraseña',
                        ),
                        validator: (v) {
                          if (v != _passCtrl.text) return 'Las contraseñas no coinciden';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      height: 60,
                      child: DropdownButtonFormField<String>(
                        value: _selectedParking,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: _parkingOptions.isEmpty
                              ? 'Estacionamiento'
                              : 'Estacionamiento',
                          enabled: _parkingOptions.isNotEmpty,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        hint: const Text('Seleccionar'),
                        items: _parkingOptions.map((String option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: _parkingOptions.isEmpty ? null : (String? newValue) {
                          setState(() {
                            _selectedParking = newValue;
                            _parkingCtrl.text = newValue ?? '';
                          });
                        },
                        validator: (value) {
                          if (_parkingOptions.isEmpty) {
                            return 'Sin registros para seleccionar.';
                          }
                          return value == null || value.isEmpty ? 'Selección requerida' : null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Action Button
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _onRegister,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(color: AppTheme.white)
                            : const Text('Registrarse'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}