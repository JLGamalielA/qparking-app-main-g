/// Company: CETAM
/// Project: QParking
/// File: user_type_screen.dart
/// Created on: 15/11/2025
/// Created by: Daniel Yair Mendoza Alvarez
/// Approved by: Daniel Yair Mendoza Alvarez
///
/// Changelog:
/// - ID: 1 | Modified on: 25/11/2025 |
/// Modified by: Gamaliel Alejandro Juarez Loyde |
/// Description:Adaptation to UI standards |
/// - ID: 2 | Modified on: 30/11/2025 |
/// Modified by: Carlos Adair Bautista Godinez |
/// Description: Standarization of icons |
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/icons/app_icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_icon.dart';
import '../widgets/user_type_card_widget.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Registro',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Text
              const Text(
                '¿Qué tipo de usuario eres?',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Selecciona la opción que mejor describa tu rol para continuar con el registro.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.gray600,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // Normal User
              UserTypeCard(
                title: 'Usuario Normal',
                description:
                'Regístrate como usuario normal si solo deseas usar, entrar y pagar estacionamientos de forma regular.',
                onTap: () {
                  context.push('/register_normal_user');
                },
              ),
              const SizedBox(height:20),

              // Special User
              UserTypeCard(
                title: 'Usuario Especial',
                description:
                'Regístrate como usuario especial si eres proveedor, taxi o tienes un convenio con algún estacionamiento afiliado.',
                onTap: () {
                  context.push('/register_special_user');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}