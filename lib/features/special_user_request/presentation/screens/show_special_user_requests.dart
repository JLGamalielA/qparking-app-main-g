/**
 * Company: CETAM
 * Project: QParking
 * File: show_special_user_requests.dart
 * Created on: 13/12/2025
 * Created by: Rodrigo Peña
 * Modified by: Rodrigo Peña
 * Approved by: Gamaliel Juarez
 *
 * Changelog:
 * - ID: 2 | Modified on: 13/12/2025 | Rodrigo Peña | Standardized UI colors, AppBar, and buttons to match AppTheme.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/theme/app_theme.dart';
import 'package:qparking/core/widgets/app_icon.dart';
import 'package:qparking/core/icons/app_icons.dart';

const double _kStandardBorderRadius = 12.0;

class ShowSpecialUserRequests extends StatelessWidget {
  const ShowSpecialUserRequests({super.key});

  @override
  Widget build(BuildContext context) {
    const String userInitials = "DM";

    return Scaffold(
      backgroundColor: AppTheme.gray50,

      // --- HEADER  ---
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const AppIcon(name: AppIconName.back, color: AppTheme.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Mis Solicitudes',
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
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
              child: Column(
                children: const [
                  _RequestCard(
                    userType: 'Proveedor',
                    parkingName: 'Central Parking',
                    status: _ReqStatus.approved,
                  ),
                  SizedBox(height: 16),
                  _RequestCard(
                    userType: 'Taxi',
                    parkingName: 'Plaza Mayor',
                    status: _ReqStatus.rejected,
                  ),
                  SizedBox(height: 16),
                  _RequestCard(
                    userType: 'Proveedor',
                    parkingName: 'Edificio Zafiro',
                    status: _ReqStatus.pending,
                  ),
                ],
              ),
            ),

            // Button
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: AppTheme.white,
                    elevation: 4, // Sombra ligera para destacar sobre el fondo
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_kStandardBorderRadius),
                    ),
                  ),
                  onPressed: () {
                    context.push('/create_special_user_request');
                  },
                  icon: const AppIcon(name: AppIconName.add, color: AppTheme.white),
                  label: const Text(
                    'Crear solicitud',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _ReqStatus { approved, rejected, pending }

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.userType,
    required this.parkingName,
    required this.status,
  });

  final String userType;
  final String parkingName;
  final _ReqStatus status;

  Color _chipBg() {
    switch (status) {
      case _ReqStatus.approved:
        return AppTheme.success.withOpacity(0.15);
      case _ReqStatus.rejected:
        return AppTheme.error.withOpacity(0.15);
      case _ReqStatus.pending:
        return AppTheme.warning.withOpacity(0.15);
    }
  }

  Color _chipFg() {
    switch (status) {
      case _ReqStatus.approved:
        return AppTheme.success;
      case _ReqStatus.rejected:
        return AppTheme.error;
      case _ReqStatus.pending:
        return AppTheme.warning;
    }
  }

  String _chipText() {
    switch (status) {
      case _ReqStatus.approved: return 'Aprobado';
      case _ReqStatus.rejected: return 'No Aprobado';
      case _ReqStatus.pending: return 'Pendiente';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(_kStandardBorderRadius),
        border: Border.all(color: AppTheme.gray200, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tipo de usuario',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.gray500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userType,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.gray50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const AppIcon(name: AppIconName.user, color: AppTheme.primary, size: 20),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(color: AppTheme.gray100, height: 1),
            ),

            Row(
              children: [
                const AppIcon(name: AppIconName.card, size: 16, color: AppTheme.gray400),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    parkingName,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.gray700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _chipBg(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _chipText(),
                style: TextStyle(
                  color: _chipFg(),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}