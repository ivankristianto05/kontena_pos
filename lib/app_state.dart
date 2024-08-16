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
    existingItem.qty = newItem.qty; // Update quantity
    existingItem.variant = newItem.variant;
    existingItem.variantId = newItem.variantId; // Update variantId
    existingItem.notes = newItem.notes;
    existingItem.preference = newItem.preference;
    existingItem.addons = newItem.addons;
    existingItem.variantPrice = newItem.variantPrice;
    existingItem.totalPrice = existingItem.qty *
      (existingItem.variantPrice != 0 ? 
      existingItem.variantPrice : 
      existingItem.price);
    _cartItems[existingItemIndex] = existingItem;
  } else {
    _cartItems.add(newItem);
  }

  notifyListeners(); // Pemberitahuan bahwa ada perubahan
}


  // Mengatur ulang cart
  void resetCart() {
    _cartItems = [];
    notifyListeners(); // Pemberitahuan bahwa cart direset
  }

  // Method untuk mencetak array idmenu, idvarian, indexpreference, dan indexaddons
  List<Map<String, dynamic>> printItemDetails() {
    List<Map<String, dynamic>> itemDetails = [];

    for (var item in _cartItems) {
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
