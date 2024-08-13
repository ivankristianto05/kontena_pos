import 'package:flutter/material.dart';
import 'package:kontena_pos/features/invoices/persentation/history_invoice_screen.dart';
import 'package:kontena_pos/features/invoices/persentation/invoice_screen.dart';
import 'package:kontena_pos/features/orders/persentation/order_screen.dart';
import 'package:kontena_pos/features/authentication/persentation/login_screen.dart';
 import 'package:kontena_pos/models/cart_item.dart';

class AppRoutes {
  static const String loginScreen = '/login';
  static const String orderScreen = '/order';
  static const String invoiceScreen = '/invoice';
  static const String historyInvoiceScreen = '/history';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => const LoginScreen(),
    orderScreen: (context) => OrderScreen(
        ),
    //invoiceScreen: (context) => const InvoiceScreen(),
    historyInvoiceScreen: (context) => const HistoryInvoiceScreen(),
  };
}
