import 'package:flutter/material.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/constants.dart';
import 'package:kontena_pos/core/functions/cart.dart';
import 'package:intl/intl.dart';
import 'package:kontena_pos/models/list_to_confirm.dart';
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
          // Simpan data ke dalam order hanya ketika tombol ditekan
          final order = ListToConfirm(
            idOrder: 'order_${DateTime.now().millisecondsSinceEpoch}',
            namaPemesan: 'Ivan Kristianto', // Ganti sesuai dengan input pengguna
            table: 'Table 1', // Ganti sesuai dengan input pengguna
            items: List.from(cart.items), // Salin item dari cart ke order
          );

          // Simpan atau kirimkan order, misalnya menggunakan provider atau setState
          Provider.of<AppState>(context, listen: false).addOrder(order);

          // Tampilkan notifikasi atau pindah halaman
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Order berhasil dikirim!'),
            ),
          );
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
  }
}
