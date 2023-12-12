import 'package:sausage_roll_test/models/sausage_roll.dart';

// Class representing an item in the basket.
class BasketItem {
  final SausageRoll sausageRoll;
  int quantity;
  final bool isEatOut;

  // Constructor for the BasketItem class.
  BasketItem({
    required this.sausageRoll,
    required this.quantity,
    required this.isEatOut,
  });

  // Computed property to get the total price of the basket item.
  double get totalPrice => isEatOut
      ? sausageRoll.eatOutPrice * quantity
      : sausageRoll.eatInPrice * quantity;
}
