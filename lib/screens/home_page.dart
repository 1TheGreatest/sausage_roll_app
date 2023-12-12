import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sausage_roll_test/providers/basket_provider.dart';
import 'package:sausage_roll_test/providers/product_data_provider.dart';
import 'package:sausage_roll_test/screens/basket_page.dart';
import 'package:sausage_roll_test/screens/item_detail_page.dart';
import 'package:sausage_roll_test/utils/constants.dart';
import 'package:sausage_roll_test/utils/size_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initializing SizeConfig for responsive UI.
    SizeConfig().init(context);

    // Accessing product and basket data using Provider.
    final productData = Provider.of<ProductDataProvider>(context);
    final basketProvider = Provider.of<BasketProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Sausage Roll Shop',
          style: TextStyle(color: kSecondaryFontColor),
        ),
        actions: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              IconButton(
                key: const Key('basket'),
                icon: const Icon(Icons.shopping_bag, color: kSecondaryColor),
                onPressed: () {
                  // Navigating to the BasketPage when the basket icon is tapped.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BasketPage(),
                    ),
                  );
                },
              ),
              // Displaying the total quantity in the basket as a notification badge.
              if (basketProvider.getTotalQuantity() != 0)
                Container(
                  width: getProportionateScreenWidth(20),
                  height: getProportionateScreenHeight(20),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: kItemNotificationColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${basketProvider.getTotalQuantity()}',
                    style: const TextStyle(
                        color: kSecondaryFontColor, fontSize: 12),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: productData.fetchProducts(),
          builder: (context, snapshot) {
            // Displaying a loading indicator while the products are being fetched.
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            // Handling errors in fetching products.
            else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            // Displaying the list of products once fetched.
            else {
              return ListView.builder(
                itemCount: productData.products.length,
                itemBuilder: (context, index) {
                  final item = productData.products[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: Image.network(item.thumbnailUri),
                        title: Text(
                          item.articleName,
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(18),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          '£${item.eatOutPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(16),
                          ),
                        ),
                        onTap: () {
                          // Navigating to the ItemDetailPage with the selected item details.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemDetailPage(item, index),
                            ),
                          );
                        },
                      ),
                      const Divider()
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
