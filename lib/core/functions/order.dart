// import 'package:flutter/material.dart';
// import 'package:kontena_pos/core/functions/cart.dart';
// import 'package:kontena_pos/models/list_to_confirm.dart';

// class OrderManager extends ChangeNotifier {
//   // List to store confirmed orders
//   List<ListToConfirm> _confirmedOrders = [];

//   List<ListToConfirm> get confirmedOrders => _confirmedOrders;

//   bool _isOrderConfirmed = false;

//   bool get isOrderConfirmed => _isOrderConfirmed;

//   String _namaPemesan = '';
//   String get namaPemesan => _namaPemesan;
//   void setNamaPemesan(String name) {
//     _namaPemesan = name;
//     notifyListeners();
//   }

//   String _currentOrderId = '';
//   String get currentOrderId => _currentOrderId;
//   void setCurrentOrderId(String orderId) {
//     _currentOrderId = orderId;
//     notifyListeners();
//   }

//   String _selectedTable = '';
//   String get selectedTable => _selectedTable;
//   void setSelectedTable(String table) {
//     _selectedTable = table;
//     notifyListeners();
//   }

//   String getTableForCurrentOrder() {
//     final currentOrderId = _currentOrderId;
//     final order = _confirmedOrders.firstWhere(
//         (order) => order.idOrder == currentOrderId,
//         orElse: () => ListToConfirm(idOrder: '', namaPemesan: '', table: '', items: []));
//     return order.table;
//   }

//   void printConfirmedOrders() {
//     for (var order in _confirmedOrders) {
//       print('Order ID: ${order.idOrder}');
//       print('Nama Pemesan: ${order.namaPemesan}');
//       print('Table: ${order.table}');
//     }
//   }

//   ListToConfirm _generateOrder(String idOrder, List<CartItem> cartItems) {
//     final List<CartItem> allItems = List.from(cartItems);
//     return ListToConfirm(
//       idOrder: idOrder,
//       namaPemesan: _namaPemesan,
//       table: _selectedTable,
//       items: allItems,
//     );
//   }

//   void confirmOrder(String idOrder, List<CartItem> cartItems, Function resetCart) {
//     final ListToConfirm order = _generateOrder(idOrder, cartItems);
//     _confirmedOrders.add(order);
//     _isOrderConfirmed = true;
//     resetCart();
//     notifyListeners();
//   }

//   void createOrder(List<CartItem> cartItems, Function resetCart) {
//     final String idOrder = DateTime.now().toIso8601String();
//     final ListToConfirm order = _generateOrder(idOrder, cartItems);
//     addOrder(order);
//     resetCart();
//     notifyListeners();
//   }

//   void addOrder(ListToConfirm order) {
//     _confirmedOrders.add(order);
//     _isOrderConfirmed = true;
//     notifyListeners();
//   }
// }
