import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/constants.dart';
import 'package:intl/intl.dart';
import 'package:kontena_pos/routes/app_routes.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.screenWidth,
    required this.guestNameController,
    required this.resetDropdown,
  });

  final double screenWidth;
  final TextEditingController guestNameController;
  final VoidCallback resetDropdown;

  @override
  Widget build(BuildContext context) {
    var buttoncolor2 = buttoncolor;

    return Consumer<AppState>(
      builder: (context, appState, child) {
        double totalPrice = appState.totalPrice;

        if (!appState.isInitialized) {
          return Center(child: CircularProgressIndicator());
        }
        int numberOfSelectedItemIds = appState.cartItems.length;
        final NumberFormat currencyFormat = NumberFormat('#,###', 'id_ID');
        String formattedTotalPrice = 'Rp ${currencyFormat.format(totalPrice)}';

        return Container(
          height: 50,
          width: screenWidth * 0.35,
          child: MaterialButton(
            color: buttoncolor2,
            textColor: Colors.white,
            onPressed: () async {
              if (guestNameController.text.isEmpty ||
                  appState.cartItems.isEmpty) {
                String errorMessage = guestNameController.text.isEmpty
                    ? 'Nama pemesan tidak boleh kosong!'
                    : 'Item keranjang tidak boleh kosong!';
                // Tampilkan pesan error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 1),
                  ),
                );
                return;
              }
              try {
                await appState.createOrder(
                  guestNameController: guestNameController,
                  resetDropdown: resetDropdown,
                  onSuccess: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.orderScreen,
                    );
                  },
                );
              } catch (e) {
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