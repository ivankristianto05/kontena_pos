import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kontena_pos/routes/app_routes.dart';
import 'package:kontena_pos/app_state.dart';

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

  @override
  void initState() {
    super.initState();
    _initialRouteFuture = _checkStoredUser();
  }

  Future<String> _checkStoredUser() async {
    // Uncomment and adjust based on actual implementation
    // return AppRoutes.orderScreen;
    return AppRoutes.loginScreen;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _initialRouteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AppState()),
              // Tambahkan provider lain jika diperlukan
            ],
            child: MaterialApp(
              theme: ThemeData(useMaterial3: false),
              title: 'KONTENA',
              debugShowCheckedModeBanner: false,
              initialRoute: snapshot.data ?? AppRoutes.loginScreen,
              navigatorKey: navigatorKey,
              routes: AppRoutes.routes,
            ),
          );
        }
      },
    );
  }
}
