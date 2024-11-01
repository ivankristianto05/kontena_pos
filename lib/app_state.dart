import 'dart:convert';

// import 'package:bluetooth_print/bluetooth_print_model.dart';
// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:kontena_pos/core/functions/invoice.dart';
// import 'package:kontena_pos/core/functions/order.dart';
import 'package:kontena_pos/core/functions/order_new.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
// import 'package:kontena_pos/core/functions/serve.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'models/cartitem.dart';

class AppState extends ChangeNotifier {
  static AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }

  AppState._internal();

  static void reset() {
    _instance = AppState._internal();
  }

  Future initializeState() async {
    prefs = await SharedPreferences.getInstance();

    _safeInit(() {
      if (prefs.containsKey('ff_configUser')) {
        try {
          _configUser = json.decode(prefs.getString('_configUser') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });

    _safeInit(() {
      if (prefs.containsKey('ff_configPrinter')) {
        try {
          _configPrinter = json.decode(prefs.getString('_configPrinter') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });

    _safeInit(() {
      if (prefs.containsKey('ff_selectedPrinter')) {
        try {
          _selectedPrinter = json.decode(prefs.getString('_selectedPrinter') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });

    notifyListeners();
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  void resetCart() {
    // _cartItems = [];
    _totalPrice = 0.0;
    notifyListeners();
  }

  List<dynamic> dataCompany = [];
  List<dynamic> dataPOSProfile = [];
  List<dynamic> dataItem = [];
  List<dynamic> dataItemGroup = [];
  List<dynamic> dataItemPrice = [];
  List<dynamic> dataItemAddon = [];
  List<dynamic> listPrinter = [];

  dynamic configCompany;
  dynamic configPOSProfile;

  dynamic _configUser;
  dynamic get configUser => _configUser;
  set configUser(dynamic _value) {
    _configUser = _value;
    prefs.setString('ff_configUser', jsonEncode(_value));
  }

  dynamic _configPrinter;
  dynamic get configPrinter => _configPrinter;
  set configPrinter(dynamic _value) {
    _configPrinter = _value;
    PrintBluetoothThermal.connect(macPrinterAddress: _value['selectedMacAddPrinter']);
    prefs.setString('ff_configPrinter', jsonEncode(_value));
  }

  BluetoothInfo? _selectedPrinter;
  BluetoothInfo? get selectedPrinter => _selectedPrinter;
  set selectedPrinter(BluetoothInfo? _value) {
    _selectedPrinter = _value!;
    // prefs.setString('ff_selectedPrinter', jsonEncode(_value));
  }

  // BluetoothDevice? _selectedPrinter;
  bool _isConnected = false;

  // BluetoothDevice? get selectedPrinter => _selectedPrinter;
  bool get isConnected => _isConnected;

  // void selectPrinter(BluetoothDevice printer) {
    // _selectedPrinter = printer;
    notifyListeners();
  // }

  void setConnectionStatus(bool status) {
    _isConnected = status;
    notifyListeners();
  }

  // void clearPrinter() {
  //   _selectedPrinter = null;
  //   _isConnected = false;
  //   notifyListeners();
  // }

  String typeTransaction = '';
  String setCookie = '';

  static List<InvoiceCartItem> invoiceCartItems =
      []; // New static list to store cart items
  static void updateInvoiceCart(List<InvoiceCartItem> items) {
    invoiceCartItems = items;
  }

  static void resetInvoiceCart() {
    invoiceCartItems = [];
  }

  static List<OrderCartItem> orderCartItems =
      []; // New static list to store cart items
  static void updateOrderCart(List<OrderCartItem> items) {
    orderCartItems = items;
  }

  static void resetOrderCart() {
    orderCartItems = [];
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
