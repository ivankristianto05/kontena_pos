import 'package:flutter/material.dart';
import 'package:kontena_pos/Screen/order_screen.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/features/authentication/persentation/login_screen.dart';
import 'package:kontena_pos/features/orders/persentation/order_screen.dart';
import 'package:kontena_pos/routes/app_routes.dart';
import 'package:kontena_pos/Screen/order_screen.dart';
import 'package:kontena_pos/models/cart_item.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<String> _initialRouteFuture;
  List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    _initialRouteFuture = _checkStoredUser();
  }

  Future<String> _checkStoredUser() async {
    // debug mode
    // return AppRoutes.loginScreen;
    // return AppRoutes.deleteAccount;

    // me myMe = me();
    // if (await myMe.checkStoredUser()) {
    //   return AppRoutes.orderScreen;
    // }
    return AppRoutes.orderScreen;
  }

  void addItemToCart(CartItem item) {
    setState(() {
      cartItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _initialRouteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Menampilkan loading indicator jika sedang menunggu hasil
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Menampilkan pesan error jika terjadi error
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Membangun aplikasi dengan initialRoute berdasarkan hasil
          return MaterialApp(
            theme: theme,
            title: 'KONTENA',
            debugShowCheckedModeBanner: false,
            initialRoute: snapshot.data!,
            navigatorKey: navigatorKey,
            routes: {
              AppRoutes.loginScreen: (context) => LoginScreen(),
              AppRoutes.orderScreen: (context) => OrderScreen(
                cartItems: cartItems,
                addItemToCart: addItemToCart,
              ),
            },
          );
        }
      },
    );
  }
}
