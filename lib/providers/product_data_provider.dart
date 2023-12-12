import 'package:flutter/material.dart';
import 'package:sausage_roll_test/models/sausage_roll.dart';
import 'package:sausage_roll_test/services/mock_api_service.dart';

// Class for providing data related to products (Sausage Rolls).
class ProductDataProvider with ChangeNotifier {
  // Initializing an instance of MockApiService for fetching data.
  final MockApiService apiService = MockApiService();

  // Private list to store the products (Sausage Rolls).
  List<SausageRoll> _products = [];

  // Getter to filter and return only the currently available products.
  List<SausageRoll> get products =>
      _products.where((product) => product.isCurrentlyAvailable()).toList();

  // Asynchronous method to fetch product data.
  Future<void> fetchProducts() async {
    // Checks if the products list is empty before making an API call.
    if (_products.isEmpty) {
      List<Map<String, dynamic>> productData =
          await apiService.fetchSausageRollData();
      _products =
          productData.map((json) => SausageRoll.fromJson(json)).toList();

      // Notifying all listeners about changes in the data.
      notifyListeners();
    }
  }
}
