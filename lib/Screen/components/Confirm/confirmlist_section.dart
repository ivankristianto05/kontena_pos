import 'package:flutter/material.dart';
import 'package:kontena_pos/core/functions/cart.dart';
import 'package:kontena_pos/models/list_to_confirm.dart';
import 'package:kontena_pos/app_state.dart';

class ConfirmList extends StatefulWidget {
  final List<ListToConfirm> listToConfirm;
  final double screenWidth;
  final AppState appState;
  final ValueChanged<bool>? onAllChecked;

  ConfirmList({
    required this.listToConfirm,
    required this.screenWidth,
    required this.appState,
    this.onAllChecked,
  });

  @override
  _ConfirmListState createState() => _ConfirmListState();
}

class _ConfirmListState extends State<ConfirmList> {
  Map<String, bool> checkedItems = {};

  @override
  void initState() {
    super.initState();
    initializeCheckedItems();
  }

  @override
  void didUpdateWidget(covariant ConfirmList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.appState.currentOrderId != oldWidget.appState.currentOrderId) {
      initializeCheckedItems(); // Reinitialize items when switching order IDs
      _checkAllCheckedStatus(); // Automatically check all items' status
    }
  }

  // Initialize checked items for the current order
  void initializeCheckedItems() {
    checkedItems.clear(); // Clear existing checked items map
    for (var order in widget.listToConfirm) {
      if (order.idOrder == widget.appState.currentOrderId) {
        for (var item in order.items) {
          // Use a unique identifier combining order ID and item ID
          String uniqueKey = "${order.idOrder}_${item.id}";
          checkedItems[uniqueKey] = false;
        }
      }
    }
  }

  void _checkAllCheckedStatus() {
    final currentOrderId = widget.appState.currentOrderId;
    final filteredItems = widget.listToConfirm
        .where((order) => order.idOrder == currentOrderId)
        .expand((order) => order.items)
        .toList();

    bool allChecked = filteredItems.every((item) {
      String uniqueKey = "${currentOrderId}_${item.id}";
      return checkedItems[uniqueKey] == true;
    });

    // Update AppState with whether all items are checked for this order
    widget.appState.updateOrderCheckedStatus(currentOrderId, allChecked);

    if (widget.onAllChecked != null) {
      widget.onAllChecked!(allChecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentOrderId = widget.appState.currentOrderId;
    final filteredList = widget.listToConfirm
        .where((order) => order.idOrder == currentOrderId)
        .toList();

    return Container(
      width: widget.screenWidth * 0.3,
      child: filteredList.isEmpty
          ? Center(
              child: Text(
                currentOrderId.isEmpty
                    ? 'No Order Selected'
                    : 'Order ID: $currentOrderId not found',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.separated(
              itemCount: filteredList.length,
              separatorBuilder: (context, index) =>
                  Divider(thickness: 1.5, color: Colors.grey[800]),
              itemBuilder: (context, index) {
                final listItem = filteredList[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < listItem.items.length; i++) ...[
                        if (i > 0)
                          Divider(
                            thickness: 1.0,
                            color: Colors.grey[400],
                          ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${listItem.items[i].name} - (${listItem.items[i].qty})',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Checkbox(
                                value: checkedItems[
                                        "${listItem.idOrder}_${listItem.items[i].id}"] ??
                                    false,
                                onChanged: (bool? value) {
                                  setState(() {
                                    checkedItems[
                                            "${listItem.idOrder}_${listItem.items[i].id}"] =
                                        value ?? false;
                                    _checkAllCheckedStatus();
                                  });
                                  print("Checked Items: $checkedItems");
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${listItem.items[i].name} - ${listItem.items[i].variant ?? ''} (${listItem.items[i].qty})',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        if (listItem.items[i].addons != null &&
                            listItem.items[i].addons!.isNotEmpty)
                          Text(
                            'Addons: ${listItem.items[i].addons!.keys.join(', ')}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        if (listItem.items[i].notes.isNotEmpty)
                          Text(
                            'Notes: ${listItem.items[i].notes}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        if (listItem.items[i].preference.isNotEmpty)
                          Text(
                            'Preference: ${listItem.items[i].preference.values.join(', ')}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        SizedBox(height: 4),
                      ]
                    ],
                  ),
                );
              },
            ),
    );
  }
}
