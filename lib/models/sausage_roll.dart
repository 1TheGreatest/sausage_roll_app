import 'package:sausage_roll_test/utils/determine_day_part.dart';

// Class representing a Sausage Roll item.
class SausageRoll {
  final String articleCode;
  final String shopCode;
  final DateTime availableFrom;
  final DateTime availableUntil;
  final double eatOutPrice;
  final double eatInPrice;
  final String articleName;
  final List<String> dayParts;
  final String internalDescription;
  final String customerDescription;
  final String imageUri;
  final String thumbnailUri;

  // Constructor for the SausageRoll class.
  SausageRoll({
    required this.articleCode,
    required this.shopCode,
    required this.availableFrom,
    required this.availableUntil,
    required this.eatOutPrice,
    required this.eatInPrice,
    required this.articleName,
    required this.dayParts,
    required this.internalDescription,
    required this.customerDescription,
    required this.imageUri,
    required this.thumbnailUri,
  });

  // Factory constructor to create a SausageRoll object from a JSON map.
  factory SausageRoll.fromJson(Map<String, dynamic> json) {
    return SausageRoll(
      articleCode: json['articleCode'],
      shopCode: json['shopCode'],
      availableFrom: DateTime.parse(json['availableFrom']),
      availableUntil: DateTime.parse(json['availableUntil']),
      eatOutPrice: json['eatOutPrice'],
      eatInPrice: json['eatInPrice'],
      articleName: json['articleName'],
      dayParts: json['dayParts'],
      internalDescription: json['internalDescription'],
      customerDescription: json['customerDescription'],
      imageUri: json['imageUri'],
      thumbnailUri: json['thumbnailUri'],
    );
  }

  // Method to check if the sausage roll is currently available.
  bool isCurrentlyAvailable() {
    DateTime now = DateTime.now();
    String currentDayPart = determineDayPart(now);

    // Return true if the current time is within the availability window and matches a day part.
    return now.isAfter(availableFrom) &&
        now.isBefore(availableUntil) &&
        dayParts.contains(currentDayPart);
  }
}
