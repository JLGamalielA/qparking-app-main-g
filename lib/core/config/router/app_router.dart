/// Company: CETAM
/// Project: QParking
/// File: app_router.dart
/// Created on: 15/11/2025
/// Created by: Daniel Mendoza
/// Approved by: Daniel Mendoza
///
/// Changelog:
/// - ID: 1 | Modified on: 27/11/2025 |
/// Modified by: Gamaliel Alejandro Juarez |
/// Description: Configuration of application routes |
library;

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/auth/presentation/screens/login_screen.dart';
import '../../../features/auth/presentation/screens/user_type_screen.dart';
import '../../../features/auth/presentation/screens/register/register_normal_user_screen.dart';
import '../../../features/auth/presentation/screens/register/register_special_user_screen.dart';
import '../../../features/home/presentation/screens/home_screen.dart';
import '../../../features/qr_generator/presentation/screens/qr_generator_screen.dart';
import '../../../features/add_credit/presentation/screens/add_credit_screen.dart';
import '../../../features/statistics/presentation/screens/statistics_screen.dart';
import '../../../features/profile/presentation/screens/profile_screen.dart';
import '../../../features/activity/activity_exports.dart';
import '../../../features/bank_card/bank_card_exports.dart';



// Provider global del router
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      // --- Auth Routes ---
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/user_type',
        builder: (context, state) => const UserTypeScreen(),
      ),
      GoRoute(
        path: '/register_normal_user',
        builder: (context, state) => const RegisterNormalUserScreen(),
      ),
      GoRoute(
        path: '/register_special_user',
        builder: (context, state) => const RegisterSpecialUserScreen(),
      ),

      // --- Home Route ---
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),

      // --- Feature Routes ---
      GoRoute(
        path: '/qr_generator',
        builder: (context, state) => const QrGeneratorScreen(),
      ),
      GoRoute(
        path: '/add_credit',
        builder: (context, state) => const AddCreditScreen(),
      ),
      GoRoute(
        path: '/statistics_screen',
        builder: (context, state) => const StatisticsScreen(),
      ),
      /*GoRoute(
        path: '/statistics',
        builder: (context, state) => const StatisticsScreen(),
      ),

       */
      GoRoute(
        path: '/activity',
        builder: (context, state) => const ActivityScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/bank_card',
        builder: (context, state) => const BankCardScreen(),
      ),
    ],
  );
});