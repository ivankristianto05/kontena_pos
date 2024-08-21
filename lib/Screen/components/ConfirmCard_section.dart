import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/models/list_to_confirm.dart';

class ConfirmCard extends StatelessWidget {
  const ConfirmCard({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      child: Consumer<AppState>(
        builder: (context, appState, _) {
          if (!appState.isOrderConfirmed) {
            return Center(
              child: Text('No order confirmed yet.'),
            );
          }
          if (appState.confirmedOrders.isEmpty) {
            return Center(
              child: Text('No order available.'),
            );
          }
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Adjust to the number of cards per row
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 2, // Adjust to match the card aspect ratio in the design
                  ),
                  itemCount: appState.confirmedOrders.length,
                  itemBuilder: (context, index) {
                    final order = appState.confirmedOrders[index];
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.zero,
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
                                  order.table,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Draft",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              order.namaPemesan,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
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
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      if (cartItem.addons != null &&
                                          cartItem.addons!.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "+ ${cartItem.addons!.keys.join(', ')}",
                                            style: TextStyle(
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
                            Divider(),
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
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
