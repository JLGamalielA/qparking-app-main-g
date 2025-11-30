/**
 * Company: CETAM
 * Project: QParking
 * File: login_screen.dart
 * Created on: 15/11/2025
 * Created by: Daniel Yair Mendoza Alvarez
 * Approved by: Daniel Yair Mendoza Alvarez
 *
 * Changelog:
 * - ID: 1 | Modified on: 25/11/2025 |
 * Modified by: Gamaliel Alejandro Juarez |
 * Description: Adaptation to programming manual standards |
 * - ID: 2 | Modified on: 30/11/2025 |
 * Modified by: Carlos Adair Bautista Godinez |
 * Description: Standarization of icons |
 */


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/app_icon.dart';
import '../../../../core/icons/app_icons.dart';

final loginLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);
final obscurePasswordProvider = StateProvider.autoDispose<bool>((ref) => true);

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    ref.read(loginLoadingProvider.notifier).state = true;
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) {
      return;
    }

    ref.read(loginLoadingProvider.notifier).state = false;
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loginLoadingProvider);
    final isObscure = ref.watch(obscurePasswordProvider);

    return Scaffold(
      backgroundColor: AppTheme.gray50,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  const Text(
                    'QParking',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Accede con tu cuenta para gestionar\ntu estacionamiento.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppTheme.gray600,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Email Input
                  SizedBox(
                    height: 60,
                    child: TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 16, color: AppTheme.gray900),
                      decoration: const InputDecoration(
                        labelText: 'Correo Electrónico',
                        prefixIcon: AppIcon(name: AppIconName.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo requerido';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Input
                  SizedBox(
                    height: 60,
                    child: TextFormField(
                      controller: _passCtrl,
                      obscureText: isObscure,
                      style: const TextStyle(fontSize: 16, color: AppTheme.gray900),
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: AppIcon(name: AppIconName.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo requerido';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Main Button
                  SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: isLoading ? null : _onLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      label: isLoading
                          ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: AppTheme.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text('Iniciar Sesión'),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Register Link
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "¿No tienes cuenta?",
                        style: TextStyle(color: AppTheme.gray600, fontSize: 14),
                      ),
                      TextButton(
                        onPressed: () => context.push('/user_type'),
                        child: const Text(
                          'Regístrate',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}