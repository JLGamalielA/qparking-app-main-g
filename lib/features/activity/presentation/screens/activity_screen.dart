/**
 * Company: CETAM
 * Project: QParking
 * File: activity_screen.dart
 * Created on: 01/12/2025
 * Created by: Flutter Assistant
 * Approved by: Daniel Yair Mendoza Alvarez
 *
 * Changelog:
 * - ID: 1 | Modified on: 01/12/2025 |
 * Modified by: Flutter Assistant |
 * Description: Screen displaying activity history with mock data. |
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/widgets/app_icon.dart';
import '../../../../../core/icons/app_icons.dart';
import '../../data/activity_model.dart';
import '../widgets/activity_card_widget.dart';

// Mock Data Provider
final activityListProvider = Provider<List<ActivityModel>>((ref) {
  return [
    ActivityModel(
      date: '01/12/2025',
      entryTime: '14:30',
      exitTime: '15:15',
      duration: '45 min',
      parkingName: 'Plaza Central',
      transactionFolio: 'TX-987654',
      totalAmount: 45.00,
    ),
    ActivityModel(
      date: '30/11/2025',
      entryTime: '09:15',
      exitTime: '13:30',
      duration: '4h 15m',
      parkingName: 'Estacionamiento Norte',
      transactionFolio: 'TX-987111',
      totalAmount: 120.50,
    ),
    ActivityModel(
      date: '28/11/2025',
      entryTime: '18:45',
      exitTime: '19:45',
      duration: '1h 00m',
      parkingName: 'Centro Sur',
      transactionFolio: 'TX-986000',
      totalAmount: 30.00,
    ),
    ActivityModel(
      date: '25/11/2025',
      entryTime: '08:00',
      exitTime: '18:00',
      duration: '10h 00m',
      parkingName: 'Torre Empresarial',
      transactionFolio: 'TX-985555',
      totalAmount: 250.00,
    ),
  ];
});

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(activityListProvider);

    return Scaffold(
      backgroundColor: AppTheme.gray50,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const AppIcon(name: AppIconName.back, color: AppTheme.primary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Actividad',
          style: TextStyle(
            color: AppTheme.primary,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: activities.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: activities.length,
          itemBuilder: (context, index) {
            return ActivityCardWidget(activity: activities[index]);
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon(
            name: AppIconName.list,
            size: 64,
            color: AppTheme.gray300,
          ),
          const SizedBox(height: 16),
          const Text(
            'Sin actividad reciente',
            style: TextStyle(
              fontSize: 18,
              color: AppTheme.gray500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}