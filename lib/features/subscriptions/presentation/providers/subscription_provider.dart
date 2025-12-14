/**
 * Company: CETAM
 * Project: QParking
 * File: subscription_provider.dart
 * Created on: 13/12/2025
 * Created by: Rodrigo Peña
 * Approved by: Gamaliel Juarez
 *
 * Description: Manages the user's subscription state.
 * By default, it is false (no plan) to force the new logic.
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateProvider to track if the user has an active membership
final hasActivePlanProvider = StateProvider<bool>((ref) => false);