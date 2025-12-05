/// Company: CETAM
/// Project: QParking
/// File: bank_card_screen.dart
/// Created on: 04/12/2025
/// Modified on: 04/12/2025 (Fix: Back button visibility and Standard AppBar)
/// Description: Complete Screen
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/icons/app_icons.dart';
import '../../../../core/widgets/app_icon.dart';


class BankCardScreen extends StatefulWidget {
  const BankCardScreen({super.key});

  @override
  State<BankCardScreen> createState() => _BankCardScreenState();
}

class _BankCardScreenState extends State<BankCardScreen> {
  final _formKey = GlobalKey<FormState>();


  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Registro de Tarjeta',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.primary,
          ),
        ),
        centerTitle: true,

      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  'Datos Bancarios',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ingrese la información de su tarjeta para pagos futuros.',
                  style: TextStyle(color: AppTheme.gray600),
                ),
                const SizedBox(height: 32),


                _buildLabel('Número de tarjeta *'),
                TextFormField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  maxLength: 16,
                  decoration: const InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: AppIcon(name: AppIconName.card, size: 20),
                    ),
                    counterText: "",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    if (value.length < 16) {
                      return 'Formato no válido (16 dígitos).';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),


                _buildLabel('Nombre del titular *'),
                TextFormField(
                  controller: _cardHolderController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: AppIcon(name: AppIconName.user, size: 20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),


                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Expiración (MM/AA) *'),
                          TextFormField(
                            controller: _expiryDateController,
                            keyboardType: TextInputType.datetime,
                            maxLength: 5,
                            decoration: const InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(12.0),
                                // Usamos 'pending' (reloj) si no agregaste 'calendar' aún
                                child: AppIcon(name: AppIconName.pending, size: 20),
                              ),
                              hintText: 'MM/AA',
                              counterText: "",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Dato requerido.';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('CVV *'),
                          TextFormField(
                            controller: _cvvController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            maxLength: 4,
                            decoration: const InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: AppIcon(name: AppIconName.lock, size: 20),
                              ),
                              counterText: "",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Dato requerido.';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),


                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          context.pop();
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppTheme.secondary),
                          foregroundColor: AppTheme.secondary,
                          minimumSize: const Size(double.infinity, 52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const AppIcon(name: AppIconName.cancel, size: 18),
                        label: const Text('Cancelar'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Tarjeta guardada correctamente.'),
                                backgroundColor: AppTheme.success,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: AppTheme.white,
                          minimumSize: const Size(double.infinity, 52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const AppIcon(name: AppIconName.save, color: AppTheme.white, size: 18),
                        label: const Text('Guardar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: AppTheme.gray700,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}