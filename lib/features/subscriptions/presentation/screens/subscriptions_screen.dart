/**
 * Company: CETAM
 * Project: QParking
 * File: subscriptions_screen.dart
 * Created on: 13/12/2025
 * Created by: Rodrigo Peña
 * Approved by: Gamaliel Juarez
 *
 * Changelog:
 * - ID: 1 | Modified on: 13/12/2025 | Rodrigo Peña | Initial creation of Subscriptions screen with card-based layout for plans.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/theme/app_theme.dart';
import 'package:qparking/core/widgets/app_icon.dart';
import 'package:qparking/core/icons/app_icons.dart';

// Standard border radius for consistency
const double _kStandardBorderRadius = 12.0;

// --- MOCK DATA MODEL (Local for UI structure) ---
class _SubscriptionPlan {
  final String name;
  final String priceLabel;
  final String tag;
  final Color headerColor;
  final String buttonText;

  _SubscriptionPlan({
    required this.name,
    required this.priceLabel,
    required this.tag,
    required this.headerColor,
    required this.buttonText,
  });
}

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String userInitials = "DM";

    //Mock data definitions
    final List<_SubscriptionPlan> plans = [
      _SubscriptionPlan(
        name: "Individual Mensual",
        priceLabel: "\$150 / mes",
        tag: "1 cuenta",
        headerColor: AppTheme.primary, // Standard dark blue
        buttonText: "Contratar Individual",
      ),
      _SubscriptionPlan(
        name: "Estudiante",
        priceLabel: "\$80 / mes",
        tag: "1 cuenta (Requiere validación)",
        headerColor: AppTheme.indigo, // A brighter purple/blue for distinction
        buttonText: "Contratar Estudiante",
      ),
      _SubscriptionPlan(
        name: "Familiar",
        priceLabel: "\$250 / mes",
        tag: "Hasta 4 cuentas",
        headerColor: AppTheme.tertiary, // A different tone for premium tier
        buttonText: "Contratar Familiar",
      ),
    ];

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
                'Selecciona tu plan ideal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Disfruta de acceso ilimitado y beneficios exclusivos.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.gray600,
                ),
              ),
              const SizedBox(height: 24),

              // --- PLAN CARDS LIST ---
              ListView.separated(
                shrinkWrap: true, // Important inside SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling
                itemCount: plans.length,
                separatorBuilder: (_, __) => const SizedBox(height: 24),
                itemBuilder: (context, index) {
                  return _PlanCardWidget(plan: plans[index]);
                },
              ),

              const SizedBox(height: 32),
              // Cancel info at bottom
              Center(
                child: TextButton(
                  onPressed: () {
                    // TODO: Navigate to terms conditions
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

  // Helper for blank feature placeholders
  Widget _buildFeaturePlaceholder() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(Icons.check, size: 20, color: plan.headerColor.withOpacity(0.7)),
          const SizedBox(width: 12),
          Container(
            height: 12,
            width: 150, // Fixed width for placeholder
            decoration: BoxDecoration(
                color: AppTheme.gray100,
                borderRadius: BorderRadius.circular(4)
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Using hardEdge to clip the colored banner container correctly within rounded corners
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
                // Plan Name
                Text(
                  plan.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                // Price Label
                Text(
                  plan.priceLabel,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.gray700,
                  ),
                ),
                const SizedBox(height: 12),
                // Tag Container
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: plan.headerColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    plan.tag,
                    style: TextStyle(
                      color: plan.headerColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(color: AppTheme.gray200),
                ),

                // --- Features Section (BLANK PLACEHOLDERS as requested) ---
                // We use visual placeholders instead of empty space to maintain card structure
                _buildFeaturePlaceholder(),
                _buildFeaturePlaceholder(),
                _buildFeaturePlaceholder(),
                _buildFeaturePlaceholder(),

                const SizedBox(height: 24),

                // --- CTA Button ---
                SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: plan.headerColor, // Button matches plan color
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
                      // TODO: Handle subscription selection logic
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