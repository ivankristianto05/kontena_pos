import 'package:kontena_pos/core/functions/cart.dart';

class ListToConfirm {
  final String idOrder;
  final String namaPemesan;
  final String table;
  final List<CartItem> items;
  final String status; // Add this field
  final Map<String, bool> itemCheckedStatuses; // New field for item checked statuses
  
  ListToConfirm({
    required this.idOrder,
    required this.namaPemesan,
    required this.table,
    required this.items,
    this.status = 'Draft', // Default to 'Draft'
    Map<String, bool>? itemCheckedStatuses, // New parameter for item checked statuses
  }) : itemCheckedStatuses = itemCheckedStatuses ?? {};

  // Method to copy the model with updated fields
  ListToConfirm copyWith({
    String? status,
    Map<String, bool>? itemCheckedStatuses,
  }) {
    return ListToConfirm(
      idOrder: this.idOrder,
      namaPemesan: this.namaPemesan,
      table: this.table,
      items: this.items,
      status: status ?? this.status,
      itemCheckedStatuses: itemCheckedStatuses ?? this.itemCheckedStatuses,
    );
  }

  // Method to convert the model to a map format
  Map<String, dynamic> toMap() {
    return {
      'idOrder': idOrder,
      'namaPemesan': namaPemesan,
      'table': table,
      // 'items': items.map((item) => item.toMap()).toList(),
      'status': status, // Include status in the map
      'itemCheckedStatuses': itemCheckedStatuses, // Include itemCheckedStatuses in the map
    };
  }

  // Method to create the model from a map format
  factory ListToConfirm.fromMap(Map<String, dynamic> map) {
    return ListToConfirm(
      idOrder: map['idOrder'],
      namaPemesan: map['namaPemesan'],
      table: map['table'],
      items: List<CartItem>.from(
        [],
      ),
      status: map['status'] ?? 'Draft', // Ensure status defaults to 'Draft'
      itemCheckedStatuses: Map<String, bool>.from(map['itemCheckedStatuses'] ?? {}),
    );
  }
}
