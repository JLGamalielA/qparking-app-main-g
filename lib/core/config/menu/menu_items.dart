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
      title: 'Abonar Saldo',
      link: '/add_credit',
      icon: Icons.monetization_on
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