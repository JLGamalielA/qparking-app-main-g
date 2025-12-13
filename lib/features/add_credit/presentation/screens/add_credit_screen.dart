/**
 * Company: CETAM
 * Project: QParking
 * File: add_credit_screen.dart
 * Created on: 15/11/2025
 * Created by: Daniel Mendoza
 * Approved by: Daniel Mendoza
 *
 * Changelog:
 * - ID: 2 | Modified on: 12/12/2025 |
 * Modified by: Rodrigo Peña Vega |
 * Description: Refactored to use global constants and String icon aliases. |
 */
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/constants/constants_exports.dart';
import 'package:qparking/core/widgets/widgets_exports.dart';

import '../../../../core/icons/app_icons.dart';
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
      // Show warning dialog for invalid amount
      showDialog(
        context: context,
        builder: (context) =>
            AppDialog.warning(
              title: 'Monto inválido',
              message: 'Por favor selecciona o ingresa un monto válido mayor a 0.',
              onConfirm: () => context.pop(),
            ),
      );
      return;
    }

// Show confirmation dialog before processing payment
    showDialog(
      context: context,
      builder: (context) =>
          AppDialog.confirm(
            title: '¿Confirmar recarga?',
            message: 'Se realizará un cargo de \$$total MXN a tu método de pago predeterminado.',
            onConfirm: () async {
              // Close the confirmation dialog first
              context.pop();

              ref
                  .read(loadingCreditProvider.notifier)
                  .state = true;
              await Future.delayed(const Duration(seconds: 2));

              if (!mounted) return;
              ref
                  .read(loadingCreditProvider.notifier)
                  .state = false;

              // Show success dialog after processing
              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (context) =>
                      AppDialog.success(
                        title: 'Recarga Exitosa',
                        message: 'Tu saldo ha sido actualizado correctamente.',
                        onConfirm: () {
                          // Close dialog and return to previous screens
                          context.pop();
                          context.pop();
                        },
                      ),
                );
              }
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedAmount = ref.watch(selectedAmountProvider);
    final isLoading = ref.watch(loadingCreditProvider);

    return Scaffold(
      backgroundColor: GRAY_50, // Replaced AppTheme.gray50

      // --- AppBar  ---
      appBar: AppBar(
        backgroundColor: WHITE_COLOR, // Replaced AppTheme.white
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          // Use String alias 'back'
          icon: const AppIcon(name: AppIconName.back, color: PRIMARY_COLOR),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Recargar Saldo',
          style: TextStyle(
            color: PRIMARY_COLOR, // Replaced AppTheme.primary
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
                    colors: [PRIMARY_COLOR, TERTIARY_COLOR],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: PRIMARY_COLOR.withOpacity(0.2),
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
                        color: GRAY_200, // Replaced AppTheme.gray200
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '\$150.00',
                      style: TextStyle(
                        color: WHITE_COLOR, // Replaced AppTheme.white
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: PRIMARY_COLOR, // Replaced AppTheme.primary
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Cuenta Activa',
                        style: TextStyle(color: WHITE_COLOR, fontSize: 12),
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
                  color: PRIMARY_COLOR,
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
                        color: GRAY_600, // Replaced AppTheme.gray600
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
                          // Use String alias 'money'
                          prefixIcon: AppIcon(name: AppIconName.money , color: PRIMARY_COLOR, size: 20),
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
                    backgroundColor: SUCCESS_COLOR, // Replaced AppTheme.success
                    foregroundColor: WHITE_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: isLoading
                      ? const SizedBox.shrink()
                  // Use String alias 'card' or 'payment' for icon
                      : const AppIcon(name: AppIconName.card, size: 22, color: WHITE_COLOR),
                  label: isLoading
                      ? const CircularProgressIndicator(color: WHITE_COLOR)
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
          color: isSelected ? PRIMARY_COLOR : WHITE_COLOR, // Replaced AppTheme
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? PRIMARY_COLOR : GRAY_300,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: PRIMARY_COLOR.withOpacity(0.3),
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
            color: isSelected ? WHITE_COLOR : PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }
}