import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:kontena_pos/app_state.dart';

class ConfirmCard extends StatefulWidget {
  const ConfirmCard({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  _ConfirmCardState createState() => _ConfirmCardState();
}

class _ConfirmCardState extends State<ConfirmCard> {
  final List<GlobalKey> _cardKeys = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appState = Provider.of<AppState>(context, listen: false);
      _logMaxCardHeights(appState);
    });
  }

  void _logMaxCardHeights(AppState appState) {
    final rowCount = (appState.confirmedOrders.length / getColumnCount()).ceil();
    for (int rowIndex = 0; rowIndex < rowCount; rowIndex++) {
      final cardKeysInRow = _cardKeys.skip(rowIndex * getColumnCount()).take(getColumnCount()).toList();
      final heights = cardKeysInRow.map((key) => key.currentContext?.size?.height ?? 0.0).toList();
      final maxHeight = heights.isEmpty ? 0.0 : heights.reduce((a, b) => a > b ? a : b);
      print('Max height for row ${rowIndex + 1}: $maxHeight');
    }
  }

  int getColumnCount() {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = widget.screenWidth >= 600;
    return isTablet ? 3 : (isLandscape ? 3 : 1);
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    if (!appState.isOrderConfirmed) {
      return const Center(
        child: Text('No order confirmed yet.'),
      );
    }
    if (appState.confirmedOrders.isEmpty) {
      return const Center(
        child: Text('No order available.'),
      );
    }

    // Create a list of keys for each card
    if (_cardKeys.length != appState.confirmedOrders.length) {
      _cardKeys.clear();
      _cardKeys.addAll(List.generate(appState.confirmedOrders.length, (_) => GlobalKey()));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StaggeredGrid.count(
        crossAxisCount: getColumnCount(),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: List.generate(appState.confirmedOrders.length, (index) {
          final order = appState.confirmedOrders[index];
          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: Align(
              alignment: Alignment.topLeft,
              child: Card(
                key: _cardKeys[index], // Assign a unique key to each card
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
                            order.table,
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
                        order.namaPemesan,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
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
          );
        }),
      ),
    );
  }
}
