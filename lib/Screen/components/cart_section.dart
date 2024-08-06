// cart.dart
import 'package:flutter/material.dart';
import 'package:pos_kontena/Screen/components/itemcart_section.dart';
import 'package:pos_kontena/models/cart_item.dart';

class Cart extends StatelessWidget {
  final double screenWidth;
  final List<CartItem> cartItems;

  const Cart({Key? key, required this.screenWidth, required this.cartItems}) : super(key: key);

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
                return ItemCart(item: item);
              },
            ),
    );
  }
}
