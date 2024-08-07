import 'package:flutter/material.dart';
import 'package:kontena_pos/Screen/popup/itemeditdialog_section.dart';
import 'package:kontena_pos/constants.dart';
import 'package:kontena_pos/models/cart_item.dart';

class ItemCart extends StatelessWidget {
  final List<CartItem> cartItems;
  final double screenWidth;
  final void Function(CartItem editedItem) onEditItem;

  const ItemCart({
    required this.cartItems,
    required this.screenWidth,
    required this.onEditItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.3,
      child: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(height: 16),
                // nama menu - jumlah
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${item.name} - ${item.variant} (${item.quantity})',
                              style: TextStyle(fontSize: 14),
                              maxLines: 2, // Set maximum number of lines
                              overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                            ),
                          ),
                          Text(
                            'Rp ${item.price * item.quantity}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                // perhitungan harga
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.quantity}x Rp ${item.price}',
                        style: TextStyle(fontSize: 12),
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
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                SizedBox(height: 8),
                // preference
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Preference:',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        item.preference,
                        style: TextStyle(fontSize: 14),
                      ),
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
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        item.notes,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
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
