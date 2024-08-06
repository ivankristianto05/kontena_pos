import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/functions/cart.dart';

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

  static List<CartItem> cartItems = []; // New static list to store cart items
  static void updateCart(List<CartItem> items) {
    cartItems = items;
  }

  static void resetCart() {
    cartItems = [];
  }
}
