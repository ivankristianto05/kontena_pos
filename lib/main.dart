import 'package:flutter/material.dart';
import 'package:pos_kontena/Screen/order_screen.dart';
import 'package:pos_kontena/models/cart_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<CartItem> cartItems = [];

  void addItemToCart(CartItem item) {
    setState(() {
      cartItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: OrderPage(
        cartItems: cartItems,
        addItemToCart: addItemToCart,
      ),
    );
  }
}
