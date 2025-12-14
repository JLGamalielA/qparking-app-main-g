/**
 * Company: CETAM
 * Project: QParking
 * File: app_router.dart
 * Created on: 12/12/2025
 * Created by: Rodrigo Peña
 * Approved by: Gamaliel Juarez
 *
 * Changelog:
 * - ID: 1 | 12/12/2025 | Rodrigo Peña | Removed '/add_credit' route.
 * - ID: 2 | 13/12/2025 | Rodrigo Peña | Implemented redirection logic for mandatory subscriptions.
 * - ID: 3 | 13/12/2025 | Rodrigo Peña | Standardized imports and English comments.
 */
library;

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// --- Feature Exports (Barrel Files) ---
import '../../../features/auth/auth_exports.dart';
import '../../../features/home/home_exports.dart';
import '../../../features/qr_generator/qr_generator_exports.dart';
import '../../../features/activity/activity_exports.dart';
import '../../../features/bank_card/bank_card_exports.dart';
import '../../../features/profile/profile_exports.dart';
import '../../../features/special_user_request/special_user_request_exports.dart';
import '../../../features/subscriptions/subscriptions_exports.dart';

// Global Router Provider
final appRouterProvider = Provider<GoRouter>((ref) {

  // Listen to the user's subscription status
  final hasPlan = ref.watch(hasActivePlanProvider);

  return GoRouter(
    initialLocation: '/login',

    // --- REDIRECT LOGIC ---
    // Forces users without a plan to the Subscriptions screen after login
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == '/login';
      final isRegistering = state.matchedLocation == '/register';

      // Allow access to authentication screens
      if (isLoggingIn || isRegistering) return null;

      // Check if user is currently in the subscription/payment flow
      final isOnSubscriptionFlow = state.matchedLocation == '/subscriptions' ||
          state.matchedLocation == '/bank_card';

      // If user is logged in but HAS NO PLAN, force redirect to Subscriptions
      if (!hasPlan && !isOnSubscriptionFlow) {
        return '/subscriptions';
      }

      // No redirection needed for active subscribers
      return null;
    },

    routes: [
      // --- Authentication Routes ---
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // --- Main Application Routes ---
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
        path: '/activity',
        builder: (context, state) => const ActivityScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      // --- Special User Request Routes ---
      GoRoute(
        path: '/show_requests',
        builder: (context, state) => const ShowSpecialUserRequests(),
      ),
      GoRoute(
        path: '/create_special_user_request',
        builder: (context, state) => const CreateSpecialUserRequest(),
      ),

      // --- Subscription & Payment Routes ---
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