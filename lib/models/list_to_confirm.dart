import 'package:kontena_pos/core/functions/cart.dart';

class ListToConfirm {
  final String idOrder;
  final String namaPemesan;
  final String table;
  final List<CartItem> items;

  ListToConfirm({
    required this.idOrder,
    required this.namaPemesan,
    required this.table,
    required this.items,
  });

  // Method untuk mengubah model ke format map
  Map<String, dynamic> toMap() {
    return {
      'idOrder': idOrder,
      'namaPemesan': namaPemesan,
      'table': table,
      // 'items': items.map((item) => item.toMap()).toList(),
    };
  }

  // Method untuk membuat model dari format map
  factory ListToConfirm.fromMap(Map<String, dynamic> map) {
    return ListToConfirm(
      idOrder: map['idOrder'],
      namaPemesan: map['namaPemesan'],
      table: map['table'],
      items: List<CartItem>.from(
        [],
      ),
    );
  }
}
