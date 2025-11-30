import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qparking/core/constants/constants_exports.dart';
import 'package:qparking/core/icons/app_icons.dart';
import 'package:qparking/core/widgets/app_icon.dart';

class ShowSpecialUserRequests extends StatelessWidget {
  const ShowSpecialUserRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      appBar: AppBar(
        backgroundColor: WHITE_COLOR,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Mis Solicitudes',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: SECONDARY_COLOR,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
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
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    foregroundColor: WHITE_COLOR,
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 6,
                  ),
                  onPressed: () {
                    context.push('/create_special_user_request');
                  },
                  icon: AppIcon(name: AppIconName.add),
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
        return SUCCESS_COLOR.withOpacity(0.18);
      case _ReqStatus.rejected:
        return DANGER_COLOR.withOpacity(0.18);
      case _ReqStatus.pending:
        return WARNING_COLOR.withOpacity(0.22);
    }
  }

  Color _chipFg() {
    switch (status) {
      case _ReqStatus.approved:
        return SUCCESS_COLOR;
      case _ReqStatus.rejected:
        return DANGER_COLOR;
      case _ReqStatus.pending:
        return WARNING_COLOR;
    }
  }

  String _chipText() {
    switch (status) {
      case _ReqStatus.approved:
        return 'Aprobado';
      case _ReqStatus.rejected:
        return 'No Aprobado';
      case _ReqStatus.pending:
        return 'Pendiente';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: SECONDARY_COLOR.withOpacity(0.18), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppIcon(name: AppIconName.user),
                const SizedBox(width: 16),
                const Text(
                  'Tipo de usuario',
                  style: TextStyle(
                    fontSize: 16,
                    color: SECONDARY_COLOR,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              userType,
              style: const TextStyle(
                fontSize: 22,
                color: SECONDARY_COLOR,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 14),
            Container(height: 1, color: SECONDARY_COLOR.withOpacity(0.18)),
            const SizedBox(height: 14),
            Row(
              children: [
                _CircleLetter(letter: 'P'),
                const SizedBox(width: 16),
                const Text(
                  'Estacionamiento',
                  style: TextStyle(
                    fontSize: 16,
                    color: SECONDARY_COLOR,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              parkingName,
              style: const TextStyle(
                fontSize: 22,
                color: SECONDARY_COLOR,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 14),
            Container(height: 1, color: SECONDARY_COLOR.withOpacity(0.18)),
            const SizedBox(height: 14),
            const Text(
              'Estado',
              style: TextStyle(
                fontSize: 16,
                color: SECONDARY_COLOR,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _chipBg(),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Text(
                _chipText(),
                style: TextStyle(
                  color: _chipFg(),
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: PRIMARY_COLOR.withOpacity(0.08),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 24, color: PRIMARY_COLOR),
    );
  }
}

class _CircleLetter extends StatelessWidget {
  const _CircleLetter({required this.letter});
  final String letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: PRIMARY_COLOR.withOpacity(0.08),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}
