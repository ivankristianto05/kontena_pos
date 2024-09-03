import 'package:flutter/material.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/constants.dart';
import 'package:kontena_pos/core/functions/cart.dart';
import 'package:intl/intl.dart';
import 'package:kontena_pos/routes/app_routes.dart';
import 'package:provider/provider.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.screenWidth,
    required this.cart,
    required this.guestNameController,
    required this.resetDropdown,
  });

  final double screenWidth;
  final Cart cart;
  final TextEditingController guestNameController;
  final VoidCallback resetDropdown;

  @override
  Widget build(BuildContext context) {
    var buttoncolor2 = buttoncolor;

    return Consumer<AppState>(
      builder: (context, appState, child) {
        // Ensure AppState is initialized
        if (!appState.isInitialized) {
          return Center(child: CircularProgressIndicator());
        }

        int numberOfSelectedItemIds = cart.items.length;

        double totalPrice = cart.items.fold(0.0, (sum, item) {
          double price = (item.variantPrice != 0)
              ? item.variantPrice.toDouble()
              : item.price.toDouble();
          return sum + price * item.qty;
        });

        final NumberFormat currencyFormat = NumberFormat('#,###', 'id_ID');
        String formattedTotalPrice = 'Rp ${currencyFormat.format(totalPrice)}';

        return Container(
          height: 50,
          width: screenWidth * 0.35,
          child: MaterialButton(
            color: buttoncolor2,
            textColor: Colors.white,
            onPressed: () async {
              try {
                await appState.createOrder(
                  guestNameController: guestNameController,
                  resetDropdown: resetDropdown,
                  onSuccess: () {
                    // Navigate back to the OrderScreen immediately after order creation
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.orderScreen,
                    );
                  },
                );
              } catch (e) {
                // Handle any errors that may occur during order creation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
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
