/**
 * Company: CETAM
 * Project: QParking
 * File: subscriptions_screen.dart
 * Created on: 13/12/2025
 * Created by: Rodrigo Peña
 * Modified by: Rodrigo Peña
 * Approved by: Gamaliel Juarez
 *
 * Changelog:
 * - ID: 2 | Modified on: 13/12/2025 | Rodrigo Peña | Updated plans to Basic and Premium with specific feature visibility.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/theme/app_theme.dart';
import 'package:qparking/core/utils/app_alerts.dart'; // Import alerts
import 'package:qparking/core/widgets/app_icon.dart';
import 'package:qparking/core/icons/app_icons.dart';

// Standard border radius
const double _kStandardBorderRadius = 12.0;

// --- MOCK DATA MODELS ---
class _FeatureItem {
  final String label;
  final bool included;

  _FeatureItem(this.label, {this.included = true});
}

class _SubscriptionPlan {
  final String name;
  final String priceLabel;
  final String tag;
  final Color headerColor;
  final String buttonText;
  final List<_FeatureItem> features;

  _SubscriptionPlan({
    required this.name,
    required this.priceLabel,
    required this.tag,
    required this.headerColor,
    required this.buttonText,
    required this.features,
  });
}

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String userInitials = "DM";

    // --- DEFINING THE 2 PLANS ---
    final List<_SubscriptionPlan> plans = [
      // 1. BASIC PLAN
      _SubscriptionPlan(
        name: "Plan Básico",
        priceLabel: "\$119 / mes",
        tag: "Uso estándar",
        headerColor: AppTheme.primary, // Dark Blue (Standard)
        buttonText: "Contratar Básico",
        features: [
          _FeatureItem("Generación de códigos QR"),
          _FeatureItem("Acceso a estacionamientos"),
          _FeatureItem("Pagos con tarjeta"),
          _FeatureItem("Soporte técnico"),
          _FeatureItem("Historial de Actividad", included: false), // NOT INCLUDED
        ],
      ),

      // 2. PREMIUM PLAN
      _SubscriptionPlan(
        name: "Plan Premium",
        priceLabel: "\$349 / mes",
        tag: "Acceso Total",
        headerColor: AppTheme.secondary, // Orange/Red (Highlight)
        buttonText: "Contratar Premium",
        features: [
          _FeatureItem("Generación de códigos QR "),
          _FeatureItem("Acceso a estacionamientos"),
          _FeatureItem("Pagos con tarjeta"),
          _FeatureItem("Soporte técnico"),
          _FeatureItem("Historial de Actividad Completo"), // INCLUDED
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: AppTheme.gray50,

      // --- DARK HEADER ---
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const AppIcon(name: AppIconName.back, color: AppTheme.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Suscripciones',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mejora tu experiencia',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Elige el plan que mejor se adapte a tus necesidades de movilidad.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.gray600,
                ),
              ),
              const SizedBox(height: 24),

              // --- PLAN CARDS LIST ---
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: plans.length,
                separatorBuilder: (_, __) => const SizedBox(height: 24),
                itemBuilder: (context, index) {
                  return _PlanCardWidget(plan: plans[index]);
                },
              ),

              const SizedBox(height: 32),

              // Footer link
              Center(
                child: TextButton(
                  onPressed: () {
                    // TODO: Terms navigation
                  },
                  child: const Text(
                    'Términos y condiciones de suscripción',
                    style: TextStyle(color: AppTheme.gray500, fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// --- INTERNAL WIDGET: PLAN CARD ---
class _PlanCardWidget extends StatelessWidget {
  final _SubscriptionPlan plan;

  const _PlanCardWidget({required this.plan});

  // Feature row builder
  Widget _buildFeatureRow(String text, bool included) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
              included ? Icons.check_circle : Icons.cancel,
              size: 20,
              color: included ? plan.headerColor : AppTheme.gray400 // Grey if not included
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: included ? AppTheme.gray700 : AppTheme.gray400,
                // Strike-through if excluded
                decoration: included ? null : TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(_kStandardBorderRadius),
        border: Border.all(color: AppTheme.gray200),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- Colored Top Banner ---
          Container(
            height: 12,
            color: plan.headerColor,
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name & Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        plan.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: plan.headerColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        plan.tag,
                        style: TextStyle(
                          color: plan.headerColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  plan.priceLabel,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: plan.headerColor, // Price matches theme color
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(color: AppTheme.gray200),
                ),

                // --- Features List ---
                ...plan.features.map((f) => _buildFeatureRow(f.label, f.included)),

                const SizedBox(height: 24),

                // --- CTA Button ---
                SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: plan.headerColor,
                        foregroundColor: AppTheme.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_kStandardBorderRadius),
                        ),
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        )
                    ),
                    onPressed: () {
                      // Standard Alert Success 7.4.1
                      AppAlerts.showSuccess(
                        context: context,
                        title: "¡Excelente elección!",
                        message: "Has seleccionado el ${plan.name}. Serás redirigido al pago.",
                        onOk: () {
                          context.push('/bank_card');
                        },
                      );
                    },
                    child: Text(plan.buttonText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}