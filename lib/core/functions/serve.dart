import 'package:flutter/material.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/functions/order.dart';
import 'package:kontena_pos/models/cartitem.dart';
import 'package:kontena_pos/models/list_to_serve.dart';

class ServeManager extends ChangeNotifier {
  List<ListToServe> _serveOrders = [];
  List<ListToServe> get serveOrders => _serveOrders;

  final AppState appState;
  final OrderManager orderManager;
  
  ServeManager(this.appState, this.orderManager);

  // Method untuk menambahkan confirmed order ke served list
  void addServedOrder(String orderId) {
    // Dapatkan order dari confirmed orders di OrderManager
    final confirmedOrder = orderManager.getConfirmedOrderById(orderId);

    if (confirmedOrder.idOrder.isNotEmpty) {
      // Buat ListToServe berdasarkan confirmed order
      ListToServe servedOrder = ListToServe(
        idOrder: confirmedOrder.idOrder,
        namaPemesan: confirmedOrder.namaPemesan,
        table: confirmedOrder.table,
        items: confirmedOrder.items, // Menggunakan items dari confirmed order
        time: confirmedOrder.time,
      );

      // Tambahkan ke daftar servedOrders
      _serveOrders.add(servedOrder);
      notifyListeners(); // Beritahu UI bahwa data berubah
      
    } else {
      print('Order dengan ID $orderId tidak ditemukan.');
    }
  }

  // Fungsi untuk mengambil semua confirmed orderId dan menambahkannya ke served list
  void serveConfirmedOrders() {
    for (String orderId in orderManager.confirmedOrderIds) {
      addServedOrder(orderId); // Panggil method untuk setiap orderId yang dikonfirmasi
    }
  }
}
