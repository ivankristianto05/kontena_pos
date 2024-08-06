import 'dart:ui';

import 'package:kontena_pos/app_state.dart';

class CartItem {
  final String id;
  final String name;
  final String itemName;
  int qty;
  final Map<String, String> preference;
  final int price;
  late int totalPrice;
  String? notes;
  Map<String, Map<String, dynamic>>? addon;

  CartItem({
    required this.id,
    required this.name,
    required this.itemName,
    required this.qty,
    required this.preference,
    required this.price,
    this.notes,
    this.addon,
  }) {
    totalPrice = qty * price;
  }
}

class Cart {
  List<CartItem> _items = [];
  VoidCallback? _onCartChanged; // Callback to notify changes
  // CartVoucher _usedVoucher = CartVoucher(
  //   id: "",
  //   name: "",
  //   totalDiscount: 0,
  //   voucher: {}, // You can provide default values for voucher as well
  // );
  bool isVoucherCanUse = false;

  Cart({VoidCallback? onCartChanged}) : _onCartChanged = onCartChanged {
    // Set the initial cart items from AppState
    _items = List.from(AppState.cartItems);
  }

  List<CartItem> get items => List.from(_items);
}
