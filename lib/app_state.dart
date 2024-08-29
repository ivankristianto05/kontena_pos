import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/functions/cart.dart'; // Ensure this correctly imports CartItem from the right file
import 'models/list_to_confirm.dart'; // Ensure this correctly imports ListToConfirm from the right file

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

  // List for storing cart items
  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  // Method to check if an item with a combination of idmenu, idvarian, indexpreference, and indexaddons already exists
  int findItemIndex(CartItem newItem) {
    return _cartItems.indexWhere((item) =>
      item.id == newItem.id &&
      item.variant == newItem.variant &&
      item.preference.toString() == newItem.preference.toString() &&
      item.addons.toString() == newItem.addons.toString()
    );
  }

  // Add or update item in cart
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
      _cartItems[existingItemIndex] = CartItem.from(existingItem); // Use a copy of the updated item
    } else {
      _cartItems.add(CartItem.from(newItem)); // Add a new item with a copy
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

  // Reset cart
  void resetCart() {
    _cartItems = [];
    notifyListeners(); // Notify listeners that the cart is reset
  }

  // List for storing confirmed orders
  List<ListToConfirm> _confirmedOrders = [];
  List<ListToConfirm> get confirmedOrders => _confirmedOrders;

  // Checked items map
  Map<String, bool> checkedItems = {};

  // Checked status of orders
  Map<String, bool> orderCheckedStatus = {}; // Initialize the orderCheckedStatus map

  // Initialize checkedItems for new order
  void initializeCheckedItems(String orderId) {
    final order = _confirmedOrders.firstWhere(
      (order) => order.idOrder == orderId,
      orElse: () => ListToConfirm(idOrder: '', namaPemesan: '', table: '', items: []),
    );
    for (var item in order.items) {
      String uniqueKey = "${orderId}_${item.id}";
      checkedItems[uniqueKey] = false; // Initialize all items with false (unchecked)
    }
  }

  // Check if all items for a specific orderId are checked
  bool checkAllItemsChecked(String orderId) {
    final order = _confirmedOrders.firstWhere(
      (order) => order.idOrder == orderId,
      orElse: () => ListToConfirm(idOrder: '', namaPemesan: '', table: '', items: []),
    );
    if (order.items.isEmpty) return false;

    for (var item in order.items) {
      String uniqueKey = "${orderId}_${item.id}";
      if (!checkedItems.containsKey(uniqueKey) || checkedItems[uniqueKey] == false) {
        return false; // Return false if there is an unchecked item
      }
    }
    return true; // All items are checked
  }

  // Update the checked status of an order
  void updateOrderCheckedStatus(String orderId, bool allChecked) {
    orderCheckedStatus[orderId] = allChecked; // Update the order's checked status
    notifyListeners();
  }

  void setCurrentOrderId(String orderId) {
    _currentOrderId = orderId;
    initializeCheckedItems(orderId); // Initialize checkedItems for the new order
    checkAllItemsChecked(orderId); // Check if all items in the new order are checked
    notifyListeners(); // Notify UI of the change
  }

  // Store confirmation status
  bool _isOrderConfirmed = false;
  bool get isOrderConfirmed => _isOrderConfirmed;

  // Store customer name
  String _namaPemesan = '';
  String get namaPemesan => _namaPemesan;

  void setNamaPemesan(String name) {
    _namaPemesan = name.isEmpty ? '' : name; // Reset name if input is empty
    notifyListeners();
  }

  String _currentOrderId = ''; // Field to store the selected order ID
  String get currentOrderId => _currentOrderId; // Getter for the current order ID

  String _selectedTable = ''; // Field to store the selected table
  String get selectedTable => _selectedTable;

  void setSelectedTable(String table) {
    _selectedTable = table;
    notifyListeners(); // Notify listeners of changes
  }

  void resetSelectedTable() {
    _selectedTable = '';
    notifyListeners(); // Notify UI
  }

  String getTableForCurrentOrder() {
    final currentOrderId = _currentOrderId;

    // Find the order with currentOrderId
    final order = _confirmedOrders.firstWhere(
      (order) => order.idOrder == currentOrderId,
      orElse: () => ListToConfirm(idOrder: '', namaPemesan: '', table: '', items: []),
    );
    return order.table; // Return the table value from the order
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
  }

  // Method to create and confirm an order
  void confirmOrder(String idOrder) {
    final ListToConfirm order = _generateOrder(idOrder);
    _confirmedOrders.add(order); // Add the confirmed order to the list
    _isOrderConfirmed = true; // Set order as confirmed
    resetCart(); // Clear the cart after confirmation
    notifyListeners(); // Notify listeners that the order has been confirmed
  }

  void confirmOrderStatus(String orderId) {
    final index = _confirmedOrders.indexWhere((order) => order.idOrder == orderId);
    if (index >= 0) {
      // Assuming you add a status field to ListToConfirm
      _confirmedOrders[index] = _confirmedOrders[index].copyWith(status: 'Confirmed');
      notifyListeners(); // Notify listeners that the status has changed
    }
  }

  void createOrder({
    required TextEditingController guestNameController,
    required VoidCallback resetDropdown,
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

    await Future.delayed(Duration(milliseconds: 100)); // Wait a bit

    resetDropdown(); // Call resetDropdown after waiting
    notifyListeners();
  }

  // Add confirmed order to the list
  void addOrder(ListToConfirm order) {
    _confirmedOrders.add(order); // Add order to the confirmation list
    _isOrderConfirmed = true; // Set order as confirmed
    notifyListeners(); // Notify listeners that the order has been added
  }
}
