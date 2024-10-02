import 'package:flutter/material.dart';
import 'package:kontena_pos/features/authentication/persentation/select_organisation.dart';
import 'package:kontena_pos/features/checkout/persentation/payment.dart';
import 'package:kontena_pos/features/invoices/persentation/history_invoice_screen.dart';
import 'package:kontena_pos/features/invoices/persentation/invoice_screen.dart';
import 'package:kontena_pos/features/orders/persentation/order_screen.dart';
import 'package:kontena_pos/features/authentication/persentation/login_screen.dart';

import '../features/orders/persentation/confirm_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login';
  static const String selectOrganisationScreen = '/select-organisation';
  static const String orderScreen = '/order';
  static const String invoiceScreen = '/invoice';
  static const String historyInvoiceScreen = '/history';
  static const String paymentScreen = '/payment';
  static const String confirmScreen =
      '/confirm'; // ganti ConfirmScreen dengan confirmScreen untuk naming convention yang konsisten

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => const LoginScreen(),
    selectOrganisationScreen: (context) => const SelectOrganisationScreen(),
    orderScreen: (context) => OrderScreen(),
    invoiceScreen: (context) => const InvoiceScreen(),
    historyInvoiceScreen: (context) => const HistoryInvoiceScreen(),
    confirmScreen: (context) =>
        ConfirmScreen(), // pastikan ConfirmScreen adalah class
    paymentScreen: (context) => const PaymentScreen(),
  };
}
