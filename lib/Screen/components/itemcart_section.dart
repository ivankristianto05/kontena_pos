import 'package:flutter/material.dart';
import 'package:kontena_pos/Screen/popup/itemeditdialog_section.dart';
import 'package:kontena_pos/constants.dart';
import 'package:kontena_pos/models/cart_item.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';

class ItemCart extends StatelessWidget {
  final List<CartItem> cartItems;
  final double screenWidth;
  final void Function(CartItem editedItem) onEditItem;
  //final void Function(CartItem item) onDeleteItem; // Add callback for delete

  ItemCart({
    required this.cartItems,
    required this.screenWidth,
    required this.onEditItem,
    //required this.onDeleteItem, // Initialize delete callback
  });

  final NumberFormat currencyFormat = NumberFormat('#,###', 'id_ID');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.3,
      child: ListView.separated(
        itemCount: cartItems.length,
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(
            thickness: 3,
          ),
        ),
        itemBuilder: (context, index) {
          final item = cartItems[index];
          final price = (item.variantPrice != 0) ? item.variantPrice : item.price;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menu title
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
                // Menu name - quantity
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${item.name} - ${item.variant} (${item.quantity})',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        'Rp ${currencyFormat.format(price * item.quantity)}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                // Price calculation
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.quantity}x Rp ${currencyFormat.format(price)}',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                // Addons
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Addon:',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      ...item.addons.entries.map((addon) => addon.value
                          ? Text('${addon.key} x1', style: TextStyle(fontSize: 14))
                          : Container()),
                    ],
                  ),
                ),
                // Preference
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Preference:',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      item.preference.isNotEmpty
                          ? Text(item.preference, style: TextStyle(fontSize: 14))
                          : Container(),
                    ],
                  ),
                ),
                // Notes
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notes:',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      item.notes.isNotEmpty
                          ? Text(item.notes, style: TextStyle(fontSize: 14))
                          : Container(),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                // Stack for buttons
                Container(
                  height: 40, // Adjust height as needed
                  child: Stack(
                    children: [
                      // Edit button at bottom left
                      Positioned(
                        bottom: 0,
                        left: 0,
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
                      // Delete button at bottom right
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: redcolor, // Change color to red for delete
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                          onPressed: () {
                            //onDeleteItem(item); // Call delete callback
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
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
