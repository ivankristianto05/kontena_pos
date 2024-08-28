import 'dart:ui';
import 'package:kontena_pos/app_state.dart'; // Import for deep equality check

enum CartMode {
  update, // Update the quantity if the item already exists
  add, // Add a new item if it doesn't exist
}

class CartItem {
  final String id;
  final String name;
  final String itemName;
  String? variant;
  String? variantId;
  int qty;
  final int price;
  int variantPrice;
  int totalPrice;
  Map<String, dynamic>? addons;
  List<dynamic>? addon;
  String notes;
  Map<String, dynamic> preference;
  List<dynamic>? pref;
  String? type;

  CartItem({
    required this.id,
    required this.name,
    required this.itemName,
    this.variant,
    this.variantId,
    required this.qty,
    required this.price,
    this.variantPrice = 0,
    this.addons,
    this.addon,
    required this.notes,
    required this.preference,
    this.pref,
    this.type,
  }) : totalPrice = qty * (variantPrice != 0 ? variantPrice : price);

  // static fromMap(item) {}

  // toMap() {}

  // static CartItem from(CartItem existingItem) {}

  // // Constructor for creating a copy of an existing CartItem
  // CartItem.from(CartItem item)
  //     : id = item.id,
  //       name = item.name,
  //       variant = item.variant,
  //       variantId = item.variantId,
  //       qty = item.qty,
  //       price = item.price,
  //       variantPrice = item.variantPrice,
  //       totalPrice = item.totalPrice,
  //       addons = item.addons != null ? Map.from(item.addons!) : null,
  //       notes = item.notes,
  //       preference = Map.from(item.preference),
  //       type = item.type;

  // // Method to copy with modifications
  // CartItem copyWith({
  //   String? variant,
  //   String? variantId,
  //   int? qty,
  //   int? variantPrice,
  //   Map<String, Map<String, dynamic>>? addons,
  //   String? notes,
  //   Map<String, String>? preference,
  // }) {
  //   return CartItem(
  //     id: id,
  //     name: name,
  //     variant: variant ?? this.variant,
  //     variantId: variantId ?? this.variantId,
  //     qty: qty ?? this.qty,
  //     price: price,
  //     variantPrice: variantPrice ?? this.variantPrice,
  //     addons: addons ?? this.addons,
  //     notes: notes ?? this.notes,
  //     preference: preference ?? this.preference,
  //     type: type,
  //   );
  // }
  // // Method to convert CartItem to a Map with specific fields only
  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'variant': variant,
  //     'variantId': variantId,
  //     'qty': qty,
  //     'addons': addons,
  //     'notes': notes,
  //     'preference': preference,
  //     'type': type,
  //   };
  // }

  // // Method to create a CartItem from a Map
  // factory CartItem.fromMap(Map<String, dynamic> map) {
  //   return CartItem(
  //     id: map['id'],
  //     name: map['name'],
  //     variant: map['variant'],
  //     variantId: map['variantId'],
  //     qty: map['qty'],
  //     price: map['price'],
  //     variantPrice: map['variantPrice'] ?? 0,
  //     addons: Map<String, Map<String, dynamic>>.from(map['addons'] ?? {}),
  //     notes: map['notes'],
  //     preference: Map<String, String>.from(map['preference'] ?? {}),
  //     type: map['type'],
  //   );
  // }
}

class Cart {
  List<CartItem> _items = [];
  // final AppState appState; // Dependency injection for AppState
  VoidCallback? _onCartChanged;

  Cart({VoidCallback? onCartChanged}) : _onCartChanged = onCartChanged {
    // Set the initial cart items from AppState
    _items = List.from(AppState.cartItem);
  }

  List<CartItem> get items => List.from(_items);

  void _recalculateTotalPrice() {
    for (var item in _items) {
      item.totalPrice =
          item.qty * (item.variantPrice != 0 ? item.variantPrice : item.price);
    }
  }

  void addItem(CartItem newItem, {CartMode mode = CartMode.add}) {
    // Check if the item with the same ID already exists
    var existingItem = _items.firstWhere(
      (item) => item.id == newItem.id,
      orElse: () => CartItem(
        id: '',
        name: '',
        qty: 0,
        price: 0,
        itemName: '',
        preference: {},
        addons: {},
        notes: '',
      ),
    ); // Return an empty CartItem if not found

    if (existingItem.id.isNotEmpty) {
      // Item already exists, update the quantity
      if (mode == CartMode.add) {
        existingItem.qty += newItem.qty;
      } else {
        // Default behavior: Add a new item
        existingItem.qty = newItem.qty;
      }
    } else {
      // Item doesn't exist, add a new item
      _items.add(newItem);
    }

    // Recalculate total price
    _recalculateTotalPrice();

    // Notify changes
    _onCartChanged?.call();

    // Update app state
    AppState.updateCart(_items);
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);

    // Recalculate total price
    _recalculateTotalPrice();

    // Notify changes
    _onCartChanged?.call();

    // Update app state
    AppState.updateCart(_items);
  }

  void clearCart() {
    _items.clear();

    // Recalculate total price
    _recalculateTotalPrice();

    // Notify changes
    _onCartChanged?.call();

    // Update app state
    AppState.updateCart(_items);
  }

  bool isItemInCart(String itemId) {
    return _items.any((item) => item.id == itemId);
  }

  // Method untuk mencetak array idmenu, idvarian, indexpreference, dan indexaddons
  List<Map<String, dynamic>> printItemDetails() {
    List<Map<String, dynamic>> itemDetails = [];

    for (var item in _items) {
      itemDetails.add({
        'idmenu': item.id,
        'idvarian': item.variant,
        'indexpreference': item.preference,
        'indexaddons': item.addons,
      });
    }

    return itemDetails;
  }

  CartItem getItemByIndex(int index) {
    return AppState.cartItem[index];
  }

  List<CartItem> getAllItemCart() {
    return AppState.cartItem.toList();
  }

  double getTotal() {
    double tmp = 0;
    for (var itm in _items) {
      double tmpAddon = 0;
      if (itm.addon != null) {
        itm.addon?.forEach((element) {
          tmpAddon += element['qty'] * element['harga'];
          print('check $element');
        });
      }
      tmp += itm.qty * (itm.price + tmpAddon);
    }
    // if ()
    return tmp.toDouble();
  }
}
