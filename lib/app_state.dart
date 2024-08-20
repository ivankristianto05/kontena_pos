import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/functions/cart.dart'; // Pastikan ini mengimpor CartItem dari file yang benar
import 'models/list_to_confirm.dart'; // Pastikan ini mengimpor ListToConfirm dari file yang benar

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

  // List untuk menyimpan order yang dikonfirmasi
  List<ListToConfirm> _confirmedOrders = [];

  List<ListToConfirm> get confirmedOrders => _confirmedOrders;

  // Method untuk mengecek apakah item dengan kombinasi idmenu, idvarian, indexpreference, dan indexaddons sudah ada
  int findItemIndex(CartItem newItem) {
    return _cartItems.indexWhere((item) =>
      item.id == newItem.id &&
      item.variant == newItem.variant &&
      item.preference.toString() == newItem.preference.toString() &&
      item.addons.toString() == newItem.addons.toString()
    );
  }

  // Menambahkan atau memperbarui item di cart
  void addItemToCart(CartItem newItem) {
    final existingItemIndex = findItemIndex(newItem);

    if (existingItemIndex >= 0) {
      var existingItem = _cartItems[existingItemIndex];
      existingItem.qty += newItem.qty; // Update quantity
      existingItem.variant = newItem.variant;
      existingItem.variantId = newItem.variantId;
      existingItem.notes = newItem.notes;
      existingItem.preference = newItem.preference;
      existingItem.addons = newItem.addons;
      existingItem.variantPrice = newItem.variantPrice;
      existingItem.totalPrice = existingItem.qty * 
        (existingItem.variantPrice != 0 ? existingItem.variantPrice : existingItem.price);
      _cartItems[existingItemIndex] = CartItem.from(existingItem); // Menggunakan salinan item yang diperbarui
    } else {
      _cartItems.add(CartItem.from(newItem)); // Menambahkan item baru dengan salinan
    }
    notifyListeners(); // Notify listeners of changes
  }

  void updateItemInCart(int index) {
    if (index >= 0 && index < _cartItems.length) {
      notifyListeners();
    } else {
      print('Invalid index: $index');
    }
  }

  // Mengatur ulang cart
  void resetCart() {
    _cartItems = [];
    notifyListeners(); // Pemberitahuan bahwa cart direset
  }

  // Menambahkan order yang dikonfirmasi ke dalam list
  void addOrder(ListToConfirm order) {
    _confirmedOrders.add(order);
    notifyListeners(); // Pemberitahuan bahwa order telah ditambahkan
  }
}
