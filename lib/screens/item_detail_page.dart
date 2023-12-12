import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sausage_roll_test/models/sausage_roll.dart';
import 'package:sausage_roll_test/providers/basket_provider.dart';
import 'package:sausage_roll_test/utils/constants.dart';
import 'package:sausage_roll_test/utils/size_config.dart';

class ItemDetailPage extends StatefulWidget {
  final SausageRoll item;
  final int index;

  const ItemDetailPage(this.item, this.index, {Key? key}) : super(key: key);

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  int _counter = 1; // Counter to keep track of quantity.
  bool isEatOut = true; // Flag to determine if the item is for eating out.

  @override
  Widget build(BuildContext context) {
    // Initializing SizeConfig for responsive UI.
    SizeConfig().init(context);
    // Accessing basket data using Provider.
    final basketProvider = Provider.of<BasketProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(16),
              horizontal: getProportionateScreenWidth(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.item.internalDescription,
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(24),
                      fontWeight: FontWeight.w700)),
              SizedBox(height: getProportionateScreenHeight(15)),
              Image.network(widget.item.imageUri),
              SizedBox(height: getProportionateScreenHeight(15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Eat In',
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(10),
                            fontWeight: FontWeight.w500,
                          )),
                      // Switch for selecting eat in or eat out.
                      Transform.scale(
                        scale: 0.75,
                        child: Switch.adaptive(
                          key: const Key('switch'),
                          value: isEatOut,
                          onChanged: (value) {
                            setState(() {
                              isEatOut = value;
                            });
                          },
                        ),
                      ),
                      Text('Eat Out',
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(10),
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Text(
                      isEatOut
                          ? '£${widget.item.eatOutPrice.toStringAsFixed(2)}'
                          : '£${widget.item.eatInPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(18),
                          fontWeight: FontWeight.w500)),
                  Row(
                    children: [
                      IconButton(
                        key: const Key("decrease"),
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (_counter > 1) _counter--;
                          });
                        },
                      ),
                      Text('$_counter',
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(20))),
                      IconButton(
                        key: const Key("increase"),
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            if (_counter < 30) _counter++; //max order to 30
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              Text(widget.item.customerDescription,
                  style: TextStyle(fontSize: getProportionateScreenHeight(16))),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
          height: getProportionateScreenHeight(60),
          color: kButtonColor, // color for the container
          width: getProportionateScreenWidth(430), // Full width of the screen
          child: InkWell(
            key: const Key("addItem"),
            onTap: () {
              // Logic to handle adding items to the basket.
              // Checks if adding items exceeds the basket limit.
              // Displays a snackbar with a message based on the action.
              int totalItemsAfterAdding =
                  basketProvider.getTotalQuantity() + _counter;

              if (totalItemsAfterAdding <= 30) {
                basketProvider.addToBasket(widget.item, _counter, isEatOut);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Added $_counter ${widget.item.articleName} to bag')));
                Navigator.pop(context);
              } else {
                // Show a warning message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                          'Adding these items will exceed the basket limit of 30.')),
                );
              }
            },
            child: const Center(
              child: Text(
                'Add to Bag',
                style: TextStyle(color: kFontColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
