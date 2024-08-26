import 'package:flutter/material.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/constants.dart';
import 'package:kontena_pos/core/functions/cart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';  // Import Provider

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.screenWidth,
    required this.cart,
  });

  final double screenWidth;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    var buttoncolor2 = buttoncolor;

    return Consumer<AppState>(
      builder: (context, appState, child) {
        // Calculate the number of selected item IDs
        int numberOfSelectedItemIds = cart.items.length;

        // Calculate the total price of all items in the cart
        double totalPrice = cart.items.fold(0.0, (sum, item) {
          double price = (item.variantPrice != 0) ? item.variantPrice.toDouble() : item.price.toDouble();
          return sum + price * item.qty;
        });

        // Format the total price to the appropriate currency format
        final NumberFormat currencyFormat = NumberFormat('#,###', 'id_ID');
        String formattedTotalPrice = 'Rp ${currencyFormat.format(totalPrice)}';

        return Container(
          height: 50,
          width: screenWidth * 0.35,
          child: MaterialButton(
            color: buttoncolor2,
            textColor: Colors.white,
            onPressed: () {
              // Call createOrder on AppState, which handles the order creation
              appState.createOrder(); // Ensure this method is properly defined in AppState
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Order",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "$numberOfSelectedItemIds - Item",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  formattedTotalPrice,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}