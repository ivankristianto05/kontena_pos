import 'dart:core';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:kontena_pos/config_app.dart';
import 'package:provider/provider.dart';
import 'package:kontena_pos/routes/app_routes.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:window_manager/window_manager.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AppState and ensure it's fully initialized
  final appState = AppState();
  await appState.initializeState();
  final configuration =
      ConfigApp(); // Ensure this completes before running the app

  if ((kIsWeb != true) ||
      (Platform.isAndroid != true) ||
      (Platform.isIOS != true)) {
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      // Hide window title bar
      await windowManager.setFullScreen(false);
      await windowManager.setAlwaysOnTop(false);
      await windowManager.setSkipTaskbar(false);
    });
  }

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(configuration: configuration),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.configuration});

  final ConfigApp configuration;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<String> _initialRouteFuture;
  dynamic _configuration;

  @override
  void initState() {
    super.initState();
    widget.configuration.readConfig().then((value) => {
          setState(() {
            _configuration = value;

            if ((_configuration.isEmpty)) {
            } else {
              try {
                widget.configuration.setToState(_configuration);
              } catch (e) {
                print('gagal $e');
              }
            }
          })
        });
    _initialRouteFuture = _checkStoredUser();
  }

  Future<String> _checkStoredUser() async {
    // Adjust based on actual implementation
    // For now, we return the login screen as the initial route
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
          return MaterialApp(
            theme: ThemeData(useMaterial3: false),
            title: 'KONTENA',
            debugShowCheckedModeBanner: false,
            initialRoute: snapshot.data ?? AppRoutes.loginScreen,
            navigatorKey: navigatorKey,
            routes: AppRoutes.routes,
          );
        }
      },
    );
  }
}
