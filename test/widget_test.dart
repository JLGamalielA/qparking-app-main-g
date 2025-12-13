/**
 * Company: CETAM
 * Project: QParking
 * File: widget_test.dart
 * Created on: 12/12/2025
 * Created by: Rodrigo Peña
   * Approved by: Gamaliel Juarez
 *
 * Changelog:
 * - ID: 1 | Modified on: 12/12/2025 |
 * Modified by: Rodrigo Peña |
 * Description: Updated test to use MainApp and ProviderScope. |
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qparking/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MainApp(),
      ),
    );

    // Verificamos que la app arranca (por ahora solo eso)
    expect(find.byType(MainApp), findsOneWidget);
  });
}