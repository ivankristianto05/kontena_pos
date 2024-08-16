import 'dart:ui';
import 'package:collection/collection.dart'; // Import for deep equality check
import 'package:kontena_pos/app_state.dart';

enum CartMode {
  update, // Update the quantity if the item already exists
  add, // Add a new item if it doesn't exist
}

class CartItem {
  final String id;
  final String name;
  String? variant;
  String? variantId; // Tambahkan parameter ini
  int qty;
  final int price;
  int variantPrice;
  late int totalPrice;
  Map<String, Map<String, dynamic>>? addons;
  String notes;
  Map<String, String> preference;
  String? type;

  CartItem({
    required this.id,
    required this.name,
    this.variant,
    this.variantId, // Tambahkan parameter ini
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
}


class Cart {
  List<CartItem> _items = [];
  final AppState appState; // Dependency injection for AppState
  VoidCallback? _onCartChanged;

  Cart(this.appState, {VoidCallback? onCartChanged})
      : _onCartChanged = onCartChanged {
    // Set the initial cart items from AppState
    _items = List.from(appState.cartItems);
  }

  List<CartItem> get items => List.from(_items);

  void _recalculateTotalPrice() {
    for (var item in _items) {
      item.totalPrice = item.qty *
          (item.variantPrice != 0 ? item.variantPrice : item.price);
    }
  }

  void addItem(CartItem newItem, {CartMode mode = CartMode.add}) {
  final existingItemIndex = _items.indexWhere((item) =>
    item.id == newItem.id &&
    item.variantId == newItem.variantId);

  if (existingItemIndex >= 0) {
    var existingItem = _items[existingItemIndex];
    if (mode == CartMode.add) {
      existingItem.qty += newItem.qty;
    } else {
      existingItem.qty = newItem.qty;
    }
    existingItem.variant = newItem.variant;
    existingItem.variantId = newItem.variantId;
    existingItem.notes = newItem.notes;
    existingItem.preference = newItem.preference;
    existingItem.addons = newItem.addons;
    existingItem.variantPrice = newItem.variantPrice;
    existingItem.totalPrice = existingItem.qty *
      (existingItem.variantPrice != 0 ? existingItem.variantPrice : existingItem.price);
    _items[existingItemIndex] = existingItem;
  } else {
    _items.add(newItem);
  }

  _recalculateTotalPrice();
  _onCartChanged?.call();
  appState.addItemToCart(newItem); // Update AppState
}
  void updateItem(String itemId, CartItem updatedItem) {
  final index = _items.indexWhere((item) => item.id == itemId
      && item.variant == updatedItem.variant
      && item.notes == updatedItem.notes
      && const DeepCollectionEquality().equals(item.preference, updatedItem.preference)
      && const DeepCollectionEquality().equals(item.addons, updatedItem.addons));

  if (index >= 0) {
    _items[index] = updatedItem;
  }

  // Notify changes
  if (_onCartChanged != null) {
    _onCartChanged!();
  }
  appState.notifyListeners();
}

  void removeItem(int index) {
  if (index < 0 || index >= _items.length) {
    print('Invalid index: $index');
    return;
  }

  // Remove the item from the local cart
  _items.removeAt(index);

  // Remove the item from the AppState
  appState.cartItems.removeAt(index);

  // Notify changes
  if (_onCartChanged != null) {
    _onCartChanged!();
  }
  appState.notifyListeners();
}


  void clearAllItems() {
    _items.clear();
    appState.resetCart(); // Clear items from the AppState as well
    if (_onCartChanged != null) {
      _onCartChanged!();
    }
    appState.notifyListeners(); // Notify listeners of AppState
  }

  bool isItemInCart(String itemId) {
    return _items.any((item) => item.id == itemId);
  }

  // Method untuk mencetak array idmenu, idvarian, indexpreference, dan indexaddons
  List<Map<String, dynamic>> printItemDetails() {
    List<Map<String, dynamic>> itemDetails = [];

    for (var item in _items) {
      itemDetails.add({
        'idmenu': item.id,
        'idvarian': item.variant,
        'indexpreference': item.preference,
        'indexaddons': item.addons,
      });
    }

    // Print the array
    print(itemDetails);

    return itemDetails;
  }
}
