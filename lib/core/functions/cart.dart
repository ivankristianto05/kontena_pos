import 'dart:ui';
import 'package:kontena_pos/app_state.dart'; // Import for deep equality check

enum CartMode {
  update, // Update the quantity if the item already exists
  add, // Add a new item if it doesn't exist
}


class CartItem {
  final String id;
  final String name;
  String? variant;
  String? variantId;
  int qty;
  final int price;
  int variantPrice;
  int totalPrice;
  Map<String, Map<String, dynamic>>? addons;
  String notes;
  Map<String, String> preference;
  String? type;

  CartItem({
    required this.id,
    required this.name,
    this.variant,
    this.variantId,
    required this.qty,
    required this.price,
    this.variantPrice = 0,
    this.addons,
    required this.notes,
    required this.preference,
    this.type,
  }) : totalPrice = qty * (variantPrice != 0 ? variantPrice : price);

  // Constructor for creating a copy of an existing CartItem
  CartItem.from(CartItem item)
      : id = item.id,
        name = item.name,
        variant = item.variant,
        variantId = item.variantId,
        qty = item.qty,
        price = item.price,
        variantPrice = item.variantPrice,
        totalPrice = item.totalPrice,
        addons = item.addons != null ? Map.from(item.addons!) : null,
        notes = item.notes,
        preference = Map.from(item.preference),
        type = item.type;

  // Method to copy with modifications
  CartItem copyWith({
    String? variant,
    String? variantId,
    int? qty,
    int? variantPrice,
    Map<String, Map<String, dynamic>>? addons,
    String? notes,
    Map<String, String>? preference,
  }) {
    return CartItem(
      id: id,
      name: name,
      variant: variant ?? this.variant,
      variantId: variantId ?? this.variantId,
      qty: qty ?? this.qty,
      price: price,
      variantPrice: variantPrice ?? this.variantPrice,
      addons: addons ?? this.addons,
      notes: notes ?? this.notes,
      preference: preference ?? this.preference,
      type: type,
    );
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
        item.id == newItem.id && item.variantId == newItem.variantId);

    if (existingItemIndex >= 0) {
      var existingItem = _items[existingItemIndex];
      if (mode == CartMode.add) {
        existingItem.qty += newItem.qty; // Menambah quantity
      } else {
        existingItem.qty = newItem.qty;
      }
      existingItem = existingItem.copyWith(
        variant: newItem.variant,
        variantId: newItem.variantId,
        notes: newItem.notes,
        preference: newItem.preference,
        addons: newItem.addons,
        variantPrice: newItem.variantPrice,
      );
      _items[existingItemIndex] = existingItem;
    } else {
      _items.add(CartItem.from(newItem));
    }

    _recalculateTotalPrice();
    _onCartChanged?.call();
    appState.addItemToCart(newItem); // Update AppState
  }

  void updateItem(int index, CartItem updatedItem) {
    if (index >= 0 && index < _items.length) {
      _items[index] = CartItem.from(updatedItem);
      _recalculateTotalPrice(); // Recalculate the total price after updating the item
      _onCartChanged?.call(); // Notify about the changes
      appState.updateItemInCart(index); // Ensure AppState is updated as well
    } else {
      print('Item to update not found in the cart');
    }
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
