import 'package:flutter/material.dart';
import 'package:kontena_pos/models/cart_item.dart';
import 'itemcart_section.dart';

class Cart extends StatelessWidget {
  final double screenWidth;
  final List<CartItem> cartItems;
  final void Function(CartItem editedItem) onEditItem;

  const Cart({
    Key? key,
    required this.screenWidth,
    required this.cartItems,
    required this.onEditItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.35,
      color: Colors.white,
      child: cartItems.isEmpty
          ? Center(child: Text('No item yet', style: TextStyle(fontSize: 18, color: Colors.grey)))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ItemCart(
                    cartItems: [item],
                    screenWidth: screenWidth,
                    onEditItem: onEditItem,
                  ),
                );
              },
            ),
    );
  }
}
