/**
 * Company: CETAM
 * Project: QParking
 * File: activity_card_widget.dart
 * Created on: 01/12/2025
 * Created by: Rodrigo Peña
 * Approved by: Daniel Yair Mendoza Alvarez
 *
 * Changelog:
 * - ID: 2 | Modified on: 12/12/2025 |
 * Modified by: Rodrigo Peña |
 * Description: Refactored to use global constants and String icon aliases. |
 */

import 'package:flutter/material.dart';
import 'package:qparking/core/constants/constants_exports.dart';
import 'package:qparking/core/widgets/widgets_exports.dart';
import '../../../../core/icons/app_icons.dart';
import '../../data/activity_model.dart';

class ActivityCardWidget extends StatelessWidget {
  final ActivityModel activity;

  const ActivityCardWidget({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: WHITE_COLOR, // Replaced AppTheme.white
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: GRAY_200), // Replaced AppTheme.gray200
        boxShadow: [
          BoxShadow(
            color: PRIMARY_COLOR.withOpacity(0.05), // Replaced AppTheme.primary
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // --- Header Row: Icon + Name + Folio ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Visual Indicator
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                // Use String alias 'invoice' (Ensure this is added to app_icons.dart)
                child: const AppIcon(
                  name: AppIconName.invoice,
                  color: PRIMARY_COLOR,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),

              // Name and Folio
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.parkingName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: PRIMARY_COLOR, // Replaced AppTheme.primary
                      ),
                    ),
                    Text(
                      'Folio: ${activity.transactionFolio}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: GRAY_500, // Replaced AppTheme.gray500
                      ),
                    ),
                  ],
                ),
              ),

              // Date (Top Right)
              Text(
                activity.date,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: GRAY_600, // Replaced AppTheme.gray600
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(height: 1, color: GRAY_200), // Replaced AppTheme.gray200
          const SizedBox(height: 12),

          // --- Details Row: Times & Total ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Times Column (Left)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TimeRow(label: 'Entrada:', value: activity.entryTime),
                  const SizedBox(height: 4),
                  _TimeRow(label: 'Salida:', value: activity.exitTime),
                  const SizedBox(height: 4),
                  _TimeRow(label: 'Duración:', value: activity.duration),
                ],
              ),

              // Total Amount (Right)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                      'Total',
                      style: TextStyle(fontSize: 12, color: GRAY_500)
                  ),
                  Text(
                    '\$${activity.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: PRIMARY_COLOR, // Replaced AppTheme.primary
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Helper widget for consistent time rows
class _TimeRow extends StatelessWidget {
  final String label;
  final String value;

  const _TimeRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60, // Fixed width for alignment
          child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: GRAY_500) // Replaced AppTheme.gray500
          ),
        ),
        Text(
            value,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: GRAY_700 // Replaced AppTheme.gray700
            )
        ),
      ],
    );
  }
}