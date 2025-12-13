/**
 * Company: CETAM
 * Project: QParking
 * File: slide_menu.dart
 * Created on: 12/12/2025
 * Created by: Rodrigo
 * Approved by: Gamaliel Juarez
 *
 * Changelog:
 * - ID: 1 | Modified on: 12/12/2025 |
 * Modified by: Rodrigo
 * Description: Adjusted sublist indices after removing "Add Credit" item. |
 */
import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String link;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.link,
      required this.icon});
}

const List<MenuItem> appMenuItems = [
  MenuItem(
      title: 'Inicio',
      link: '/home',
      icon: Icons.home
  ),
  MenuItem(
      title: 'Escanear Qr',
      link: '/qr_generator',
      icon: Icons.qr_code
  ),

  MenuItem(
      title: 'Suscripción',
      link: '/user_subscription',
      icon: Icons.aod
  ),
  MenuItem(
      title: 'Estadísticos',
      link: '/statistics',
      icon: Icons.bar_chart
  ),
  MenuItem(
      title: 'Finanzas',
      link: '/financial_statistics',
      icon: Icons.monetization_on
  ),
  MenuItem(
      title: 'Solicitudes',
      link: '/show_requests',
      icon: Icons.mail
  ),
  MenuItem(
      title: 'Cerar Sesión',
      link: '/login',
      icon: Icons.logout
  ),
  MenuItem(
      title: 'Tarjeta',
      link: '/bank_card',
      icon: Icons.credit_card
  ),
];