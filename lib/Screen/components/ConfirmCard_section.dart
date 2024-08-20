import 'package:flutter/material.dart';
import 'package:kontena_pos/models/list_to_confirm.dart';

class ListConfirmCard extends StatelessWidget {
  const ListConfirmCard({
    super.key,
    required this.screenWidth,
    required this.order,
  });

  final double screenWidth;
  final ListToConfirm order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.65,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Adjust this based on your needs
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5, // Adjust to control the height/width ratio
        ),
        itemCount: order.items.length,
        itemBuilder: (context, index) {
          final cartItem = order.items[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "09:00", // Replace with your dynamic time
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
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
                  Column(
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
                      SizedBox(height: 8),
                    ],
                  ),
                  Divider(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Draft",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
