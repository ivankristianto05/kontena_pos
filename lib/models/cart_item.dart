// models/cart_item.dart

class CartItem {
  final String idMenu;
  final String name;
  final String variant;
  final int quantity;
  final double price;
  final Map<String, bool> addons;
  final String notes;
  final String preference;

  CartItem({
    required this.idMenu,
    required this.name,
    required this.variant,
    required this.quantity,
    required this.price,
    required this.addons,
    required this.notes,
    required this.preference,
  });
}
