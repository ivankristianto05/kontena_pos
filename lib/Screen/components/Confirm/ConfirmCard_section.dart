import 'package:flutter/material.dart';
import 'package:kontena_pos/constants.dart';
import 'package:provider/provider.dart';
import 'package:kontena_pos/app_state.dart';

class ConfirmCard extends StatelessWidget {
  const ConfirmCard({
    super.key,
    required this.screenWidth,
    required this.onOrderSelected,
  });

  final double screenWidth;
  final void Function(String orderId) onOrderSelected;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        if (!appState.isOrderConfirmed) {
          return const Center(
            child: Text('No order inputed.'),
          );
        }
        if (appState.confirmedOrders.isEmpty) {
          return const Center(
            child: Text('No order available.'),
          );
        }

        final cardWidth = (screenWidth * 0.65) / 3 - 20;
        final currentOrderId = appState.currentOrderId; // Assume currentOrderId is managed by AppState

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(appState.confirmedOrders.length, (index) {
                final order = appState.confirmedOrders[index];
                final isSelected = order.idOrder == currentOrderId;

                return GestureDetector(
                  onTap: () {
                    appState.setCurrentOrderId(order.idOrder); // Update the currentOrderId in AppState
                    onOrderSelected(order.idOrder);
                  },
                  child: SizedBox(
                    width: cardWidth,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: isSelected ? buttonselectedcolor : Colors.transparent,
                          width: 4,
                        ),
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
                                  'Table ${order.table}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  order.status, // Display the order's status
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              order.namaPemesan,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 200, // Ensure consistent card height
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: order.items.length,
                                itemBuilder: (context, i) {
                                  final cartItem = order.items[i];
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
                            ),
                            const Divider(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "19:25", // Replace with actual time if available
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
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
