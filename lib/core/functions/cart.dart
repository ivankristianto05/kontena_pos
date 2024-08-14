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
  int variantPrice;
  late int totalPrice;
  Map<String, Map<String, dynamic>>? addons;
  final String notes;
  final Map<String, String> preference;
  String? type;

  CartItem({
    required this.id,
    required this.name,
    this.variant,
    required this.qty,
    required this.price,
    this.variantPrice = 0,
    this.addons,
    required this.notes,
    required this.preference,
    this.type,
  }) {
    totalPrice = qty * (variantPrice != 0 ? variantPrice : price);
  }

  // Define the copyWith method
  CartItem copyWith({
    String? id,
    String? name,
    String? variant,
    int? qty,
    int? price,
    int? variantPrice,
    Map<String, Map<String, dynamic>>? addons,
    String? notes,
    Map<String, String>? preference,
    String? type,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      variant: variant ?? this.variant,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      variantPrice: variantPrice ?? this.variantPrice,
      addons: addons ?? this.addons,
      notes: notes ?? this.notes,
      preference: preference ?? this.preference,
      type: type ?? this.type,
    );
  }
}



class Cart {
  List<CartItem> _items = [];
  final AppState appState; // Dependency injection for AppState
  VoidCallback? _onCartChanged;

  Cart(this.appState, {VoidCallback? onCartChanged}) : _onCartChanged = onCartChanged {
    // Set the initial cart items from AppState
    _items = List.from(appState.cartItems);
  }

  List<CartItem> get items => List.from(_items);

  void _recalculateTotalPrice() {
    for (var item in _items) {
      item.totalPrice = item.qty * (item.variantPrice != 0 ? item.variantPrice : item.price);
    }
  }

  void addItem(CartItem newItem, {CartMode mode = CartMode.add}) {
    var existingItemIndex = _items.indexWhere((item) => item.id == newItem.id);

    if (existingItemIndex != -1) {
      // Item already exists, update the quantity
      var existingItem = _items[existingItemIndex];
      if (mode == CartMode.add) {
        existingItem.qty += newItem.qty;
      } else {
        existingItem.qty = newItem.qty;
      }
      _items[existingItemIndex] = existingItem;
    } else {
      // Item doesn't exist, add a new item
      _items.add(newItem);
    }

    // Recalculate total price
    _recalculateTotalPrice();

    // Notify changes
    _onCartChanged?.call();

    // Update app state
    appState.addItemToCart(newItem);
  }

  bool isItemInCart(String itemId) {
    return _items.any((item) => item.id == itemId);
  }

  Map<String, dynamic> getItemCart(String itemName) {
    List<CartItem> data = [];
    Map<String, int> indexes = {};

    int index = 0;
    for (var item in _items) {
      if (item.name == itemName) {
        indexes[item.id] = index;
        data.add(item);
      }
      index++;
    }

    return {"data": data, "index": indexes};
  }

  CartItem getItemByIndex(int index) {
    return _items[index];
  }

  List<CartItem> getAllItemCart() {
    return List.from(_items);
  }

  Map<String, dynamic> recapCart() {
    // Summarize quantities and total price based on item names
    Map<String, dynamic> recap = {
      'totalPrice': 0,
      'totalItem': 0,
      'items': {},
    };

    for (var item in _items) {
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
