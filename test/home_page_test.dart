import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import 'package:sausage_roll_test/models/basket_item.dart';
import 'package:sausage_roll_test/models/sausage_roll.dart';
import 'package:sausage_roll_test/providers/basket_provider.dart';
import 'package:sausage_roll_test/providers/product_data_provider.dart';
import 'package:sausage_roll_test/screens/home_page.dart';

import 'mocks/basket_provider_test.mocks.dart';
import 'mocks/product_data_provider_test.mocks.dart';

void main() {
  group('Homepage', () {
    final mockProductDataProvider = MockProductDataProvider();
    final mockBasketProvider = MockBasketProvider();

    // Setup mock product data provider
    // when(mockProductDataProvider.fetchProducts()).thenAnswer((_) async => [
    //       SausageRoll(
    //         articleCode: "1000446",
    //         shopCode: "1234",
    //         availableFrom: DateTime.parse("2020-12-30T00:00:00Z"),
    //         availableUntil: DateTime.parse("2045-05-13T23:59:59Z"),
    //         eatOutPrice: 1.05,
    //         eatInPrice: 1.15,
    //         articleName: "Sausage Roll",
    //         dayParts: ["Breakfast", "Lunch", "Evening"],
    //         internalDescription: "Sausage Roll",
    //         customerDescription:
    //             "The Nation’s favourite Sausage Roll.\n\nMuch like Elvis was hailed the King of Rock, many have appointed Greggs as the (unofficial) King of Sausage Rolls.\n\nFreshly baked in our shops throughout the day, this British classic is made from seasoned sausage meat wrapped in layers of crisp, golden puff pastry, as well as a large dollop of TLC. It’s fair to say, we’re proper proud of them.\n\nAnd that’s it. No clever twist. No secret ingredient. It’s how you like them, so that’s how we make them.\n\n",
    //         imageUri:
    //             "https://articles.greggs.co.uk/images/1000446.png?1623244287449",
    //         thumbnailUri:
    //             "https://articles.greggs.co.uk/images/1000446-thumb.png?1623244287450",
    //       ),
    //       SausageRoll(
    //         articleCode: "1446",
    //         shopCode: "1234",
    //         availableFrom: DateTime.parse("2020-12-30T00:00:00Z"),
    //         availableUntil: DateTime.parse("2045-05-13T23:59:59Z"),
    //         eatOutPrice: 1.05,
    //         eatInPrice: 1.15,
    //         articleName: "Sausage Roll",
    //         dayParts: ["Breakfast", "Lunch", "Evening"],
    //         internalDescription: "Sausage Roll",
    //         customerDescription:
    //             "The Nation’s favourite Sausage Roll.\n\nMuch like Elvis was hailed the King of Rock, many have appointed Greggs as the (unofficial) King of Sausage Rolls.\n\nFreshly baked in our shops throughout the day, this British classic is made from seasoned sausage meat wrapped in layers of crisp, golden puff pastry, as well as a large dollop of TLC. It’s fair to say, we’re proper proud of them.\n\nAnd that’s it. No clever twist. No secret ingredient. It’s how you like them, so that’s how we make them.\n\n",
    //         imageUri:
    //             "https://articles.greggs.co.uk/images/1000446.png?1623244287449",
    //         thumbnailUri:
    //             "https://articles.greggs.co.uk/images/1000446-thumb.png?1623244287450",
    //       ),
    //     ]);

    // Stub the products property to return a list of products
    when(mockProductDataProvider.products).thenReturn([
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
      SausageRoll(
        articleCode: "1446",
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
    ]);

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

    // Stub the items property to return a list of items in basket
    // when(mockBasketProvider.groupedItems).thenReturn({
    //   "1000446": [
    //     SausageRoll(
    //       articleCode: "1000446",
    //       shopCode: "1234",
    //       availableFrom: DateTime.parse("2020-12-30T00:00:00Z"),
    //       availableUntil: DateTime.parse("2045-05-13T23:59:59Z"),
    //       eatOutPrice: 1.05,
    //       eatInPrice: 1.15,
    //       articleName: "Sausage Roll",
    //       dayParts: ["Breakfast", "Lunch", "Evening"],
    //       internalDescription: "Sausage Roll",
    //       customerDescription:
    //           "The Nation’s favourite Sausage Roll.\n\nMuch like Elvis was hailed the King of Rock, many have appointed Greggs as the (unofficial) King of Sausage Rolls.\n\nFreshly baked in our shops throughout the day, this British classic is made from seasoned sausage meat wrapped in layers of crisp, golden puff pastry, as well as a large dollop of TLC. It’s fair to say, we’re proper proud of them.\n\nAnd that’s it. No clever twist. No secret ingredient. It’s how you like them, so that’s how we make them.\n\n",
    //       imageUri:
    //           "https://articles.greggs.co.uk/images/1000446.png?1623244287449",
    //       thumbnailUri:
    //           "https://articles.greggs.co.uk/images/1000446-thumb.png?1623244287450",
    //     ),
    //   ],
    // });

    testWidgets('HomePage builds without error', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        // Act
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<ProductDataProvider>(
                create: (_) => mockProductDataProvider,
              ),
              ChangeNotifierProvider<BasketProvider>(
                create: (_) => mockBasketProvider,
              ),
            ],
            child: const MaterialApp(home: HomePage()),
          ),
        );

        // Wait for async data fetch to complete
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(HomePage), findsOneWidget);

        // Click on an itemTile
        final itemTiles = find.byType(ListTile);
        expect(itemTiles,
            findsWidgets); // Ensure that the finder finds one or more widgets
        final itemTile = itemTiles.first;

        await tester.tap(itemTile);
        await tester.pumpAndSettle();
      });
    });

    testWidgets('HomePage with productData error', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        // Setup mock product data provider which returns some error
        when(mockProductDataProvider.fetchProducts()).thenAnswer(
          (_) async => throw Exception('Some error'),
        );
        // Act
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<ProductDataProvider>(
                  create: (_) => mockProductDataProvider),
              ChangeNotifierProvider<BasketProvider>(
                create: (_) => mockBasketProvider,
              ),
            ],
            child: const MaterialApp(home: HomePage()),
          ),
        );

        // Wait for async data fetch to complete
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Error: Exception: Some error'), findsOneWidget);
      });
    });

    testWidgets('basketButton tap', (WidgetTester tester) async {
      // Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<ProductDataProvider>(
                create: (_) => mockProductDataProvider,
              ),
              ChangeNotifierProvider<BasketProvider>(
                create: (_) => mockBasketProvider,
              ),
            ],
            child: const MaterialApp(home: HomePage()),
          ),
        );

        // Wait for async data fetch to complete
        await tester.pumpAndSettle();

        //find basketButton widget
        final basketButton = find.byKey(const Key('basket'));

        await tester.tap(basketButton);
        await tester.pumpAndSettle();
      });
    });
  });
}
