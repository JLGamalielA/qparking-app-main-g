/// Company: CETAM
/// Project: QParking
/// File: add_credit_screen.dart
/// Created on: 15/11/2025
/// Created by: Daniel Mendoza
/// Approved by: Daniel Mendoza
///
/// Changelog:
/// - ID: 1 | Modified on: 25/11/2025 |
/// Modified by: Gamaliel Alejandro Juarez |
/// Description: UI standardization (Payment Form) |
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/app_dialog.dart';

final selectedAmountProvider = StateProvider.autoDispose<int>((ref) => 0);
final loadingCreditProvider = StateProvider.autoDispose<bool>((ref) => false);

class AddCreditScreen extends ConsumerStatefulWidget {
  const AddCreditScreen({super.key});

  @override
  ConsumerState<AddCreditScreen> createState() => _AddCreditScreenState();
}

class _AddCreditScreenState extends ConsumerState<AddCreditScreen> {
  final _customAmountCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _customAmountCtrl.dispose();
    super.dispose();
  }

  void _onAmountSelected(int amount) {
    ref.read(selectedAmountProvider.notifier).state = amount;
    _customAmountCtrl.clear();
  }

  Future<void> _onPay() async {
    // Determine amount
    final selected = ref.read(selectedAmountProvider);
    final custom = int.tryParse(_customAmountCtrl.text) ?? 0;
    final total = selected > 0 ? selected : custom;

    if (total <= 0) {
      AppDialog.show(
        context,
        type: DialogType.warning,
        title: 'Monto inválido',
        description: 'Por favor selecciona o ingresa un monto válido mayor a 0.',
      );
      return;
    }

    // Confirmation Dialog
    AppDialog.show(
      context,
      type: DialogType.question,
      title: '¿Confirmar recarga?',
      description: 'Se realizará un cargo de \$$total MXN a tu método de pago predeterminado.',
      primaryText: 'Confirmar',
      secondaryText: 'Cancelar',
      onPrimary: () async {
        Navigator.of(context).pop();
        ref.read(loadingCreditProvider.notifier).state = true;
        await Future.delayed(const Duration(seconds: 2));

        if (!mounted) return;
        ref.read(loadingCreditProvider.notifier).state = false;

        // Success Dialog
        AppDialog.show(
          context,
          type: DialogType.success,
          title: 'Recarga Exitosa',
          description: 'Tu saldo ha sido actualizado correctamente.',
          onPrimary: () {
            context.pop();
            context.pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedAmount = ref.watch(selectedAmountProvider);
    final isLoading = ref.watch(loadingCreditProvider);

    return Scaffold(
      backgroundColor: AppTheme.gray50,

      // --- AppBar  ---
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Recargar Saldo',
          style: TextStyle(
            color: AppTheme.primary,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Balance Card ---
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primary, AppTheme.tertiary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Saldo Actual',
                      style: TextStyle(
                        color: AppTheme.gray200,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '\$150.00',
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Cuenta Activa',
                        style: TextStyle(color: AppTheme.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Selecciona un monto',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 16),

              // --- Amount Selection ---
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  _AmountOption(
                    amount: 50,
                    isSelected: selectedAmount == 50,
                    onTap: () => _onAmountSelected(50),
                  ),
                  _AmountOption(
                    amount: 100,
                    isSelected: selectedAmount == 100,
                    onTap: () => _onAmountSelected(100),
                  ),
                  _AmountOption(
                    amount: 200,
                    isSelected: selectedAmount == 200,
                    onTap: () => _onAmountSelected(200),
                  ),
                  _AmountOption(
                    amount: 500,
                    isSelected: selectedAmount == 500,
                    onTap: () => _onAmountSelected(500),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // --- Custom Amount ---
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'O ingresa otro monto',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.gray600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 60, // Standard Height
                      child: TextFormField(
                        controller: _customAmountCtrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            ref.read(selectedAmountProvider.notifier).state = 0;
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Monto personalizado',
                          prefixIcon: Icon(Icons.attach_money),
                          suffixText: 'MXN',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // --- Pay Button ---
              SizedBox(
                height: 52, // Large Button
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : _onPay,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.success,
                    foregroundColor: AppTheme.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: isLoading
                      ? const SizedBox.shrink()
                      : const Icon(Icons.payment, size: 22),
                  label: isLoading
                      ? const CircularProgressIndicator(color: AppTheme.white)
                      : const Text('Realizar Recarga'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for Amount Chips
class _AmountOption extends StatelessWidget {
  final int amount;
  final bool isSelected;
  final VoidCallback onTap;

  const _AmountOption({
    required this.amount,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 48 - 12) / 2;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: width,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : AppTheme.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppTheme.primary : AppTheme.gray300,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ]
              : [],
        ),
        child: Text(
          '\$$amount',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isSelected ? AppTheme.white : AppTheme.primary,
          ),
        ),
      ),
    );
  }
}