import 'dart:ui';

import 'package:kontena_pos/app_state.dart';

enum CartMode {
  update, // Update the quantity if the item already exists
  add, // Add a new item if it doesn't exist
}

class CartItem {
  final String id;
  final String name;
  String? variant;
  int qty;
  final int price;
  late int totalPrice;
  Map<String, Map<String, dynamic>>? addons;
  final String notes;
  final Map<String, String> preference;
  String? type;
  // final int variantPrice; // Add this field

  CartItem({
    required this.id,
    required this.name,
    this.variant,
    required this.qty,
    required this.price,
    this.addons,
    required this.notes,
    required this.preference,
    this.type,
    // required this.variantPrice, // Add this parameter
  }) {
    totalPrice = qty * price;
  }
}

class Cart {
  List<CartItem> _items = [];
  VoidCallback? _onCartChanged;

  Cart({VoidCallback? onCartChanged}) : _onCartChanged = onCartChanged {
    // Set the initial cart items from AppState
    _items = List.from(AppState.cartItems);
  }

  List<CartItem> get items => List.from(_items);

  void _recalculateTotalPrice() {
    for (var item in _items) {
      item.totalPrice = item.qty * item.price;
    }
  }

  void addItem(CartItem newItem, {CartMode mode = CartMode.add}) {
    // Check if the item with the same ID already exists
    var existingItem = _items.firstWhere(
      (item) => item.id == newItem.id,
      orElse: () => CartItem(
        id: '',
        name: '',
        qty: 0,
        price: 0,
        // itemName: '',
        preference: {},
        addons: {},
        notes: '',
      ),
    );

    if (existingItem.id.isNotEmpty) {
      // Item already exists, update the quantity
      if (mode == CartMode.add) {
        existingItem.qty += newItem.qty;
      } else {
        // Default behavior: Add a new item
        existingItem.qty = newItem.qty;
      }
    } else {
      // Item doesn't exist, add a new item
      _items.add(newItem);
    }

    // / Recalculate total price
    _recalculateTotalPrice();

    // Notify changes
    _onCartChanged?.call();

    // Update app state
    AppState.updateCart(_items);
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);

    // Recalculate total price
    _recalculateTotalPrice();

    // Notify changes
    _onCartChanged?.call();

    // Update app state
    AppState.updateCart(_items);
  }

  void clearCart() {
    _items.clear();

    // Recalculate total price
    _recalculateTotalPrice();

    // Notify changes
    _onCartChanged?.call();

    // Update app state
    AppState.updateCart(_items);
  }

  bool isItemInCart(String itemId) {
    return AppState.cartItems.any((item) => item.id == itemId);
  }

  Map<String, dynamic> getItemCart(String itemName) {
    List<CartItem> data = [];
    Map<String, int> indexes = {};

    int index = 0;
    for (var item in AppState.cartItems) {
      if (item.name == itemName) {
        indexes[item.id] = index;
        data.add(item);
      }
      index++;
    }

    return {"data": data, "index": indexes};

    // return {
    //   "index": indexes,
    //   "data": result
    // }

    // return AppState.cartItems
    //     .where((item) => item.name == itemName)
    //     .toList();
  }

  CartItem getItemByIndex(int index) {
    return AppState.cartItems[index];
  }

  List<CartItem> getAllItemCart() {
    return AppState.cartItems.toList();
  }

  Map<String, dynamic> recapCart() {
    // Summarize quantities and total price based on item names
    Map<String, dynamic> recap = {
      'totalPrice': 0,
      'totalItem': 0,
      'items': {},
    };

    for (var item in AppState.cartItems) {
      recap['totalPrice'] += item.totalPrice;

      if (!recap['items'].containsKey(item.name)) {
        recap['items'][item.name] = {
          'name': item.name,
          'preference': item.preference,
          'totalQty': item.qty,
          'totalPrice': item.totalPrice,
          'notes': item.notes,
          'addon': item.addons,
        };
        recap['totalItem'] += 1;
      } else {
        recap['items'][item.name]['totalQty'] += item.qty;
        recap['items'][item.name]['totalPrice'] += item.totalPrice;
      }
    }

    return recap;
  }
}

String getPreferenceText(Map<String, String> data) {
  // Get the values from the map
  List<String> values = data.values.cast<String>().toList();

  // Join the values into a comma-separated string
  String result = values.join(', ');

  return result;
}
