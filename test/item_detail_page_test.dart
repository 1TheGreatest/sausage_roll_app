import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import 'package:sausage_roll_test/models/basket_item.dart';
import 'package:sausage_roll_test/models/sausage_roll.dart';
import 'package:sausage_roll_test/providers/basket_provider.dart';
import 'package:sausage_roll_test/screens/item_detail_page.dart';

import 'mocks/basket_provider_test.mocks.dart';

void main() {
  group('ItemDetailPage', () {
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

    // Stub the items property to return a list of items in basket
    when(mockBasketProvider.getTotalQuantity()).thenReturn(1);

    testWidgets('ItemDetailPage builds without error',
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        // Act
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<BasketProvider>(
                create: (_) => mockBasketProvider,
              ),
            ],
            child: MaterialApp(
                home: ItemDetailPage(
              SausageRoll(
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
              0,
            )),
          ),
        );

        // Wait for async data fetch to complete
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(ItemDetailPage), findsOneWidget);
      });
    });

    testWidgets('tapping on switch toggle', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        // Act
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<BasketProvider>(
                create: (_) => mockBasketProvider,
              ),
            ],
            child: MaterialApp(
                home: ItemDetailPage(
              SausageRoll(
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
              0,
            )),
          ),
        );

        // Wait for async data fetch to complete
        await tester.pumpAndSettle();

        //find basketButton widget
        final switchButton = find.byKey(const Key('switch'));
        await tester.tap(switchButton);
        await tester.pumpAndSettle();
      });
    });

    testWidgets('increase counter', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        // Act
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<BasketProvider>(
                create: (_) => mockBasketProvider,
              ),
            ],
            child: MaterialApp(
                home: ItemDetailPage(
              SausageRoll(
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
              0,
            )),
          ),
        );

        // Wait for async data fetch to complete
        await tester.pumpAndSettle();

        //find basketButton widget
        final increaseButton = find.byKey(const Key('increase'));
        await tester.tap(increaseButton);
      });
    });

    testWidgets('decrease counter', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        // Act
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<BasketProvider>(
                create: (_) => mockBasketProvider,
              ),
            ],
            child: MaterialApp(
                home: ItemDetailPage(
              SausageRoll(
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
              0,
            )),
          ),
        );

        // Wait for async data fetch to complete
        await tester.pumpAndSettle();

        //find basketButton widget
        final decreaseButton = find.byKey(const Key('decrease'));
        await tester.tap(decreaseButton);
      });
    });

    testWidgets('add item', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        // Act
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<BasketProvider>(
                create: (_) => mockBasketProvider,
              ),
            ],
            child: MaterialApp(
                home: ItemDetailPage(
              SausageRoll(
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
              0,
            )),
          ),
        );

        // Wait for async data fetch to complete
        await tester.pumpAndSettle();

        //find basketButton widget
        final addItemButton = find.byKey(const Key('addItem'));
        await tester.tap(addItemButton);
      });
    });

    testWidgets('Shows warning snackbar if adding items exceeds basket limit',
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        // Stub the items property to return a list of items in basket
        when(mockBasketProvider.getTotalQuantity()).thenReturn(30);
        // Act
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<BasketProvider>(
                create: (_) => mockBasketProvider,
              ),
            ],
            child: MaterialApp(
                home: ItemDetailPage(
              SausageRoll(
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
              0,
            )),
          ),
        );

        await tester.pumpAndSettle();

        // Trigger the tap
        final addItemButton = find.byKey(const Key('addItem'));
        await tester.tap(addItemButton);
        await tester.pump(); // Rebuild the widget to show the snackbar

        // Assert
        expect(find.byType(SnackBar), findsOneWidget);
        expect(
          find.text('Adding these items will exceed the basket limit of 30.'),
          findsOneWidget,
        );
      });
    });
  });
}
