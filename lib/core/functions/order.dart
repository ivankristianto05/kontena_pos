// import 'package:flutter/material.dart';
// import 'package:kontena_pos/models/list_to_confirm.dart';
// import 'package:kontena_pos/core/functions/cart.dart';
// import 'package:kontena_pos/app_state.dart';

// class OrderManager extends ChangeNotifier {
//   final AppState appState;

//   OrderManager(this.appState);

//   List<ListToConfirm> _confirmedOrders = [];
//   List<ListToConfirm> get confirmedOrders => _confirmedOrders;

//   String _namaPemesan = '';
//   String get namaPemesan => _namaPemesan;

//   String _selectedTable = '';
//   String get selectedTable => _selectedTable;

//   String _currentOrderId = '';
//   String get currentOrderId => _currentOrderId;
  
// // Method to get an order by its ID
//   ListToConfirm getOrderById(String orderId) {
//     return _confirmedOrders.firstWhere(
//       (order) => order.idOrder == orderId,
//       orElse: () => ListToConfirm(idOrder: '', namaPemesan: '', table: '', items: []),
//     );
//   }

//   bool _isOrderConfirmed = false;
//   bool get isOrderConfirmed => _isOrderConfirmed;

//   Set<String> fullyCheckedOrders = {};
//   Map<String, bool> checkedItems = {};

//   void setNamaPemesan(String name) {
//     _namaPemesan = name.isEmpty ? '' : name;
//     notifyListeners();
//   }

//   void setSelectedTable(String table) {
//     _selectedTable = table;
//     notifyListeners();
//   }

//   void resetSelectedTable() {
//     _selectedTable = '';
//     notifyListeners();
//   }

//   void setCurrentOrderId(String orderId) {
//     _currentOrderId = orderId;
//     initializeCheckedItems(orderId);
//     bool allChecked = areAllItemsChecked(orderId);
//     updateOrderCheckedStatus(orderId, allChecked);
//     notifyListeners();
//   }

//   void initializeCheckedItems(String orderId) {
//     checkedItems.clear();
//     final order = _confirmedOrders.firstWhere(
//       (order) => order.idOrder == orderId,
//       orElse: () => ListToConfirm(idOrder: '', namaPemesan: '', table: '', items: []),
//     );
//     for (var item in order.items) {
//       String uniqueKey = "${orderId}_${item.id}";
//       checkedItems[uniqueKey] = false;
//     }
//   }
//   // Method to get the table for the current order
//   String getTableForCurrentOrder() {
//     return _selectedTable; // Return the current table for the selected order
//   }

//   bool areAllItemsChecked(String orderId) {
//     final order = _confirmedOrders.firstWhere(
//       (order) => order.idOrder == orderId,
//       orElse: () => ListToConfirm(idOrder: '', namaPemesan: '', table: '', items: []),
//     );
//     if (order.items.isEmpty) return false;

//     for (var item in order.items) {
//       String uniqueKey = "${orderId}_${item.id}";
//       if (!checkedItems.containsKey(uniqueKey) || checkedItems[uniqueKey] == false) {
//         return false;
//       }
//     }
//     return true;
//   }

//   void updateCheckedItems(String orderId, String itemId, bool isChecked) {
//     String uniqueKey = "${orderId}_${itemId}";
//     checkedItems[uniqueKey] = isChecked;

//     bool allChecked = areAllItemsChecked(orderId);

//     if (allChecked) {
//       fullyCheckedOrders.add(orderId);
//     } else {
//       fullyCheckedOrders.remove(orderId);
//     }

//     updateOrderCheckedStatus(orderId, allChecked);
//     notifyListeners();
//   }

//   void updateOrderCheckedStatus(String orderId, bool isChecked) {
//     if (isChecked) {
//       fullyCheckedOrders.add(orderId);
//     } else {
//       fullyCheckedOrders.remove(orderId);
//     }
//     notifyListeners();
//   }

//   void confirmOrder(String idOrder) {
//     final ListToConfirm order = _generateOrder(idOrder);

//     _confirmedOrders.add(order);
//     appState.addConfirmedOrder(order); // Call method on AppState
//     _isOrderConfirmed = true;
//     notifyListeners();
//   }

//   void createOrder({
//     required TextEditingController guestNameController,
//     required VoidCallback resetDropdown,
//   }) async {
//     if (guestNameController.text.isEmpty) {
//       print('Error: Nama pemesan tidak boleh kosong.');
//       return;
//     }

//     final String idOrder = DateTime.now().toIso8601String();
//     final ListToConfirm order = _generateOrder(idOrder);
//     addOrder(order);
//     resetSelectedTable();
//     guestNameController.clear();
//     setNamaPemesan('');

//     await Future.delayed(Duration(milliseconds: 100));

//     resetDropdown();
//     notifyListeners();
//   }

//   void addOrder(ListToConfirm order) {
//     _confirmedOrders.add(order);
//     appState.addConfirmedOrder(order); // Call method on AppState
//     _isOrderConfirmed = true;
//     notifyListeners();
//   }

//   ListToConfirm _generateOrder(String idOrder) {
//     final List<CartItem> allItems = List.from(appState.cartItems); // Get items from AppState
//     return ListToConfirm(
//       idOrder: idOrder,
//       namaPemesan: _namaPemesan,
//       table: _selectedTable,
//       items: allItems,
//     );
//   }

//   bool isOrderFullyChecked(String orderId) {
//     bool result = fullyCheckedOrders.contains(orderId);
//     print('Order $orderId is fully checked: $result');
//     return result;
//   }
// }
