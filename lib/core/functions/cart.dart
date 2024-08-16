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
      item.totalPrice =
          item.qty * (item.variantPrice != 0 ? item.variantPrice : item.price);
    }
  }

  void addItem(CartItem newItem, {CartMode mode = CartMode.add}) {
    final existingItemIndex =
        _items.indexWhere((item) => item.id == newItem.id);

    if (existingItemIndex >= 0) {
      // Update existing item jika id-nya sama
      var existingItem = _items[existingItemIndex];
      if (mode == CartMode.add) {
        existingItem.qty += newItem.qty;
      } else {
        existingItem.qty = newItem.qty;
      }
      existingItem.variant = newItem.variant;
      existingItem.notes = newItem.notes;
      existingItem.preference = newItem.preference;
      existingItem.addons = newItem.addons;
      existingItem.variantPrice = newItem.variantPrice;
      existingItem.totalPrice = existingItem.qty *
          (existingItem.variantPrice != 0
              ? existingItem.variantPrice
              : existingItem.price);
      _items[existingItemIndex] = existingItem;
    } else {
      // Tambah item baru jika tidak ditemukan item dengan id yang sama
      _items.add(newItem);
    }

    // Recalculate total price
    _recalculateTotalPrice();

    // Notify changes
    _onCartChanged?.call();

    // Update app state
    appState.addItemToCart(newItem);
  }

  void removeItem(CartItem itemToRemove) {
    final eq = const DeepCollectionEquality().equals;

    _items.removeWhere((item) =>
        item.id == itemToRemove.id &&
        item.variant == itemToRemove.variant &&
        item.notes == itemToRemove.notes &&
        eq(item.preference,
            itemToRemove.preference) && // Deep compare for preference
        eq(item.addons, itemToRemove.addons)); // Deep compare for addons

    // Update AppState
    appState.cartItems.removeWhere((item) =>
        item.id == itemToRemove.id &&
        item.variant == itemToRemove.variant &&
        item.notes == itemToRemove.notes &&
        eq(item.preference,
            itemToRemove.preference) && // Deep compare for preference
        eq(item.addons, itemToRemove.addons)); // Deep compare for addons

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

  String getPreferenceText(Map<String, String> data) {
    // Get the values from the map
    List<String> values = data.values.cast<String>().toList();

    // Join the values into a comma-separated string
    String result = values.join(', ');

    return result;
  }
}
