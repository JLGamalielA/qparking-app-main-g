/**
 * Company: CETAM
 * Project: QParking
 * File: activity_model.dart
 * Created on: 01/12/2025
 * Created by: Flutter Assistant
 * Approved by: Daniel Yair Mendoza Alvarez
 *
 * Changelog:
 * - ID: 1 | Modified on: 01/12/2025 |
 * Modified by: Flutter Assistant |
 * Description: Data model for activity transactions. |
 */
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