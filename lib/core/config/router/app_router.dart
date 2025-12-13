/**
 * Company: CETAM
 * Project: QParking
 * File: app_router.dart
 * Created on: 12/12/2025
 * Created by: Rodrigo Peña
 * Approved by: Gamaliel Juarez
 *
 * Changelog:
 * - ID: 1 | Modified on: 12/12/2025 |
 * Modified by: Rodrigo Peña |
 * Description: Removed '/add_credit' route definition. |
 */
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
import 'package:qparking/features/activity/presentation/screens/activity_screen.dart';
import 'package:qparking/features/profile/presentation/screens/profile_screen.dart';
import 'package:qparking/features/special_user_request/presentation/screens/show_special_user_requests.dart';
import 'package:qparking/features/special_user_request/presentation/screens/create_special_user_request.dart';
import 'package:qparking/features/subscriptions/presentation/screens/subscriptions_screen.dart';



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
      /**GoRoute(
        path: '/add_credit',
        builder: (context, state) => const AddCreditScreen(),
      ),
      GoRoute(
        path: '/statistics_screen',
        builder: (context, state) => const StatisticsScreen(),
      ),
      GoRoute(
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
      // Rutas de Solicitudes
      GoRoute(
        path: '/show_requests',
        builder: (context, state) => const ShowSpecialUserRequests(),
      ),
      GoRoute(
        path: '/create_special_user_request',
        builder: (context, state) => const CreateSpecialUserRequest(),
      ),
      GoRoute(
        path: '/subscriptions',
        builder: (context, state) => const SubscriptionsScreen(),
      ),
      GoRoute(
        path: '/bank_card',
        builder: (context, state) => const BankCardScreen(),
      ),
    ],
  );
});