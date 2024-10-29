import 'dart:ui';

import 'package:kontena_pos/app_state.dart';

enum OrderCartMode {
  update, // Update the quantity if the item already exists
  add, // Add a new item if it doesn't exist
}

class OrderCartItem {
  final String id;
  final String name;
  final String itemName;
  final String itemGroup;
  final String uom;
  final String description;
  int qty;
  final Map<String, String> preference;
  final int price;
  late int totalPrice;
  String? notes;
  Map<String, Map<String, dynamic>>? addon;
  bool? status;

  OrderCartItem({
    required this.id,
    required this.name,
    required this.itemName,
    required this.itemGroup,
    required this.qty,
    required this.preference,
    required this.price,
    required this.uom,
    required this.description,
    this.notes,
    this.addon,
    this.status,
  }) {
    totalPrice = qty * price;
  }
}

class OrderCart {
  List<OrderCartItem> _items = [];
  VoidCallback? _onCartChanged;
  OrderCart({VoidCallback? onCartChanged}) : _onCartChanged = onCartChanged {
    // Set the initial cart items from AppState
    _items = List.from(AppState.orderCartItems);
  }

  List<OrderCartItem> get items => List.from(_items);

  void _recalculateTotalPrice() {
    for (var item in _items) {
      item.totalPrice = item.qty * item.price;
    }
  }

  void addItem(OrderCartItem newItem,
      {OrderCartMode mode = OrderCartMode.add}) {
    // Check if the item with the same ID already exists
    var existingItem = _items.firstWhere(
      (item) => item.id == newItem.id,
      orElse: () => OrderCartItem(
        id: '',
        name: '',
        qty: 0,
        price: 0,
        itemName: '',
        itemGroup: '',
        preference: {},
        addon: {},
        notes: '',
        uom: '',
        description: '',
        status: false,
      ),
    ); // Return an empty CartItem if not found

    if (existingItem.id.isNotEmpty) {
      // Item already exists, update the quantity
      if (mode == OrderCartMode.add) {
        existingItem.qty += newItem.qty;
      } else {
        // Default behavior: Add a new item
        existingItem.qty = newItem.qty;
      }
    } else {
      // Item doesn't exist, add a new item
      _items.add(newItem);
    }

    // Recalculate total price
    _recalculateTotalPrice();

    // Notify changes
    _onCartChanged?.call();

    // Update app state
    AppState.updateOrderCart(_items);
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);

    // Recalculate total price
    _recalculateTotalPrice();

    // Notify changes
    _onCartChanged?.call();

    // Update app state
    AppState.updateOrderCart(_items);
  }

  void clearCart() {
    _items.clear();

    // Recalculate total price
    _recalculateTotalPrice();

    // Notify changes
    _onCartChanged?.call();

    // Update app state
    AppState.updateOrderCart(_items);
  }

  bool isItemInCart(String itemId) {
    return AppState.orderCartItems.any((item) => item.id == itemId);
  }

  Map<String, dynamic> getItemCart(String itemName) {
    List<OrderCartItem> data = [];
    Map<String, int> indexes = {};

    int index = 0;
    for (var item in AppState.orderCartItems) {
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

  OrderCartItem getItemByIndex(int index) {
    return AppState.orderCartItems[index];
  }

  List<OrderCartItem> getAllItemCart() {
    return AppState.orderCartItems.toList();
  }

  Map<String, dynamic> recapCart() {
    // Summarize quantities and total price based on item names
    Map<String, dynamic> recap = {
      'totalPrice': 0,
      'totalItem': 0,
      'items': {},
    };

    for (var item in AppState.orderCartItems) {
      recap['totalPrice'] += item.totalPrice;

      if (!recap['items'].containsKey(item.name)) {
        recap['items'][item.name] = {
          'name': item.itemName,
          'preference': item.preference,
          'totalQty': item.qty,
          'totalPrice': item.totalPrice,
          'notes': item.notes,
          'addon': item.addon,
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
