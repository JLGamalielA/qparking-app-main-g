/// Company: CETAM
/// Project: QParking
/// File: login_screen.dart
/// Created on: 13/12/2025
/// Created by: Rodrigo Peña
/// Approved by: Gamaliel Juarez
///
/// Changelog:
/// - ID: 3 | Modified on: 13/12/2025 | Rodrigo Peña | Changed 'Register' link color to dark emphasis (Tertiary) as requested.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Imports l10n
import '../../../../../l10n/app_localizations.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_icon.dart';
import '../../../../core/icons/app_icons.dart';

// State providers
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

    if (!mounted) return;

    ref.read(loginLoadingProvider.notifier).state = false;
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loginLoadingProvider);
    const isObscure = true;

    final l10n = AppLocalizations.of(context)!;

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
                  // --- Header ---
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
                  Text(
                    l10n.login_subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppTheme.gray600,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // --- Email Input ---
                  SizedBox(
                    height: 60,
                    child: TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 16, color: AppTheme.gray900),
                      decoration: InputDecoration(
                        labelText: l10n.form_email_label,
                        prefixIcon: const AppIcon(name: AppIconName.email),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.error_required_field;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Password Input (Clean) ---
                  SizedBox(
                    height: 60,
                    child: TextFormField(
                      controller: _passCtrl,
                      obscureText: isObscure,
                      style: const TextStyle(fontSize: 16, color: AppTheme.gray900),
                      decoration: InputDecoration(
                        labelText: l10n.form_password_label,
                        prefixIcon: const AppIcon(name: AppIconName.lock),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.error_required_field;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 32),

                  // --- Main Button ---
                  SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: isLoading ? null : _onLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(180, 52),
                      ),
                      icon: isLoading
                          ? const SizedBox.shrink()
                          : const AppIcon(
                        name: AppIconName.login,
                        color: AppTheme.white,
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
                          : Text(l10n.action_login),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // --- Register Link  ---
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.login_no_account,
                        style: const TextStyle(color: AppTheme.gray600, fontSize: 14),
                      ),
                      TextButton(
                        onPressed: () => context.push('/register'),
                        child: Text(
                          l10n.action_register,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.tertiary,
                          ),
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