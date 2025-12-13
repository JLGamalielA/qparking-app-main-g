/**
 * Company: CETAM
 * Project: QParking
 * File: activity_screen.dart
 * Created on: 01/12/2025
 * Created by: Rodrigo Peña
 * Approved by: Daniel Yair Mendoza Alvarez
 *
 * Changelog:
 * - ID: 4 | Modified on: 13/12/2025 | Rodrigo Peña | Added bell icon and user initials to AppBar actions.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/icons/app_icons.dart';
import '../../../../../core/widgets/app_icon.dart';
import 'package:qparking/core/constants/constants_exports.dart';
import 'package:qparking/core/widgets/widgets_exports.dart';

// --- MODELO (Definición local) ---
class ActivityModel {
  final String date;
  final String entryTime;
  final String exitTime;
  final String duration;
  final String parkingName;
  final String transactionFolio;
  final double totalAmount;

  ActivityModel({
    required this.date,
    required this.entryTime,
    required this.exitTime,
    required this.duration,
    required this.parkingName,
    required this.transactionFolio,
    required this.totalAmount,
  });
}

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
  ];
});

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(activityListProvider);
    // Iniciales fijas
    const String userInitials = "DM";

    return Scaffold(
      backgroundColor: GRAY_50,

      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const AppIcon(name: AppIconName.back, color: WHITE_COLOR),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Actividad',
          style: TextStyle(
            color: WHITE_COLOR,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        // --- NUEVO: ACCIONES (Campana + Iniciales) ---
        actions: [
          IconButton(
            onPressed: () {},
            icon: const AppIcon(name: AppIconName.bell, color: WHITE_COLOR, size: 22),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 4.0),
            child: InkWell(
              onTap: () => context.push('/profile'),
              borderRadius: BorderRadius.circular(18),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: WHITE_COLOR.withOpacity(0.2), // Transparencia usando constante local
                child: const Text(
                  userInitials,
                  style: TextStyle(
                    color: WHITE_COLOR,
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
        child: activities.isEmpty
            ? _buildEmptyState()
            : ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: activities.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return _ActivityCardWidget(activity: activities[index]);
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          AppIcon(
            name: AppIconName.list,
            size: 64,
            color: GRAY_300,
          ),
          SizedBox(height: 16),
          Text(
            'Sin actividad reciente',
            style: TextStyle(
              fontSize: 18,
              color: GRAY_500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET DE TARJETA ---
class _ActivityCardWidget extends StatelessWidget {
  final ActivityModel activity;

  const _ActivityCardWidget({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: GRAY_200),
        boxShadow: [
          BoxShadow(
            color: PRIMARY_COLOR.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                activity.parkingName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: PRIMARY_COLOR,
                ),
              ),
              Text(
                '\$${activity.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: PRIMARY_COLOR,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            'Folio: ${activity.transactionFolio}',
            style: const TextStyle(
                fontSize: 12,
                color: GRAY_600,
                fontWeight: FontWeight.w500
            ),
          ),

          const Divider(height: 24, color: GRAY_200),

          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: GRAY_400),
              const SizedBox(width: 4),
              Text(
                activity.date,
                style: const TextStyle(fontSize: 13, color: GRAY_600),
              ),

              const SizedBox(width: 16),

              const Icon(Icons.access_time, size: 14, color: GRAY_400),
              const SizedBox(width: 4),
              Text(
                '${activity.entryTime} - ${activity.exitTime}',
                style: const TextStyle(fontSize: 13, color: GRAY_600),
              ),
            ],
          )
        ],
      ),
    );
  }
}