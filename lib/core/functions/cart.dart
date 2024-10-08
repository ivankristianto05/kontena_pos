import 'dart:ui';
import 'package:kontena_pos/app_state.dart'; // Import for deep equality check
import 'package:flutter/material.dart';
import 'package:kontena_pos/models/cartitem.dart';

enum CartMode {
  update, // Update the quantity if the item already exists
  add, // Add a new item if it doesn't exist
}

class Cart extends ChangeNotifier {
  List<CartItem> _items = [];
  final AppState appState; // Dependency injection for AppState
  VoidCallback? _onCartChanged;

  Cart(this.appState, {VoidCallback? onCartChanged})
      : _onCartChanged = onCartChanged {
    // Set the initial cart items from AppState
    _items = List.from(appState.cartItems);
  }
  List<CartItem> get items => List.from(_items);

  int _calculateAddonsPrice(Map<String, Map<String, dynamic>>? addons) {
    int total = 0;
    if (addons != null) {
      addons.forEach((addonCategory, addonDetails) {
        if (addonDetails.containsKey('price')) {
          total += addonDetails['price'] as int;
        }
      });
    }
    return total;
  }

  // Pastikan bahwa total price di AppState hanya diperbarui sekali setelah semua perubahan
  void _recalculateTotalPrice() {
    double totalPrice = 0.0;

    for (var item in _items) {
      item.addonsPrice = _calculateAddonsPrice(item.addons);
      item.calculateTotalPrice();
      totalPrice += item.totalPrice; // Aggregate total price for each item
    }
    appState.setTotalPrice(totalPrice); // Update AppState with the new total
  }

  void addItem(CartItem newItem, {CartMode mode = CartMode.add}) {
    final existingItemIndex = _items.indexWhere(
        (item) => item.id == newItem.id && item.variantId == newItem.variantId);

    if (existingItemIndex >= 0) {
      var existingItem = _items[existingItemIndex];
      if (mode == CartMode.add) {
        existingItem.qty += newItem.qty; // Update quantity
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
        addonsPrice: _calculateAddonsPrice(newItem.addons),
        qty: existingItem.qty + newItem.qty, // Update quantity
      );
      _items[existingItemIndex] = existingItem;
    } else {
      _items.add(newItem);
      AppState().addItemToCart(newItem);
    }
    _recalculateTotalPrice();
    _onCartChanged?.call(); // Notify listener
  }

  void updateItem(int index, CartItem updatedItem) {
    if (index >= 0 && index < _items.length) {
      _items[index] = CartItem.from(updatedItem);
      _recalculateTotalPrice();
      _onCartChanged?.call();
      notifyListeners();
    } else {
      print('Item to update not found in the cart');
    }
  }

  void removeItem(int index) {
    if (index < 0 || index >= _items.length) {
      print('Invalid index: $index');
      return;
    }
    _items.removeAt(index);
    appState.cartItems.removeAt(index);
    _recalculateTotalPrice();
    if (_onCartChanged != null) {
      _onCartChanged!();
    }
    appState.notifyListeners();
  }

  void clearAllItems() {
    _items.clear();
    appState.resetCart(); // Clear items from the AppState as well
    _recalculateTotalPrice();
    if (_onCartChanged != null) {
      _onCartChanged!();
    }
    appState.notifyListeners(); // Notify listeners of AppState
  }

  bool isItemInCart(String itemId) {
    return _items.any((item) => item.id == itemId);
  }

  List<CartItem> getAllItemCart() {
    return AppState().cartItems.toList();
  }

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
    return itemDetails;
  }
}
