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
        print('Addon Price: ${addonDetails['price']}');
      }
    });
  }
  print('Total Addon Price: $total');
  return total;
}

  // Pastikan bahwa total price di AppState hanya diperbarui sekali setelah semua perubahan
void _recalculateTotalPrice() {
  // Ensure that the total price is calculated only once after all changes
  for (var item in _items) {
    item.addonsPrice = _calculateAddonsPrice(item.addons);
    item.calculateTotalPrice();
    print('Item: ${item.name}, Qty: ${item.qty}, Total Price: Rp ${item.totalPrice}');
  }

  // Calculate the total price of all items in the cart
  double totalPrice = _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  // Update the total price in AppState only if it has changed
  if (totalPrice != appState.totalPrice) {
    appState.updateTotalPrice(totalPrice);
  }
}

  void addItem(CartItem newItem, {CartMode mode = CartMode.add}) {
  final existingItemIndex = _items.indexWhere((item) =>
      item.id == newItem.id && item.variantId == newItem.variantId);

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
    );
    _items[existingItemIndex] = existingItem;
  } else {
    _items.add(CartItem.from(newItem));
  }

  // Recalculate total price after adding or updating an item
  _recalculateTotalPrice(); 
  _onCartChanged?.call(); // Notify listener
}

  void updateItem(int index, CartItem updatedItem) {
    if (index >= 0 && index < _items.length) {
      _items[index] = CartItem.from(updatedItem);
      _recalculateTotalPrice(); // Recalculate the total price after updating the item
          appState.recalculateAppStateTotalPrice(); // Hitung ulang total harga di AppState
      _onCartChanged?.call(); // Notify about the changes
      //appState.updateItemInCart(index); // Ensure AppState is updated as well
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