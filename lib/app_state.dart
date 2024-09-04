import 'package:flutter/material.dart';
import 'package:kontena_pos/core/functions/order.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/functions/cart.dart';
import 'models/list_to_confirm.dart';

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
    orderManager = OrderManager(this);
    notifyListeners();
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  late OrderManager orderManager;

  void _ensureInitialized() {
    if (!isInitialized) {
      throw StateError('AppState has not been initialized.');
    }
  }

  bool get isInitialized => orderManager != null;

  // List to store cart items
  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  // Method to find the index of an item in the cart
  int findItemIndex(CartItem newItem) {
    _ensureInitialized();
    return _cartItems.indexWhere((item) =>
        item.id == newItem.id &&
        item.variant == newItem.variant &&
        item.preference.toString() == newItem.preference.toString() &&
        item.addons.toString() == newItem.addons.toString());
  }

  // Method to add or update an item in the cart
  void addItemToCart(CartItem newItem) {
    _ensureInitialized();
    final existingItemIndex = findItemIndex(newItem);
    if (existingItemIndex >= 0) {
      var existingItem = _cartItems[existingItemIndex];
      existingItem.qty += newItem.qty;
      existingItem.variant = newItem.variant;
      existingItem.variantId = newItem.variantId;
      existingItem.notes = newItem.notes;
      existingItem.preference = newItem.preference;
      existingItem.addons = newItem.addons;
      existingItem.variantPrice = newItem.variantPrice;
      existingItem.totalPrice = existingItem.qty *
          (existingItem.variantPrice != 0 ? existingItem.variantPrice : existingItem.price);
      _cartItems[existingItemIndex] = CartItem.from(existingItem);
    } else {
      _cartItems.add(CartItem.from(newItem));
    }
    notifyListeners();
  }

  void updateItemInCart(int index) {
    _ensureInitialized();
    if (index >= 0 && index < _cartItems.length) {
      notifyListeners();
    } else {
      print('Invalid index: $index');
    }
  }

  // Reset the cart
  void resetCart() {
    _ensureInitialized();
    _cartItems = [];
    notifyListeners();
  }

  // Proxy method calls to OrderManager
  void setNamaPemesan(String name) {
    _ensureInitialized();
    orderManager.setNamaPemesan(name);
    notifyListeners();
  }

  String get namaPemesan {
    _ensureInitialized();
    return orderManager.namaPemesan;
  }

  String get currentOrderId {
    _ensureInitialized();
    return orderManager.currentOrderId;
  }

  void setCurrentOrderId(String orderId) {
    _ensureInitialized();
    orderManager.setCurrentOrderId(orderId);
    notifyListeners();
  }

  void setSelectedTable(String table) {
    _ensureInitialized();
    orderManager.setSelectedTable(table);
    notifyListeners();
  }

  String get selectedTable {
    _ensureInitialized();
    return orderManager.selectedTable;
  }

  void resetSelectedTable() {
    _ensureInitialized();
    orderManager.resetSelectedTable();
    notifyListeners();
  }

  String getTableForCurrentOrder() {
    _ensureInitialized();
    return orderManager.getTableForCurrentOrder();
  }

  void printConfirmedOrders() {
    _ensureInitialized();
    orderManager.printConfirmedOrders();
  }

  void confirmOrder(String idOrder) {
    _ensureInitialized();
    orderManager.confirmOrder(idOrder, _cartItems);
    notifyListeners();
  }

  void confirmOrderStatus(String orderId) {
    _ensureInitialized();
    orderManager.confirmOrderStatus(orderId);
    notifyListeners();
  }

  Future<void> createOrder({
    required TextEditingController guestNameController,
    required VoidCallback resetDropdown,
    required VoidCallback onSuccess,
  }) async {
    _ensureInitialized();
    await orderManager.createOrder(
      guestNameController: guestNameController,
      resetDropdown: resetDropdown,
      onSuccess: onSuccess,
      cartItems: _cartItems,
    );
    notifyListeners();
  }

  void addOrder(ListToConfirm order) {
    _ensureInitialized();
    orderManager.addOrder(order);
    notifyListeners();
  }

  Set<String> get fullyCheckedOrders {
    _ensureInitialized();
    return orderManager.fullyCheckedOrders;
  }

  void addFullyCheckedOrder(String orderId) {
    _ensureInitialized();
    orderManager.addFullyCheckedOrder(orderId);
    notifyListeners();
  }

  void removeFullyCheckedOrder(String orderId) {
    _ensureInitialized();
    orderManager.removeFullyCheckedOrder(orderId);
    notifyListeners();
  }

  bool isOrderFullyChecked(String orderId) {
    _ensureInitialized();
    return orderManager.isOrderFullyChecked(orderId);
  }

  // Getter to check if any orders are confirmed
  bool get isOrderConfirmed {
    _ensureInitialized();
    return orderManager.confirmedOrders.isNotEmpty;
  }

  // Getter to retrieve the list of confirmed orders
  List<ListToConfirm> get confirmedOrders {
    _ensureInitialized();
    return orderManager.confirmedOrders;
  }
}
