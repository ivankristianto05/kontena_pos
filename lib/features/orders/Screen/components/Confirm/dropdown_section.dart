import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/functions/cart.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? pickupType;
  String? table;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appState = Provider.of<AppState>(context, listen: true);

    // Update the table value based on the current selected table from AppState
    setState(() {
      final fetchedTable = appState.getTableForCurrentOrder();
      // Jika table adalah '', set nilai table menjadi null
      table = fetchedTable.isNotEmpty ? fetchedTable : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double searchbarWidth = screenWidth * 0.65;

    // Access AppState and Cart
    final appState = Provider.of<AppState>(context);
    final cart = Cart(onCartChanged: () => setState(() {}));

    // Define table options
    final List<String> tableOptions = <String>[
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
    ];

    // Check if order ID is selected
    final hasOrderId = appState.currentOrderId.isNotEmpty;

    return Container(
      width: screenWidth * 0.2,
      height: 50,
      alignment: Alignment.topRight,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: screenWidth * 0.10,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              height: 50,
              child: DropdownButtonHideUnderline(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text("Select an Option"),
                    value: pickupType,
                    items: <String>[
                      'Dine in',
                      'Take away',
                      'Gojek',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                          child: Text(
                            value,
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        pickupType = newValue;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: screenWidth * 0.10,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
            height: 50,
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text("Table"),
                  value: table, // Use the value stored in the state
                  items: hasOrderId
                      ? tableOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(
                                'Table $value',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        }).toList()
                      : [], // Empty list when no order ID is selected
                  onChanged: (String? newValue) {
                    setState(() {
                      table = newValue;
                    });
                    if (newValue != null) {
                      appState.setSelectedTable(
                          newValue); // Save selected table to AppState
                    }
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return hasOrderId
                        ? tableOptions.map((String value) {
                            return Center(
                              child: Text(
                                'Table $value',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            );
                          }).toList()
                        : []; // Empty list when no order ID is selected
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
