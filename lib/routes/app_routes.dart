import 'package:flutter/material.dart';
import 'package:kontena_pos/features/orders/persentation/order_screen.dart';
import 'package:kontena_pos/features/authentication/persentation/login_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login';
  static const String orderScreen = '/order';

  static Map<String, WidgetBuilder> routes = {
    orderScreen: (context) => OrderScreen(),
    loginScreen: (context) => LoginScreen(),
  };
}
