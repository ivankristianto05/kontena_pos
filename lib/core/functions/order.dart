import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/functions/cart.dart';
import 'package:kontena_pos/models/cartitem.dart';
import 'package:kontena_pos/models/list_to_confirm.dart'; // Import untuk formatting tanggal

class OrderManager extends ChangeNotifier {
  List<ListToConfirm> _confirmedOrders = [];
  List<ListToConfirm> get confirmedOrders => _confirmedOrders;
  
  // Dependency injection for AppState
  final AppState appState;
  OrderManager(this.appState);

  // Set to store fully checked order IDs
  Set<String> _fullyCheckedOrders = {};
  final Map<String, Map<String, bool>> _orderItemCheckedStatuses = {};

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
    // Check if all items in the new order are fully checked and update the state
    checkOrderItems(orderId);
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
    final order = _confirmedOrders.firstWhere(
      (order) => order.idOrder == _currentOrderId,
      orElse: () => ListToConfirm(idOrder: '', namaPemesan: '', table: '', items: [], time: DateTime.now()),
    );
    return order.table;
  }

  void printConfirmedOrders() {
    for (var order in _confirmedOrders) {
      print('Order ID: ${order.idOrder}');
      print('Order Time: ${formatDateTime(order.time)}'); // Use the new function here
    }
  }

  ListToConfirm _generateOrder(String idOrder, List<CartItem> cartItems) {
    return ListToConfirm(
      idOrder: idOrder,
      namaPemesan: _namaPemesan,
      table: _selectedTable,
      items: List.from(cartItems),
      time: DateTime.now(), // Set current time
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
    } else {
      print('Order with orderId $orderId not found.');
    }
  }

  Future<void> createOrder({
    required TextEditingController guestNameController,
    required VoidCallback resetDropdown,
    required VoidCallback onSuccess,
    required List<CartItem> cartItems,
  }) async {
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

  Set<String> get fullyCheckedOrders => _fullyCheckedOrders;

  bool isOrderFullyChecked(String orderId) {
    return _fullyCheckedOrders.contains(orderId);
  }

  void checkOrderItems(String orderId) {
    final order = _confirmedOrders.firstWhere(
      (order) => order.idOrder == orderId,
      orElse: () => ListToConfirm(idOrder: '', namaPemesan: '', table: '', items: [], time: DateTime.now()),
    );
    final allChecked = order.items.every((item) => order.itemCheckedStatuses[item.id] ?? false);
    if (allChecked) {
      addFullyCheckedOrder(orderId);
    } else {
      removeFullyCheckedOrder(orderId);
    }
    notifyListeners();
  }

  void setItemCheckedStatus(String orderId, String itemId, bool isChecked) {
    print('Setting item $itemId in order $orderId to $isChecked');
    final index = _confirmedOrders.indexWhere((order) => order.idOrder == orderId);
    if (index >= 0) {
      final order = _confirmedOrders[index];
      final updatedItemCheckedStatuses = Map<String, bool>.from(order.itemCheckedStatuses);
      updatedItemCheckedStatuses[itemId] = isChecked;
      _confirmedOrders[index] = order.copyWith(itemCheckedStatuses: updatedItemCheckedStatuses);
      appState.saveItemCheckedStatuses(orderId, updatedItemCheckedStatuses);
      checkOrderItems(orderId); // Recheck order items after updating
      notifyListeners();
    } else {
      print('Order with orderId $orderId not found.');
    }
  }

  Map<String, bool> getItemCheckedStatuses(String orderId) {
    return _orderItemCheckedStatuses[orderId] ?? {};
  }

  void addFullyCheckedOrder(String orderId) {
    _fullyCheckedOrders.add(orderId);
    notifyListeners();
  }

  void removeFullyCheckedOrder(String orderId) {
    _fullyCheckedOrders.remove(orderId);
    notifyListeners();
  }

  void setItemCheckedStatuses(String orderId, Map<String, bool> statuses) {
    final index = _confirmedOrders.indexWhere((order) => order.idOrder == orderId);
    if (index >= 0) {
      final order = _confirmedOrders[index];
      _confirmedOrders[index] = order.copyWith(itemCheckedStatuses: statuses);
      notifyListeners();
    }
  }

  // Method to load item checked statuses when the order is set
  Future<void> loadAndSetItemCheckedStatuses(String orderId) async {
    final statuses = await appState.loadItemCheckedStatuses(orderId);
    setItemCheckedStatuses(orderId, statuses);
  }

  ListToConfirm getConfirmedOrderById(String orderId) {
    return _confirmedOrders.firstWhere(
      (order) => order.idOrder == orderId,
      orElse: () => ListToConfirm(idOrder: '', namaPemesan: '', table: '', items: [], time: DateTime.now()),
    );
  }

  bool isItemChecked(String orderId, String itemId) {
    final index = _confirmedOrders.indexWhere((order) => order.idOrder == orderId);
    if (index >= 0) {
      final order = _confirmedOrders[index];
      return order.itemCheckedStatuses[itemId] ?? false; // Default to false if not found
    }
    return false;
  }

  // Function to format DateTime to the desired format
  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    return formatter.format(dateTime);
  }
// Method to check all items in an order
void checkAllItems(String orderId) {
    final orderIndex = _confirmedOrders.indexWhere((order) => order.idOrder == orderId);
    if (orderIndex >= 0) {
        final order = _confirmedOrders[orderIndex];

        // Update semua item menjadi dicentang
        for (var item in order.items) {
            setItemCheckedStatus(orderId, item.id, true); // Panggil fungsi setItemCheckedStatus untuk setiap item
        }
        addFullyCheckedOrder(orderId);
        notifyListeners(); // Beritahu UI untuk memperbarui tampilan
    } else {
        print('Order dengan ID $orderId tidak ditemukan.');
    }
}

}
