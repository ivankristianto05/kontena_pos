import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/functions/cart.dart'; // Pastikan ini mengimpor CartItem dari file yang benar
import 'models/list_to_confirm.dart'; // Pastikan ini mengimpor ListToConfirm dari file yang benar

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
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<dynamic> _item = [];
  List<dynamic> get item => _item;
  set item(List<dynamic> _value) {
    _item = _value;
  }

  // List untuk menyimpan item di cart
  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  // Method untuk mengecek apakah item dengan kombinasi idmenu, idvarian, indexpreference, dan indexaddons sudah ada
  int findItemIndex(CartItem newItem) {
    return _cartItems.indexWhere((item) =>
      item.id == newItem.id &&
      item.variant == newItem.variant &&
      item.preference.toString() == newItem.preference.toString() &&
      item.addons.toString() == newItem.addons.toString()
    );
  }

  // Menambahkan atau memperbarui item di cart
  void addItemToCart(CartItem newItem) {
    final existingItemIndex = findItemIndex(newItem);
    if (existingItemIndex >= 0) {
      var existingItem = _cartItems[existingItemIndex];
      existingItem.qty += newItem.qty; // Update quantity
      existingItem.variant = newItem.variant;
      existingItem.variantId = newItem.variantId;
      existingItem.notes = newItem.notes;
      existingItem.preference = newItem.preference;
      existingItem.addons = newItem.addons;
      existingItem.variantPrice = newItem.variantPrice;
      existingItem.totalPrice = existingItem.qty * 
        (existingItem.variantPrice != 0 ? existingItem.variantPrice : existingItem.price);
      _cartItems[existingItemIndex] = CartItem.from(existingItem); // Menggunakan salinan item yang diperbarui
    } else {
      _cartItems.add(CartItem.from(newItem)); // Menambahkan item baru dengan salinan
    }
    notifyListeners(); // Notify listeners of changes
  }

  void updateItemInCart(int index) {
    if (index >= 0 && index < _cartItems.length) {
      notifyListeners();
    } else {
      print('Invalid index: $index');
    }
  }

  // Mengatur ulang cart
  void resetCart() {
    _cartItems = [];
    notifyListeners(); // Pemberitahuan bahwa cart direset
  }


  // List untuk menyimpan order yang dikonfirmasi
  List<ListToConfirm> _confirmedOrders = [];
  List<ListToConfirm> get confirmedOrders => _confirmedOrders;

  // Menyimpan status konfirmasi
  bool _isOrderConfirmed = false;
  bool get isOrderConfirmed => _isOrderConfirmed;

  // Menyimpan nama pemesan
  String _namaPemesan = '';
  String get namaPemesan => _namaPemesan;
  void setNamaPemesan(String name) {
  _namaPemesan = name.isEmpty ? '' : name; // Reset nama jika input kosong
  notifyListeners();
}

  String _currentOrderId = ''; // Field to store the selected order ID 
  String get currentOrderId => _currentOrderId; // Getter for the current order ID
  void setCurrentOrderId(String orderId) {
    _currentOrderId = orderId;
    notifyListeners(); // Notify listeners of changes
  }

  String _selectedTable = ''; // Field to store the selected table
  String get selectedTable => _selectedTable;
  void setSelectedTable(String table) {
    _selectedTable = table;
    notifyListeners(); // Notify listeners of changes
  }
  void resetSelectedTable() {
  _selectedTable = '';
  notifyListeners(); // Pemberitahuan kepada UI
}
  String getTableForCurrentOrder() {
  final currentOrderId = _currentOrderId;
  
  // Temukan order dengan currentOrderId
  final order = _confirmedOrders
      .firstWhere((order) => order.idOrder == currentOrderId, orElse: () => ListToConfirm(idOrder: '', namaPemesan: '', table: '', items: []));
  return order.table; // Kembalikan nilai tabel dari order
}

  void printConfirmedOrders() {
  for (var order in _confirmedOrders) {
    print('Order ID: ${order.idOrder}');
    print('Nama Pemesan: ${order.namaPemesan}');
    print('Table: ${order.table}');
  }
}
  ListToConfirm _generateOrder(String idOrder) {
    final List<CartItem> allItems = List.from(_cartItems);
    return ListToConfirm(
      idOrder: idOrder,
      namaPemesan: _namaPemesan,
      table: _selectedTable,
      items: allItems,
    );
  }

  // Metode untuk membuat dan mengonfirmasi order
  void confirmOrder(String idOrder) {
    final ListToConfirm order = _generateOrder(idOrder);
    _confirmedOrders.add(order); // Add the confirmed order to the list
    _isOrderConfirmed = true; // Set order as confirmed
    resetCart(); // Clear the cart after confirmation
    notifyListeners(); // Notify listeners that the order has been confirmed
  }
  void confirmOrderStatus(String orderId) {
    final index = _confirmedOrders.indexWhere((order) => order.idOrder == orderId);
    if (index >= 0) {
      // Assuming you add a status field to ListToConfirm
      _confirmedOrders[index] = _confirmedOrders[index].copyWith(status: 'Confirmed');
      notifyListeners(); // Notify listeners that the status has changed
    }
  }
  Future<void> createOrder({
  required TextEditingController guestNameController,
  required VoidCallback resetDropdown,
  required VoidCallback onSuccess,
}) async {
  if (_cartItems.isEmpty || guestNameController.text.isEmpty) {
    print('Error: Nama pemesan tidak boleh kosong.');
    return;
  }

  final String idOrder = DateTime.now().toIso8601String();
  final ListToConfirm order = _generateOrder(idOrder);
  addOrder(order);
  resetCart();
  resetSelectedTable();
  guestNameController.clear();
  setNamaPemesan('');
  resetDropdown(); // Panggil resetDropdown setelah menunggu

  // Call the onSuccess callback
  onSuccess(); 

  notifyListeners();
}

  // Menambahkan order yang dikonfirmasi ke dalam list (tidak perlu jika sudah ada `confirmOrder`)
  void addOrder(ListToConfirm order) {
    _confirmedOrders.add(order); // Tambahkan order ke daftar konfirmasi
    _isOrderConfirmed = true; // Set order sebagai dikonfirmasi
    notifyListeners(); // Pemberitahuan bahwa order telah ditambahkan
  }
   // Variabel untuk menyimpan ID order yang semua itemnya telah ter-check
  Set<String> _fullyCheckedOrders = {};
  Set<String> get fullyCheckedOrders => _fullyCheckedOrders;

  // Fungsi untuk menambahkan ID order yang semua itemnya telah ter-check
  void addFullyCheckedOrder(String orderId) {
    _fullyCheckedOrders.add(orderId);
    notifyListeners();
  }

  // Fungsi untuk menghapus ID order dari daftar
  void removeFullyCheckedOrder(String orderId) {
    _fullyCheckedOrders.remove(orderId);
    notifyListeners();
  }

  // Fungsi untuk memeriksa apakah ID order telah ter-check semua itemnya
  bool isOrderFullyChecked(String orderId) {
    return _fullyCheckedOrders.contains(orderId);
  }
}