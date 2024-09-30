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

  String _typeTransaction = '';
  String get typeTransaction => _typeTransaction;
  set typeTransaction(String _value) {
    _typeTransaction = _value;
  }

  List<dynamic> _item = [];
  List<dynamic> get item => _item;
  set item(List<dynamic> _value) {
    _item = _value;
  }

  static List<CartItem> cartItem = [];
  static void updateCart(List<CartItem> items) {
    items.forEach((element) {
      print('check pref, ${element.pref}');
    });
    cartItem = items;
  }

  static void resetCartt() {
    cartItem = [];
  }

  // List untuk menyimpan item di cart
  void _ensureInitialized() {
    if (!isInitialized) {
      throw StateError('AppState has not been initialized.');
    }
  }

  bool get isInitialized => orderManager != null;

  // List to store cart items
  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

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

  // Menambahkan atau memperbarui item di cart
  // void addItemToCart(CartItem newItem) {
  //   final existingItemIndex = findItemIndex(newItem);
  //   if (existingItemIndex >= 0) {
  //     var existingItem = _cartItems[existingItemIndex];
  //     existingItem.qty += newItem.qty; // Update quantity
  //     existingItem.variant = newItem.variant;
  //     existingItem.variantId = newItem.variantId;
  //     existingItem.notes = newItem.notes;
  //     existingItem.preference = newItem.preference;
  //     existingItem.addons = newItem.addons;
  //     existingItem.variantPrice = newItem.variantPrice;
  //     existingItem.totalPrice = existingItem.qty *
  //         (existingItem.variantPrice != 0
  //             ? existingItem.variantPrice
  //             : existingItem.price);
  //     _cartItems[existingItemIndex] = CartItem.from(
  //         existingItem); // Menggunakan salinan item yang diperbarui
  //   } else {
  //     _cartItems
  //         .add(CartItem.from(newItem)); // Menambahkan item baru dengan salinan
  //   }
  //   notifyListeners(); // Notify listeners of changes
  // }
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
    double totalCartPrice = _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
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

  // List untuk menyimpan order yang dikonfirmasi
  List<ListToConfirm> _confirmedOrders = [];
  List<ListToConfirm> get confirmedOrders => _confirmedOrders;

  // Menyimpan status konfirmasi
  bool _isOrderConfirmed = false;
  bool get isOrderConfirmed => _isOrderConfirmed;

  // Menyimpan nama pemesan
  String _namaPemesan = '';
  String get namaPemesan => _namaPemesan;
  void setNamaPemesan(String name) {
    _namaPemesan = name.isEmpty ? '' : name; // Reset nama jika input kosong
    notifyListeners();
  }

  String _currentOrderId = ''; // Field to store the selected order ID
  String get currentOrderId =>
      _currentOrderId; // Getter for the current order ID
  void setCurrentOrderId(String orderId) {
    _currentOrderId = orderId;
    notifyListeners(); // Notify listeners of changes
  }

  String _selectedTable = ''; // Field to store the selected table
  String get selectedTable => _selectedTable;
  void setSelectedTable(String table) {
    _selectedTable = table;
    notifyListeners(); // Notify listeners of changes
  }

  void resetSelectedTable() {
    _selectedTable = '';
    notifyListeners(); // Pemberitahuan kepada UI
  }

  String getTableForCurrentOrder() {
    final currentOrderId = _currentOrderId;

    // Temukan order dengan currentOrderId
    final order = _confirmedOrders.firstWhere(
        (order) => order.idOrder == currentOrderId,
        orElse: () =>
            ListToConfirm(idOrder: '', namaPemesan: '', table: '', items: []));
    return order.table; // Kembalikan nilai tabel dari order
  }

  void printConfirmedOrders() {
    for (var order in _confirmedOrders) {
      print('Order ID: ${order.idOrder}');
      print('Nama Pemesan: ${order.namaPemesan}');
      print('Table: ${order.table}');
    }
  }

  ListToConfirm _generateOrder(String idOrder) {
    final List<CartItem> allItems = List.from(_cartItems);
    return ListToConfirm(
      idOrder: idOrder,
      namaPemesan: _namaPemesan,
      table: _selectedTable,
      items: allItems,
    );
  
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
    final index =
        _confirmedOrders.indexWhere((order) => order.idOrder == orderId);
    if (index >= 0) {
      // Assuming you add a status field to ListToConfirm
      _confirmedOrders[index] =
          _confirmedOrders[index].copyWith(status: 'Confirmed');
      notifyListeners(); // Notify listeners that the status has changed
    }
    _ensureInitialized();
    orderManager.confirmOrderStatus(orderId);
    notifyListeners();
  }

  Future<void> createOrder({
    required TextEditingController guestNameController,
    required VoidCallback resetDropdown,
    required VoidCallback onSuccess,
  }) async {
    if (_cartItems.isEmpty || guestNameController.text.isEmpty) {
      print('Error: Nama pemesan tidak boleh kosong.');
      return;
    }

    final String idOrder = DateTime.now().toIso8601String();
    final ListToConfirm order = _generateOrder(idOrder);
    addOrder(order);
    resetCart();
    resetSelectedTable();
    guestNameController.clear();
    setNamaPemesan('');
    resetDropdown(); // Panggil resetDropdown setelah menunggu

    // Call the onSuccess callback
    onSuccess();

    notifyListeners();
  }

  // Menambahkan order yang dikonfirmasi ke dalam list (tidak perlu jika sudah ada `confirmOrder`)
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

  // Variabel untuk menyimpan ID order yang semua itemnya telah ter-check
  Set<String> _fullyCheckedOrders = {};
  Set<String> get fullyCheckedOrders => _fullyCheckedOrders;

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
}
