import 'dart:ui';
import 'dart:math';
import 'package:kontena_pos/app_state.dart'; // Import for deep equality check
import 'package:flutter/material.dart';
import 'package:kontena_pos/models/cartitem.dart';

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
  Map<String, Map<String, dynamic>>? addons;
  List<dynamic>? addon;
  List<dynamic>? pref;
  String notes;
  Map<String, String> preference;
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
    this.pref,
    required this.notes,
    required this.preference,
    this.type,
  }) : totalPrice = qty * (variantPrice != 0 ? variantPrice : price);

  // Constructor for creating a copy of an existing CartItem
  // CartItem.from(CartItem item)
  //     : id = item.id,
  //       name = item.name,
  //       itemName = item.name,
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

  // Method to copy with modifications
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
  //     itemName: itemName,
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
  //     itemName: map['name'],
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

class Cart extends ChangeNotifier {
  List<CartItem> _items = [];
  VoidCallback? _onCartChanged;

  Cart({VoidCallback? onCartChanged}) : _onCartChanged = onCartChanged {
    // Set the initial cart items from AppState
    _items = List.from(AppState.cartItem);
  }
  List<CartItem> get items => List.from(_items);

  // void _recalculateTotalPrice() {
  //   for (var item in _items) {
  //     item.totalPrice =
  //         item.qty * (item.variantPrice != 0 ? item.variantPrice : item.price);
 int _calculateAddonsPrice(Map<String, Map<String, dynamic>>? addons) {
    int total = 0;
    if (addons != null) {
      addons.forEach((addonCategory, addonDetails) {
        if (addonDetails.containsKey('price')) {
          total += addonDetails['price'] as int;
        }
      });
    }
    return total;
  }

  // Pastikan bahwa total price di AppState hanya diperbarui sekali setelah semua perubahan
 void _recalculateTotalPrice() {
    double totalPrice = 0.0;
    
    for (var item in _items) {
      item.addonsPrice = _calculateAddonsPrice(item.addons); 
      item.calculateTotalPrice(); 
      totalPrice += item.totalPrice; // Aggregate total price for each item
    }
    appState.setTotalPrice(totalPrice); // Update AppState with the new total
  }

  void addItem(CartItem newItem, {CartMode mode = CartMode.add}) {
    var existingItem = _items.firstWhere(
      (item) => item.id == newItem.id,
      orElse: () => CartItem(
        id: '',
        name: '',
        qty: 0,
        price: 0,
        itemName: '',
        preference: {},
        addon: [],
        notes: '',
        pref: [],
      ),
    ); // Re
    print('new id, ${newItem.id}');
    print('new pref, ${newItem.pref}');
    print('existing pref, ${existingItem.pref}');
    print('check ${existingItem.id.isNotEmpty}');

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
      print('check length, ${_items}');
      _items.forEach((element) {
        print('items pref, ${element.pref}');
      });
    }

    _recalculateTotalPrice();
    _onCartChanged?.call();
    // appState.addItemToCart(newItem); // Update AppState
    AppState.updateCart(_items);

  final existingItemIndex = _items.indexWhere((item) =>
      item.id == newItem.id && item.variantId == newItem.variantId);

  if (existingItemIndex >= 0) {
    var existingItem = _items[existingItemIndex];
    if (mode == CartMode.add) {
      existingItem.qty += newItem.qty; // Update quantity
    } else {
      existingItem.qty = newItem.qty;
    }
    existingItem = existingItem.copyWith(
      variant: newItem.variant,
      variantId: newItem.variantId,
      notes: newItem.notes,
      preference: newItem.preference,
      addons: newItem.addons,
      variantPrice: newItem.variantPrice,
      addonsPrice: _calculateAddonsPrice(newItem.addons),
      qty: existingItem.qty + newItem.qty, // Update quantity
    );
    _items[existingItemIndex] = existingItem;
  } else {
    _items.add(CartItem.from(newItem)); 
  }
  _recalculateTotalPrice(); 
  _onCartChanged?.call(); // Notify listener
}

  void remoteItemm(String itemId) {
    _items.removeWhere((item) => item.id == itemId);

    _recalculateTotalPrice();

    _onCartChanged?.call();

    AppState.updateCart(_items);
  }

  void clearCart() {
    _items.clear();
    _recalculateTotalPrice();
    _onCartChanged?.call();
    AppState.updateCart(_items);
  }

  bool isItemInCart(String itemId) {
    return AppState.cartItem.any((item) => item.id == itemId);
  }

  CartItem getItemByIndex(int index) {
    return AppState.cartItem[index];
  }

  List<CartItem> getAllItemCart() {
    return AppState.cartItem.toList();
  }

  // void updateItem(int index, CartItem updatedItem) {
  //   if (index >= 0 && index < _items.length) {
  //     // _items[index] = CartItem.from(updatedItem);
  //     _recalculateTotalPrice(); // Recalculate the total price after updating the item
  //     _onCartChanged?.call(); // Notify about the changes
  //     // appState.updateItemInCart(index); // Ensure AppState is updated as well
  //   } else {
  //     print('Item to update not found in the cart');
  //   }
  // }

  void removeItemm(String itemId) {
    _items.removeWhere((item) => item.id == itemId);

    // Recalculate total price
    _recalculateTotalPrice();

    // Notify changes
    _onCartChanged?.call();

    // Update app state
    AppState.updateCart(_items);
  }

  void removeItem(int index) {
    if (index < 0 || index >= _items.length) {
      print('Invalid index: $index');
      return;
    }

    // Remove the item from the local cart
    _items.removeAt(index);

    // Remove the item from the AppState
    AppState().cartItems.removeAt(index);

    // Notify changes
    if (_onCartChanged != null) {
      _onCartChanged!();
    }
    AppState().notifyListeners();
  void updateItem(int index, CartItem updatedItem) {
    if (index >= 0 && index < _items.length) {
      _items[index] = CartItem.from(updatedItem);
      _recalculateTotalPrice();
      _onCartChanged?.call();
      notifyListeners();
    } else {
      print('Item to update not found in the cart');
    }
  }

  void removeItem(int index) {
  if (index < 0 || index >= _items.length) {
    print('Invalid index: $index');
    return;
  }
  _items.removeAt(index);
  appState.cartItems.removeAt(index);
  _recalculateTotalPrice();
  if (_onCartChanged != null) {
    _onCartChanged!();
  }
  appState.notifyListeners();
}

  void clearAllItems() {
    _items.clear();
    AppState().resetCart(); // Clear items from the AppState as well
    if (_onCartChanged != null) {
      _onCartChanged!();
    }
    AppState().notifyListeners(); // Notify listeners of AppState
  }

  // bool isItemInCart(String itemId) {
  //   return _items.any((item) => item.id == itemId);
  // }

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
    print(itemDetails);
    return itemDetails;
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
