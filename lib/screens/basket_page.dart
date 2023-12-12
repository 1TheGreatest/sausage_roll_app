import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sausage_roll_test/models/basket_item.dart';
import 'package:sausage_roll_test/providers/basket_provider.dart';
import 'package:sausage_roll_test/utils/constants.dart';
import 'package:sausage_roll_test/utils/size_config.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initializing SizeConfig for responsive UI.
    SizeConfig().init(context);
    // Accessing the basket data using Provider.
    final basketProvider = Provider.of<BasketProvider>(context);
    // Platform check for adapting UI between Android and iOS.
    final platform = Theme.of(context).platform;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Basket'),
      ),
      body: ListView.builder(
        itemCount: basketProvider.items.length,
        itemBuilder: (context, index) {
          final item = basketProvider.items[index];
          var key = (item.sausageRoll.articleCode, item.isEatOut);

          return Dismissible(
            // Unique key for Dismissible widget.
            key: ValueKey<(String, bool)>(key),
            onDismissed: (direction) {
              // Remove the item from the basket.
              basketProvider.remove(key);
            },
            direction: DismissDirection.endToStart,
            background: Container(
              color: kDismissibleColor,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding:
                        EdgeInsets.only(right: getProportionateScreenWidth(20)),
                    child: const Text(
                      'Remove',
                      style: TextStyle(
                          color: kSecondaryColor, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: getProportionateScreenHeight(121),
                  width: getProportionateScreenWidth(430),
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(12),
                    vertical: getProportionateScreenHeight(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                ' ${item.sausageRoll.articleName} \n Eat Out: ${item.isEatOut ? 'Yes' : 'No'}'),
                            Text(
                              '£${item.totalPrice.toStringAsFixed(2)}',
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              key: const Key("removeItem"),
                              onPressed: () {
                                // Remove the item from the basket.
                                basketProvider.remove(key);
                              },
                              child: const Text("Remove"),
                            ),
                            // Using conditional UI for different platforms (iOS and Android).
                            platform == TargetPlatform.iOS
                                ? GestureDetector(
                                    key: const Key('openPicker'),
                                    onTap: () {
                                      _showCupertinoPicker(
                                          context, basketProvider, key, item);
                                    },
                                    child: Row(
                                      children: [
                                        Text('Quantity: ${item.quantity}'),
                                        const Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                  )
                                : Row(
                                    children: [
                                      const Text('Quantity:'),
                                      SizedBox(
                                          width:
                                              getProportionateScreenWidth(10)),
                                      _showAndroidDropdown(
                                          context, basketProvider, key, item),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: getProportionateScreenHeight(20),
                  color: kDividerColor,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
          height: getProportionateScreenHeight(60),
          color: kButtonColor,
          width: getProportionateScreenWidth(430), // Full width of the screen
          child: InkWell(
            key: const Key("paymentMethod"),
            onTap: () {
              // button action
            },
            child: const Center(
              child: Text(
                'Choose Payment',
                style: TextStyle(color: kFontColor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to show the Cupertino Picker for iOS.
  void _showCupertinoPicker(BuildContext context, BasketProvider basketProvider,
      (String, bool) key, BasketItem item) {
    int selectedQuantity = item.quantity;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          // Implementation of Cupertino Picker with 'Done' button.
          return Container(
            height: getProportionateScreenHeight(310),
            child: Column(
              children: [
                // Toolbar with the Done button
                Container(
                  height: getProportionateScreenHeight(40),
                  color: kModalBottomSheetColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        key: const Key('quantityPicker'),
                        child: const Text('Done'),
                        onPressed: () {
                          int totalItemsAfterChange = basketProvider
                                  .getTotalItemsCountExcludingItem(key) +
                              selectedQuantity;

                          if (totalItemsAfterChange <= 30) {
                            // Update the item quantity in the basket
                            basketProvider.updateItemQuantity(
                                key, selectedQuantity);
                            Navigator.pop(context); // Close modal bottom sheet
                          } else {
                            // Show a warning message
                            showTopSnackBar(
                              Overlay.of(context),
                              const CustomSnackBar.info(
                                message:
                                    'Updating the quantity will exceed the basket limit of 30.',
                                backgroundColor: Color(0xFF323232),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    scrollController: FixedExtentScrollController(
                        initialItem: selectedQuantity - 1),
                    onSelectedItemChanged: (int value) {
                      HapticFeedback.selectionClick(); // Haptic feedback
                      selectedQuantity = value + 1;
                    },
                    children: List<Widget>.generate(30, (int index) {
                      return Center(
                        child: Text('${index + 1}'),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // Widget to show the Android Dropdown for quantity selection.
  Widget _showAndroidDropdown(BuildContext context,
      BasketProvider basketProvider, (String, bool) key, BasketItem item) {
    int selectedQuantity = item.quantity;
    List<DropdownMenuItem<int>> items = List.generate(30, (index) {
      return DropdownMenuItem(
        value: index + 1,
        child: Text('${index + 1}'),
      );
    });

    // Dropdown button implementation for Android.
    return DropdownButton(
      key: const Key("quantityDropdown"),
      menuMaxHeight: getProportionateScreenHeight(200),
      value: selectedQuantity,
      items: items,
      onChanged: (newValue) {
        if (newValue != null) {
          int totalItemsAfterChange =
              basketProvider.getTotalItemsCountExcludingItem(key) + newValue;

          if (totalItemsAfterChange <= 30) {
            // Update the item quantity in the basket
            selectedQuantity = newValue;
            basketProvider.updateItemQuantity(key, selectedQuantity);
          } else {
            // Show a warning message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Updating the quantity will exceed the basket limit of 30.')),
            );
          }
        }
      },
    );
  }
}
