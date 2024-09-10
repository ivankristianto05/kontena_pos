import 'package:flutter/material.dart';
import 'package:kontena_pos/constants.dart';
import 'package:provider/provider.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
            child: AutoSizeText('No order inputted.'),
          );
        }
        if (appState.confirmedOrders.isEmpty) {
          return const Center(
            child: AutoSizeText('No order available.'),
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
                                AutoSizeText(
                                  'Table ${order.table}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  minFontSize: 10,
                                  maxFontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                AutoSizeText(
                                  appState.formatDateTime(order.time), // Use formatted date here
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                  maxLines: 1,
                                  minFontSize: 10,
                                  maxFontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            AutoSizeText(
                              order.namaPemesan,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              minFontSize: 12,
                              maxFontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            // Remove ConstrainedBox and use Column instead
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.separated(
                                  separatorBuilder: (context, index) => const Divider(
                                    height: 16,
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: order.items.length,
                                  itemBuilder: (context, i) {
                                    final cartItem = order.items[i];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${cartItem.qty}x",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(width: 8), // Space between qty and name
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                  "${cartItem.name} - ${cartItem.variant ?? ''}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  maxLines: 2, // Allows up to 2 lines
                                                  minFontSize: 10,
                                                  maxFontSize: 14,
                                                  overflow: TextOverflow.ellipsis, // Ellipsis if it exceeds 2 lines
                                                ),
                                                if (cartItem.preference != null) ...[
                                                  const SizedBox(height: 4),
                                                  AutoSizeText(
                                                    "Preference: ${cartItem.preference.values.join(', ')}",
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                    maxLines: 1,
                                                    minFontSize: 10,
                                                    maxFontSize: 12,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                                if (cartItem.addons != null && cartItem.addons!.isNotEmpty) ...[
                                                  const SizedBox(height: 4),
                                                  AutoSizeText(
                                                    "+ ${cartItem.addons!.keys.join(', ')}",
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                    maxLines: 1,
                                                    minFontSize: 10,
                                                    maxFontSize: 12,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                                if (cartItem.notes != null) ...[
                                                  const SizedBox(height: 4),
                                                  AutoSizeText(
                                                    "Notes: ${cartItem.notes}",
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                    maxLines: 2,
                                                    minFontSize: 10,
                                                    maxFontSize: 12,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8), // Space between name and status
                                          AutoSizeText(
                                            order.status,
                                            style: TextStyle(
                                              color: order.status == 'Confirmed' ? Colors.red : Colors.grey,
                                            ),
                                            maxLines: 1,
                                            minFontSize: 10,
                                            maxFontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
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
