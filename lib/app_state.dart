
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/functions/cart.dart'; // Pastikan ini mengimpor CartItem dari file yang benar

class AppState extends ChangeNotifier {
  static AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }

  AppState._internal();

  static void reset() {
    _instance = AppState._internal();
  }

  Future initializeState() async {
    prefs = await SharedPreferences.getInstance();
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<dynamic> _item = [];
  List<dynamic> get item => _item;
  set item(List<dynamic> _value) {
    _item = _value;
  }

  // List untuk menyimpan item di cart
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  // Menambahkan atau memperbarui item di cart
  void addItemToCart(CartItem newItem) {
    final existingItemIndex = _cartItems.indexWhere((item) =>
      item.id == newItem.id &&
      item.variant == newItem.variant &&
      item.notes == newItem.notes &&
      item.preference.toString() == newItem.preference.toString() &&
      item.addons.toString() == newItem.addons.toString()
    );

    if (existingItemIndex >= 0) {
      // Update existing item jika atributnya sama
      _cartItems[existingItemIndex].qty += newItem.qty;
      _cartItems[existingItemIndex].totalPrice = _cartItems[existingItemIndex].qty * 
        (_cartItems[existingItemIndex].variantPrice != 0 ? 
        _cartItems[existingItemIndex].variantPrice : 
        _cartItems[existingItemIndex].price);
    } else {
      // Tambah item baru jika atributnya berbeda
      _cartItems.add(newItem);
    }

    notifyListeners(); // Pemberitahuan bahwa ada perubahan
  }

  // Mengatur ulang cart
  void resetCart() {
    _cartItems = [];
    notifyListeners(); // Pemberitahuan bahwa cart direset
  }
}
