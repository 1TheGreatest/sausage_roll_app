import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:sausage_roll_test/main.dart';

void main() {
  // Test MyApp widget
  testWidgets('MyApp builds with MaterialApp and Providers',
      (WidgetTester tester) async {
    await mockNetworkImages(() async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      //Wait for async data fetch to complete
      await tester.pumpAndSettle();

      // Verify MyApp contains a MaterialApp
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
