/// Company: CETAM
/// Project: QParking
/// File: profile_screen.dart
/// Created on: 25/11/2025
/// Created by: Gamaliel Alejandro Juarez Loyde
/// Approved by: Daniel Yair Mendoza Alvarez
///
/// Changelog:
/// - ID: 2 | Modified on: 30/11/2025 |
/// Modified by: Carlos Adair Bautista Godinez |
/// Description: Standarization of icons |
library;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/widgets/app_icon.dart';
import '../../../../core/icons/app_icons.dart';
import '../../../../core/themes/app_theme.dart';


final obscureCurrentPassProvider = StateProvider.autoDispose<bool>((ref) => true);
final obscureNewPassProvider = StateProvider.autoDispose<bool>((ref) => true);
final obscureConfirmPassProvider = StateProvider.autoDispose<bool>((ref) => true);
final profileLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.gray50,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTheme.white),
        leading: IconButton(
          icon: AppIcon(name: AppIconName.back),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Mi expediente',
          style: TextStyle(color: AppTheme.white, fontWeight: FontWeight.w400, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: AppIcon(name: AppIconName.notification),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 8),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppTheme.gray700,
              child: const Text(
                'Us',
                style: TextStyle(color: AppTheme.white, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // User Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppTheme.gray300,
                      child: const Text('Us', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppTheme.primary)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Usuario QParking', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.primary)),
                          const SizedBox(height: 4),
                          Text('usuario@qparking.com', style: TextStyle(fontSize: 13, color: AppTheme.gray600)),
                          const SizedBox(height: 4),
                          Text('Rol: worker', style: TextStyle(fontSize: 13, color: AppTheme.gray600, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // User Data Section
              _SectionCard(
                title: 'Datos del usuario',
                child: Column(
                  children: const [
                    _ProfileInput(label: 'Nombre completo', value: 'Usuario QParking'),
                    SizedBox(height: 16),
                    _ProfileInput(label: 'Correo electrónico', value: 'usuario@qparking.com'),
                    SizedBox(height: 16),
                    _ProfileInput(label: 'Teléfono', value: '6149876543'),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Subscription Section
              _SectionCard(
                title: 'Suscripción',
                child: Column(
                  children: [
                    Row(
                      children: [
                        AppIcon(name: AppIconName.medal),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Plan actual', style: TextStyle(fontSize: 12, color: AppTheme.gray500)),
                            const Text('Plan Básico', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.primary)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 180,
                        height: 44,
                        child: ElevatedButton.icon(
                          onPressed: () {
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          icon: AppIcon(name: AppIconName.uploadArrow),
                          label: const Text('Cambiar plan'),
                        ),
                      ),
                    ),
                  ],
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

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.primary)),
        const SizedBox(height: 24),
        child,
      ]),
    );
  }
}

class _ProfileInput extends StatelessWidget {
  final String label;
  final String value;
  const _ProfileInput({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      style: const TextStyle(color: AppTheme.gray700, fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppTheme.gray300)),
        filled: true,
        fillColor: AppTheme.white,
      ),
    );
  }
}
