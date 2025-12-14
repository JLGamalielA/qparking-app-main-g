/**
 * Company: CETAM
 * Project: QParking
 * File: subscriptions_exports.dart
 * Created on: 13/12/2025
 * Created by: Rodrigo Peña
 * Approved by: Gamaliel Juarez
 *
 * Description: Barrel file to centralize all subscription-related exports.
 * Includes the Subscriptions screen and the mandatory redirect logic providers.
 */

// Exporting Main Screens
export 'presentation/screens/subscriptions_screen.dart';

// Note: BankCardScreen is now handled in its own feature folder bank_card/
// as per your updated app_router.dart logic.

// Exporting Providers for global access
export 'presentation/providers/subscription_provider.dart';