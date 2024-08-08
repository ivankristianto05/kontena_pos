import 'package:flutter/material.dart';
import 'package:kontena_pos/constants.dart';
import 'package:kontena_pos/models/cart_item.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.screenWidth,
    required this.cartItems,
  });

  final double screenWidth;
  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    var buttoncolor2 = buttoncolor;

    // Collect the IDs of the selected menu items
    List<String> selectedItemIds = cartItems.map((item) => item.idMenu.toString()).toList();
    // Calculate the number of selected item IDs
    int numberOfSelectedItemIds = selectedItemIds.length;

    return Container(
      height: 50,
      width: screenWidth * 0.35,
      child: MaterialButton(
        color: buttoncolor2,
        textColor: Colors.white,
        onPressed: () {
          // Handle the action for the order button
        },
        child: Column(
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
      ),
    );
  }
}
