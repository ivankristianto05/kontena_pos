import 'package:flutter/material.dart';
import 'package:kontena_pos/features/authentication/persentation/select_organisation.dart';
import 'package:kontena_pos/features/invoices/persentation/history_invoice_screen.dart';
import 'package:kontena_pos/features/invoices/persentation/invoice_screen.dart';
import 'package:kontena_pos/features/orders/persentation/order_screen.dart';
import 'package:kontena_pos/features/authentication/persentation/login_screen.dart';
// import 'package:kontena_pos/models/cart_item.dart';

class AppRoutes {
  static const String loginScreen = '/login';
  static const String selectOrganisationScreen = '/select-organisation';
  static const String orderScreen = '/order';
  static const String invoiceScreen = '/invoice';
  static const String historyInvoiceScreen = '/history';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => const LoginScreen(),
    selectOrganisationScreen: (context) => const SelectOrganisationScreen(),
    orderScreen: (context) => OrderScreen(
          cartItems: const [],
          addItemToCart: (item) {
            // Tambahkan logika di sini jika diperlukan
          },
        ),
    invoiceScreen: (context) => const InvoiceScreen(),
    historyInvoiceScreen: (context) => const HistoryInvoiceScreen(),
  };
}
