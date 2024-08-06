import 'package:flutter/material.dart';
import 'package:pos_kontena/constants.dart';
import 'package:pos_kontena/models/cart_item.dart';

class ItemCart extends StatelessWidget {
  final CartItem item;

  const ItemCart({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // judul menu
          Container(
            child: Text(
              '${item.name} - ${item.variant} (${item.quantity})',
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
          SizedBox(height: 8),
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
          // Menghapus SizedBox di sini
          // edit button
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonselectedcolor,
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              onPressed: () {
                // Edit action
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
  }
}
