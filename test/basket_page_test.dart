import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:sausage_roll_test/models/basket_item.dart';
import 'package:sausage_roll_test/models/sausage_roll.dart';
import 'package:sausage_roll_test/providers/basket_provider.dart';
import 'package:sausage_roll_test/screens/basket_page.dart';

import 'mocks/basket_provider_test.mocks.dart';

void main() {
  group('BasketPage', () {
    final mockBasketProvider = MockBasketProvider();

    // // Stub the items property to return a list of items in basket
    when(mockBasketProvider.items).thenReturn([
      BasketItem(
          sausageRoll: SausageRoll(
            articleCode: "1000446",
            shopCode: "1234",
            availableFrom: DateTime.parse("2020-12-30T00:00:00Z"),
            availableUntil: DateTime.parse("2045-05-13T23:59:59Z"),
            eatOutPrice: 1.05,
            eatInPrice: 1.15,
            articleName: "Sausage Roll",
            dayParts: ["Breakfast", "Lunch", "Evening"],
            internalDescription: "Sausage Roll",
            customerDescription:
                "The Nation’s favourite Sausage Roll.\n\nMuch like Elvis was hailed the King of Rock, many have appointed Greggs as the (unofficial) King of Sausage Rolls.\n\nFreshly baked in our shops throughout the day, this British classic is made from seasoned sausage meat wrapped in layers of crisp, golden puff pastry, as well as a large dollop of TLC. It’s fair to say, we’re proper proud of them.\n\nAnd that’s it. No clever twist. No secret ingredient. It’s how you like them, so that’s how we make them.\n\n",
            imageUri:
                "https://articles.greggs.co.uk/images/1000446.png?1623244287449",
            thumbnailUri:
                "https://articles.greggs.co.uk/images/1000446-thumb.png?1623244287450",
          ),
          quantity: 1,
          isEatOut: true)
    ]);

    testWidgets('BasketPage builds without error', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<BasketProvider>(
              create: (_) => mockBasketProvider,
            ),
          ],
          child: const MaterialApp(home: BasketPage()),
        ),
      );

      // Assert
      expect(find.byType(BasketPage), findsOneWidget);
    });

    testWidgets('Swipe to dismiss removes item from basket',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider<BasketProvider>(
              create: (_) => mockBasketProvider,
              child: const MaterialApp(home: BasketPage()),
            ),
          ),
        ),
      );

      await tester.pump();

      // Find the Dismissible widget and perform a swipe gesture
      final dismissibleWidget = find.byKey(ValueKey<(String, bool)>((
        mockBasketProvider.items.first.sausageRoll.articleCode,
        mockBasketProvider.items.first.isEatOut
      )));
      await tester.drag(
          dismissibleWidget, const Offset(-500.0, 0.0)); // Swipe to the right
      await tester.pumpAndSettle(); // Allow time for animations to complete
    });

    testWidgets('Remove button removes item from basket',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider<BasketProvider>(
              create: (_) => mockBasketProvider,
              child: const MaterialApp(home: BasketPage()),
            ),
          ),
        ),
      );

      // Find the remove button and perform tap action
      final removeItemButton = find.byKey(const Key('removeItem'));
      await tester.tap(removeItemButton);
    });

    testWidgets('iOS picker selection', (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      // Stub getTotalItemsCountExcludingItem to return an integer
      when(mockBasketProvider
          .getTotalItemsCountExcludingItem(('1000446', true))).thenReturn(5);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider<BasketProvider>(
              create: (_) => mockBasketProvider,
              child: const MaterialApp(home: BasketPage()),
            ),
          ),
        ),
      );
      // Find the picker button and perform tap action
      final pickerButton = find.byKey(const Key('openPicker'));
      await tester.tap(pickerButton);
      await tester.pumpAndSettle();

      // Interact with CupertinoPicker
      await tester.drag(find.byType(CupertinoPicker),
          const Offset(0.0, -32.0 * 3)); // Scroll picker
      await tester.pumpAndSettle();

      // Tap the 'Done' button
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle(); // Process the button tap

      // Assert
      // Verify that the basket provider's method was called with the expected value
      verify(mockBasketProvider.updateItemQuantity(('1000446', true), 3))
          .called(1);

      // Reset the platform after the test
      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets(
        'iOS Shows warning snackbar if adding items exceeds basket limit',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      // Stub getTotalItemsCountExcludingItem to return an integer
      when(mockBasketProvider
          .getTotalItemsCountExcludingItem(('1000446', true))).thenReturn(30);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider<BasketProvider>(
              create: (_) => mockBasketProvider,
              child: const MaterialApp(home: BasketPage()),
            ),
          ),
        ),
      );
      // Find the picker button and perform tap action
      final pickerButton = find.byKey(const Key('openPicker'));
      await tester.tap(pickerButton);
      await tester.pumpAndSettle();

      // Interact with CupertinoPicker
      await tester.drag(find.byType(CupertinoPicker),
          const Offset(0.0, -32.0)); // Scroll picker
      await tester.pumpAndSettle();

      // Tap the 'Done' button
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle(); // Process the button tap

      // Reset the platform after the test
      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('android dropdown selection', (WidgetTester tester) async {
      // Stub getTotalItemsCountExcludingItem to return an integer
      when(mockBasketProvider
          .getTotalItemsCountExcludingItem(('1000446', true))).thenReturn(5);
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider<BasketProvider>(
              create: (_) => mockBasketProvider,
              child: const MaterialApp(home: BasketPage()),
            ),
          ),
        ),
      );

      // find all widgets needed
      final dropdown = find.byKey(const Key('quantityDropdown'));
      //select 5 quantities
      await tester.tap(dropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();
      await tester.pump();
    });

    testWidgets(
        'Android Shows warning snackbar if adding items exceeds basket limit',
        (WidgetTester tester) async {
      // Stub getTotalItemsCountExcludingItem to return an integer
      when(mockBasketProvider
          .getTotalItemsCountExcludingItem(('1000446', true))).thenReturn(30);
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider<BasketProvider>(
              create: (_) => mockBasketProvider,
              child: const MaterialApp(home: BasketPage()),
            ),
          ),
        ),
      );

      // find all widgets needed
      final dropdown = find.byKey(const Key('quantityDropdown'));
      //select 5 quantities
      await tester.tap(dropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();
      await tester.pump();
    });

    testWidgets('paymentMethod selection', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider<BasketProvider>(
              create: (_) => mockBasketProvider,
              child: const MaterialApp(home: BasketPage()),
            ),
          ),
        ),
      );

      // Find the remove button and perform tap action
      final paymentMethodButton = find.byKey(const Key('paymentMethod'));
      await tester.tap(paymentMethodButton);
    });
  });
}
