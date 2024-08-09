import 'package:flutter/material.dart';
import 'package:kontena_pos/Screen/popup/itemeditdialog_section.dart';
import 'package:kontena_pos/constants.dart';
import 'package:kontena_pos/models/cart_item.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart'; // Import intl package

class ItemCart extends StatelessWidget {
  final List<CartItem> cartItems;
  final double screenWidth;
  final void Function(CartItem editedItem) onEditItem;

  ItemCart({
    required this.cartItems,
    required this.screenWidth,
    required this.onEditItem,
  });

  // Create a NumberFormat instance for Indonesian locale
  final NumberFormat currencyFormat = NumberFormat('#,###', 'id_ID');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.3,
      child: ListView.separated(
        itemCount: cartItems.length,
        separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0), // Adjust the vertical padding
            child: Divider(
              thickness: 3,
            )),
        itemBuilder: (context, index) {
          final item = cartItems[index];
          final price = (item.variantPrice != 0) ? item.variantPrice : item.price;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // judul menu
                Container(
                  child: Text(
                    '${item.name} - (${item.quantity})',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DottedLine(
                    dashColor: Colors.grey,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashGapLength: 4.0,
                  ),
                ),
                // nama menu - jumlah
                Container(
                  // padding: EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${item.name} - ${item.variant} (${item.quantity})',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              maxLines: 2, // Set maximum number of lines
                              overflow: TextOverflow
                                  .ellipsis, // Handle overflow with ellipsis
                            ),
                          ),
                          Text(
                            'Rp ${currencyFormat.format(price * item.quantity)}', // Format price with thousands separator
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                // perhitungan harga
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.quantity}x Rp ${currencyFormat.format(price)}', // Format price with thousands separator
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                // add on
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Addon:',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      ...item.addons.entries.map((addon) => addon.value
                          ? Text(
                              '${addon.key} x1',
                              style: TextStyle(fontSize: 14),
                            )
                          : Container()),
                    ],
                  ),
                ),
                //SizedBox(height: 8),
                // preference
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Preference:',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      item.preference.isNotEmpty
                          ? Text(
                              item.preference,
                              style: TextStyle(fontSize: 14),
                            )
                          : Container(), // If preference is empty, display an empty container
                    ],
                  ),
                ),
                // note
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notes:',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      item.notes.isNotEmpty
                          ? Text(
                              item.notes,
                              style: TextStyle(fontSize: 14),
                            )
                          : Container(), // If notes are empty, display an empty container
                    ],
                  ),
                ),
                SizedBox(height: 8),
                // edit button
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonselectedcolor,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ItemEditDialog(
                          item: item,
                          onEdit: (editedItem) {
                            onEditItem(editedItem);
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
