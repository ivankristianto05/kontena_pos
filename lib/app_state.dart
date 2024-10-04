import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kontena_pos/core/functions/order.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/cartitem.dart';
import 'core/functions/cart.dart';
import 'models/list_to_confirm.dart';
import 'dart:convert';

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
  
  static List<CartItem> cartItem = [];

  // Variabel untuk menyimpan total harga
  double _totalPrice = 0.0;

  // Getter untuk mengambil nilai total harga
  double get totalPrice => _totalPrice;

  // Method untuk menemukan indeks item di cart
  int findItemIndex(CartItem newItem) {
    _ensureInitialized();
    return _cartItems.indexWhere((item) =>
        item.id == newItem.id &&
        item.variant == newItem.variant &&
        item.preference.toString() == newItem.preference.toString() &&
        item.addons.toString() == newItem.addons.toString());
  }

  // Method untuk menambahkan atau mengupdate item di cart
  void addItemToCart(CartItem newItem) {
    _ensureInitialized();

    final existingItemIndex = findItemIndex(newItem);

    if (existingItemIndex >= 0) {
      // Jika item sudah ada, update kuantitas dan total harganya
      var existingItem = _cartItems[existingItemIndex];
      existingItem.qty += newItem.qty;
      existingItem.variant = newItem.variant;
      existingItem.variantId = newItem.variantId;
      existingItem.notes = newItem.notes;
      existingItem.preference = newItem.preference;
      existingItem.addons = newItem.addons;
      existingItem.variantPrice = newItem.variantPrice;

      existingItem.totalPrice = existingItem.qty *
          (existingItem.variantPrice != 0
              ? existingItem.variantPrice
              : existingItem.price);

      // Update daftar item di cart
      _cartItems[existingItemIndex] = CartItem.from(existingItem);
      updateTotalPriceFromCart();
    } else {
      // Jika item baru, tambahkan ke cart
      _cartItems.add(CartItem.from(newItem));
      updateTotalPriceFromCart();
    }
    // Set total harga dari Cart setelah menambah item baru
    updateTotalPriceFromCart();
  }

  // Fungsi untuk mengupdate total harga dari Cart
  void updateTotalPriceFromCart() {
    double totalCartPrice =
        _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    setTotalPrice(totalCartPrice); // Gunakan setter untuk update total harga
  }

  // Setter untuk mengupdate total harga dari Cart
  void setTotalPrice(double newTotalPrice) {
    _totalPrice = newTotalPrice;
    notifyListeners();
    print('AppState - Total Harga Diperbarui: Rp $_totalPrice');
  }

  // Fungsi untuk mereset cart dan total harga
  void resetCart() {
    _ensureInitialized();
    _cartItems = [];
    _totalPrice = 0.0;
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

  void checkOrderItems(String orderId) {
    _ensureInitialized();
    orderManager.checkOrderItems(orderId);
    notifyListeners();
  }

  // void setItemCheckedStatus(String orderId, String itemId, bool isChecked) {
  //     _ensureInitialized();
  //     orderManager.setItemCheckedStatus(orderId, itemId, isChecked);
  //     notifyListeners();
  //   }

  Map<String, bool> getItemCheckedStatuses(String orderId) {
    _ensureInitialized();
    return orderManager.getItemCheckedStatuses(orderId);
  }

  Future<void> saveItemCheckedStatuses(
      String orderId, Map<String, bool> statuses) async {
    _ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(statuses);
    await prefs.setString('itemCheckedStatuses_$orderId', jsonString);
  }

  Future<Map<String, bool>> loadItemCheckedStatuses(String orderId) async {
    _ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('itemCheckedStatuses_$orderId') ?? '{}';
    return Map<String, bool>.from(jsonDecode(jsonString));
  }

  void setItemCheckedStatus(
      String orderId, String itemId, bool isChecked) async {
    _ensureInitialized();
    final order = orderManager.getConfirmedOrderById(orderId);
    final updatedItemCheckedStatuses =
        Map<String, bool>.from(order.itemCheckedStatuses);
    updatedItemCheckedStatuses[itemId] = isChecked;

    // Save the updated statuses
    await saveItemCheckedStatuses(orderId, updatedItemCheckedStatuses);

    orderManager.setItemCheckedStatus(orderId, itemId, isChecked);
    notifyListeners();
  }

  Future<void> loadAndSetItemCheckedStatuses(String orderId) async {
    final statuses = await loadItemCheckedStatuses(orderId);
    orderManager.setItemCheckedStatuses(orderId, statuses);
    notifyListeners();
  }

  bool isItemChecked(String orderId, String itemId) {
    _ensureInitialized();
    return orderManager.isItemChecked(orderId, itemId);
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    return formatter.format(dateTime);
  }
  void checkAllItemsInOrder(String orderId) {
        _ensureInitialized();
  orderManager.checkAllItems(orderId);
  notifyListeners();
}

  String typeTransaction = '';
}
