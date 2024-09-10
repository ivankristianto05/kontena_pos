import 'package:flutter/material.dart';
import 'package:kontena_pos/core/functions/cart.dart';
import 'package:kontena_pos/models/list_to_confirm.dart';
import 'package:kontena_pos/app_state.dart';

class ConfirmList extends StatefulWidget {
  final List<ListToConfirm> listToConfirm;
  final double screenWidth;
  final AppState appState;
  final ValueChanged<bool>? onAllChecked; // Optional

  ConfirmList({
    required this.listToConfirm,
    required this.screenWidth,
    required this.appState,
    this.onAllChecked, // Optional
  });

  @override
  _ConfirmListState createState() => _ConfirmListState();
}

class _ConfirmListState extends State<ConfirmList> {
  Map<String, bool> checkedItems = {};

  void _checkAllCheckedStatus() {
    final currentOrderId = widget.appState.currentOrderId;
    final allChecked = widget.listToConfirm
        .firstWhere((order) => order.idOrder == currentOrderId)
        .items
        .every((item) => checkedItems['${currentOrderId}-${item.id}'] ?? false);
    if (widget.onAllChecked != null) {
      widget.onAllChecked!(allChecked);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final currentOrderId = widget.appState.currentOrderId;
      if (currentOrderId.isNotEmpty) {
        // Load the saved item checked statuses
        await widget.appState.loadAndSetItemCheckedStatuses(currentOrderId);
        setState(() {
          checkedItems = widget.appState.getItemCheckedStatuses(currentOrderId);
        });
      }
    });
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
                                value: widget.appState.isItemChecked(
                                    currentOrderId, listItem.items[i].id),
                                onChanged: (bool? value) {
                                  setState(() {
                                    // Memperbarui status centang menggunakan AppState
                                    widget.appState.setItemCheckedStatus(
                                      currentOrderId,
                                      listItem.items[i].id,
                                      value ?? false,
                                    );
                                    // Periksa kembali status 'checked' untuk semua item setelah perubahan
                                    _checkAllCheckedStatus();
                                  });
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Addons:',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              ...listItem.items[i].addons!.entries
                                  .where((addon) =>
                                      addon.value['selected'] == true)
                                  .map((addon) => Text('${addon.key}',
                                      style: TextStyle(fontSize: 14))),
                            ],
                          ),
                        if (listItem.items[i].preference['preference'] !=
                                null &&
                            listItem
                                .items[i].preference['preference']!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Preference:',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(listItem.items[i].preference['preference']!,
                                  style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        if (listItem.items[i].notes.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Notes:',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(listItem.items[i].notes,
                                  style: TextStyle(fontSize: 14)),
                            ],
                          ),
                      ],
                    ],
                  ),
                );
              },
            ),
    );
  }
}
