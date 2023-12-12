import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sausage_roll_test/models/basket_item.dart';
import 'package:sausage_roll_test/models/sausage_roll.dart';

// A provider class for managing basket items, extending ChangeNotifier for state management.
class BasketProvider with ChangeNotifier {
  // Private list to hold BasketItem objects.
  final List<BasketItem> _items = [];

  // Method to add an item to the basket.
  void addToBasket(SausageRoll item, int quantity, bool isEatOut) {
    // Check if the item already exists with the same isEatOut preference
    BasketItem? existingItem = _items.firstWhereOrNull(
      (basketItem) =>
          basketItem.sausageRoll.articleCode == item.articleCode &&
          basketItem.isEatOut == isEatOut,
    );

    if (existingItem != null) {
      // Update quantity if item already exists
      existingItem.quantity += quantity;
    } else {
      // Add new item
      _items.add(BasketItem(
          sausageRoll: item, quantity: quantity, isEatOut: isEatOut));
    }

    notifyListeners();
  }

  // Getter to return a list of basket items.
  List<BasketItem> get items => _items;

  // Method to calculate the total quantity of items in the basket.
  int getTotalQuantity() {
    int totalQuantity = 0;
    for (var item in _items) {
      totalQuantity += item.quantity;
    }
    return totalQuantity;
  }

  // Method to update the quantity of a specific item in the basket.
  void updateItemQuantity((String, bool) key, int newQuantity) {
    BasketItem matchingItem = _items.firstWhere((item) =>
        (item.sausageRoll.articleCode == key.$1 && item.isEatOut == key.$2));

    matchingItem.quantity = newQuantity;

    notifyListeners();
  }

  // Method to get the total count of items excluding a specific item.
  int getTotalItemsCountExcludingItem((String, bool) key) {
    int totalCount = 0;
    List<BasketItem> unmatchingItems = _items
        .where(
          (item) => (item.sausageRoll.articleCode != key.$1 ||
              (item.sausageRoll.articleCode == key.$1 &&
                  item.isEatOut != key.$2)),
        )
        .toList();

    for (var item in unmatchingItems) {
      totalCount += item.quantity;
    }
    return totalCount;
  }

  // Method to remove a specific item from the basket.
  void remove((String, bool) key) {
    _items.removeWhere((item) =>
        item.sausageRoll.articleCode == key.$1 && item.isEatOut == key.$2);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }

  // Computed property to get the grand total price of all items in the basket.
  double get grandTotalPrice =>
      _items.fold(0, (total, current) => total + current.totalPrice);
}
