import 'package:flutter/material.dart';
import 'package:kontena_pos/models/list_to_confirm.dart';
import 'package:provider/provider.dart';
import 'package:kontena_pos/app_state.dart';

class ConfirmCard extends StatefulWidget {
  const ConfirmCard({
    super.key,
    required this.screenWidth,
    required this.orderId, // Tambahkan properti ini
  });

  final double screenWidth;
  final String orderId; // Tambahkan properti ini

  @override
  _ConfirmCardState createState() => _ConfirmCardState();
}

class _ConfirmCardState extends State<ConfirmCard> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    if (!appState.isOrderConfirmed) {
      return const Center(
        child: Text('No order confirmed yet.'),
      );
    }

    // Filter confirmedOrders berdasarkan orderId
    final filteredOrder = appState.confirmedOrders.firstWhere(
      (order) => order.idOrder == widget.orderId,
      orElse: () => ListToConfirm(
        idOrder: '',
        namaPemesan: '',
        table: '',
        items: [],
      ),
    );

    if (filteredOrder.items.isEmpty) {
      return const Center(
        child: Text('No items found for this order.'),
      );
    }

    final cardWidth = (widget.screenWidth * 0.65) / 3 - 12;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 8.0,  // Jarak horizontal antar kartu
          runSpacing: 8.0,  // Jarak vertikal antar baris
          children: [
            SizedBox(
              width: cardWidth,  // Lebar kartu yang dihitung
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            filteredOrder.table,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const Text(
                            "Draft",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        filteredOrder.namaPemesan,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredOrder.items.length,
                        itemBuilder: (context, i) {
                          final cartItem = filteredOrder.items[i];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${cartItem.qty}x ${cartItem.name} - ${cartItem.variant ?? ''}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                if (cartItem.addons != null && cartItem.addons!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      "+ ${cartItem.addons!.keys.join(', ')}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                if (cartItem.preference.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      "Preference: ${cartItem.preference.values.join(', ')}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                if (cartItem.notes.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      "Note: ${cartItem.notes}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                      const Divider(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "19:25", // Replace with actual time
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
