class CartItem {
  final String idMenu;
  final String name;
  final String variant;
  final int quantity;
  final int price;
  final Map<String, bool> addons;
  final String notes;
  final String preference;
  final String type;
  final int variantPrice; // Add this field

  CartItem({
    required this.idMenu,
    required this.name,
    required this.variant,
    required this.quantity,
    required this.price,
    required this.addons,
    required this.notes,
    required this.preference,
    required this.type,
    required this.variantPrice, // Add this parameter
  });
}
