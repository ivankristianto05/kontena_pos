import 'package:flutter/material.dart';
import 'package:kontena_pos/Screen/popup/itemeditdialog_section.dart';
import 'package:kontena_pos/constants.dart';
import 'package:kontena_pos/core/functions/cart.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';
import 'package:kontena_pos/app_state.dart'; // Import the AppState

class ItemCart extends StatelessWidget {
  final List<CartItem> cartItems;
  final double screenWidth;
  final void Function(CartItem editedItem) onEditItem;
  final AppState appState; // Add this line to include appState
  final Cart cart; // Add this line to include the cart

  ItemCart({
    required this.cartItems,
    required this.screenWidth,
    required this.onEditItem,
    required this.appState, // Add this line to require appState
    required this.cart, // Add this line to require cart
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
          child: Divider(thickness: 3),
        ),
        itemBuilder: (context, index) {
          final item = cartItems[index];
          final price = item.variantPrice != 0 ? item.variantPrice : item.price;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menu title
                Text(
                  '${item.name} - (${item.qty})',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${item.name} - ${item.variant ?? ''} (${item.qty})',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'Rp ${currencyFormat.format(price * item.qty)}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                // Price calculation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item.qty}x Rp ${currencyFormat.format(price)}',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // Addons
                if (item.addons != null && item.addons!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Addons:',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      ...item.addons!.entries.map((addon) => addon
                                  .value['selected'] ==
                              true
                          ? Text('${addon.key}', style: TextStyle(fontSize: 14))
                          : Container()),
                    ],
                  ),
                // Preference
                if (item.preference['preference'] != null &&
                    item.preference['preference']!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Preference:',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(item.preference['preference']!,
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),

                // Notes
                if (item.notes.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notes:',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(item.notes, style: TextStyle(fontSize: 14)),
                    ],
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
                                appState: appState, // Pass the AppState here
                                cart: cart, // Pass the cart here
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
                            backgroundColor:
                                redcolor, // Change color to red for delete
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                          onPressed: () {
                            cart.removeItem(item); // Call delete function
                            appState.update(() {
                              appState.cartItems.remove(item); // Remove from appState
                            });
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white, fontSize: 14),
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