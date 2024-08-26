import 'package:flutter/material.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/functions/cart.dart';
import 'package:provider/provider.dart';
import 'package:kontena_pos/constants.dart';

class DropdownDeleteSection extends StatefulWidget {
  const DropdownDeleteSection({super.key});

  @override
  _DropdownDeleteSectionState createState() => _DropdownDeleteSectionState();
}

class _DropdownDeleteSectionState extends State<DropdownDeleteSection> {
  String? pickupType;
  String? table;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double searchbarWidth = screenWidth * 0.65;
    double dropdownWidth = (screenWidth - searchbarWidth - 32) / 2; // Adjust width for two columns with spacing

    // Access AppState and Cart
    final appState = Provider.of<AppState>(context, listen: false);
    final cart = Cart(appState, onCartChanged: () => setState(() {}));

    return Container(
      width: screenWidth - searchbarWidth,
      height: 50,
      alignment: Alignment.centerRight, // Center the content horizontally
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the row contents
        children: [
          Container(
            width: screenWidth * 0.20,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
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
                      child: Center( // Center the text inside the dropdown
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
          Container(
            width: screenWidth * 0.10,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text("Table"),
                  value: table,
                  items: <String>[
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
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center( // Center the text inside the dropdown
                        child: Text(
                          value,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      table = newValue;
                    });
                    if (newValue != null) {
                      appState.setSelectedTable(newValue); // Save selected table to AppState
                    }
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return <String>[
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
                    ].map((String value) {
                      return Center( // Center the text inside the selected item
                        child: Text(
                          'Table $value',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
          Container(
            width: screenWidth*0.05,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
            child: MaterialButton(
              height: 50,
              padding: EdgeInsets.zero,
              onPressed: () {
                // Clear all items from the cart
                setState(() {
                  cart.clearAllItems();
                });
              },
              child: Icon(Icons.delete, color: redcolor),
            ),
          ),
        ],
      ),
    );
  }
}
