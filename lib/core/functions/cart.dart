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

 Cart(this.appState, {VoidCallback? onCartChanged}) {
  _items = List.from(appState.cartItems);
  _totalPrice = appState.totalPrice; // Sync total price
}
  
  List<CartItem> get items => List.from(_items);

  // Variabel untuk menyimpan total harga
  double _totalPrice = 0.0;

  // Getter untuk mengambil nilai total harga
  double get totalPrice => _totalPrice;

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

  // Fungsi untuk menghitung total harga dari item di cart
  void _recalculateTotalPrice() {
    _totalPrice = _items.fold(0.0, (sum, item) => sum + item.totalPrice);
    notifyListeners(); // Notify that total price has changed
  }
   int findItemIndex(CartItem newItem) {
    return items.indexWhere((item) =>
        item.id == newItem.id &&
        item.variant == newItem.variant &&
        item.preference.toString() == newItem.preference.toString() &&
        item.addons.toString() == newItem.addons.toString());
  }
  void addItem(CartItem newItem, {CartMode mode = CartMode.add}) {
  final existingItemIndex = findItemIndex(newItem);

  if (existingItemIndex >= 0) {
    // Jika item sudah ada di cart
    var existingItem = _items[existingItemIndex];

    if (mode == CartMode.add) {
      // Jika mode adalah 'add', tambahkan kuantitas
      existingItem.qty += newItem.qty;
    } else if (mode == CartMode.update) {
      // Jika mode adalah 'update', set kuantitas baru
      existingItem.qty = newItem.qty;
    }

    // Update detail lainnya
    existingItem = existingItem.copyWith(
      variant: newItem.variant,
      variantId: newItem.variantId,
      notes: newItem.notes,
      preference: newItem.preference,
      addons: newItem.addons,
      variantPrice: newItem.variantPrice,
      addonsPrice: _calculateAddonsPrice(newItem.addons),
    );

    _items[existingItemIndex] = existingItem; // Perbarui item di cart
  } else {
    // Jika item baru, tambahkan ke cart
    _items.add(CartItem.from(newItem));
  }

  _recalculateTotalPrice(); // Hitung ulang total harga
  _onCartChanged?.call(); // Beritahu listener
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
    _recalculateTotalPrice();
    _onCartChanged?.call();
  }

  void clearAllItems() {
    _items.clear();
    _recalculateTotalPrice();
    _onCartChanged?.call();
    notifyListeners(); // Notify listeners of AppState
  }
  List<CartItem> getAllItemCart() {
    return AppState().cartItems.toList();
  }
  bool isItemInCart(String itemId) {
    return _items.any((item) => item.id == itemId);
  }
  Future<void> createOrder({
  required TextEditingController guestNameController,
  required VoidCallback resetDropdown,
  required VoidCallback onSuccess,
}) async {
  // Periksa apakah nama pemesan ada dan cart tidak kosong
  if (guestNameController.text.isEmpty) {
    throw 'Nama pemesan tidak boleh kosong!';
  }
  if (_items.isEmpty) {
    throw 'Keranjang tidak boleh kosong!';
  }

  try {
    // Panggil metode createOrder di OrderManager, mirip dengan AppState sebelumnya
    await appState.orderManager.createOrder(
      guestNameController: guestNameController,
      resetDropdown: resetDropdown,
      onSuccess: onSuccess,
      cartItems: _items, // Menggunakan item dari Cart
    );

    // Setelah order berhasil, bersihkan keranjang dan reset form
    clearAllItems();
    guestNameController.clear();
    resetDropdown();

    // Callback untuk tindakan sukses
    onSuccess();
    notifyListeners(); // Beritahu listener bahwa ada perubahan pada Cart
  } catch (e) {
    throw 'Error saat membuat order: $e';
  }
}

}
