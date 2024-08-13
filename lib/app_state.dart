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

  // Menambahkan item ke dalam cart
  void addItemToCart(CartItem item) {
    final existingItemIndex = _cartItems.indexWhere((i) => i.id == item.id);
    if (existingItemIndex >= 0) {
      // Update existing item jika ada
      _cartItems[existingItemIndex].qty += item.qty;
    } else {
      // Tambah item baru jika belum ada
      _cartItems.add(item);
    }
    notifyListeners(); // Pemberitahuan bahwa ada perubahan
  }

  // Mengatur ulang cart
  void resetCart() {
    _cartItems = [];
    notifyListeners(); // Pemberitahuan bahwa cart direset
  }
}
