import 'package:flutter/material.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/functions/cart.dart';
import 'package:kontena_pos/models/list_to_confirm.dart';

class OrderManager extends ChangeNotifier {
  List<ListToConfirm> _confirmedOrders = [];
  List<ListToConfirm> get confirmedOrders => _confirmedOrders;
  
  // Dependency injection for AppState
  final AppState appState;
  OrderManager(this.appState);

  bool _isOrderConfirmed = false;
  bool get isOrderConfirmed => _isOrderConfirmed;

  String _namaPemesan = '';
  String get namaPemesan => _namaPemesan;
  void setNamaPemesan(String name) {
    _namaPemesan = name.isEmpty ? '' : name;
    notifyListeners();
  }

  String _currentOrderId = '';
  String get currentOrderId => _currentOrderId;
  void setCurrentOrderId(String orderId) {
    _currentOrderId = orderId;
    notifyListeners();
  }

  String _selectedTable = '';
  String get selectedTable => _selectedTable;
  void setSelectedTable(String table) {
    _selectedTable = table;
    notifyListeners();
  }
  
  void resetSelectedTable() {
    _selectedTable = '';
    notifyListeners();
  }

  String getTableForCurrentOrder() {
    final currentOrderId = _currentOrderId;
    final order = _confirmedOrders.firstWhere(
      (order) => order.idOrder == currentOrderId,
      orElse: () => ListToConfirm(idOrder: '', namaPemesan: '', table: '', items: []),
    );
    return order.table;
  }

  void printConfirmedOrders() {
    for (var order in _confirmedOrders) {
      print('Order ID: ${order.idOrder}');
      print('Nama Pemesan: ${order.namaPemesan}');
      print('Table: ${order.table}');
    }
  }

  ListToConfirm _generateOrder(String idOrder, List<CartItem> cartItems) {
    return ListToConfirm(
      idOrder: idOrder,
      namaPemesan: _namaPemesan,
      table: _selectedTable,
      items: List.from(cartItems),
    );
  }

  void confirmOrder(String idOrder, List<CartItem> cartItems) {
    final ListToConfirm order = _generateOrder(idOrder, cartItems);
    _confirmedOrders.add(order);
    _isOrderConfirmed = true;
    appState.resetCart();
    notifyListeners();
  }

  void confirmOrderStatus(String orderId) {
    final index = _confirmedOrders.indexWhere((order) => order.idOrder == orderId);
    if (index >= 0) {
      _confirmedOrders[index] = _confirmedOrders[index].copyWith(status: 'Confirmed');
      notifyListeners();
    }
  }

  Future<void> createOrder({
    required TextEditingController guestNameController,
    required VoidCallback resetDropdown,
    required VoidCallback onSuccess,
    required List<CartItem> cartItems,
  }) async {
    if (cartItems.isEmpty || guestNameController.text.isEmpty) {
      print('Error: Nama pemesan tidak boleh kosong.');
      return;
    }

    final String idOrder = DateTime.now().toIso8601String();
    final ListToConfirm order = _generateOrder(idOrder, cartItems);
    addOrder(order);
    appState.resetCart();
    resetSelectedTable();
    guestNameController.clear();
    setNamaPemesan('');
    resetDropdown();
    onSuccess();
    notifyListeners();
  }

  void addOrder(ListToConfirm order) {
    _confirmedOrders.add(order);
    notifyListeners();
  }

  Set<String> get fullyCheckedOrders {
    return _confirmedOrders
        .where((order) => order.items.every((item) => item.qty > 0))
        .map((order) => order.idOrder)
        .toSet();
  }

  void addFullyCheckedOrder(String orderId) {
    // Implementation based on your logic
    notifyListeners();
  }

  void removeFullyCheckedOrder(String orderId) {
    // Implementation based on your logic
    notifyListeners();
  }

  bool isOrderFullyChecked(String orderId) {
    final order = _confirmedOrders.firstWhere(
      (order) => order.idOrder == orderId,
      orElse: () => ListToConfirm(idOrder: '', namaPemesan: '', table: '', items: []),
    );
    return order.items.every((item) => item.qty > 0);
  }
}
