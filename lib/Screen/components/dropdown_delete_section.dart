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
  String? Table;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double searchbarWidth = screenWidth * 0.65;

    // Access AppState and Cart
    final appState = Provider.of<AppState>(context, listen: false);
    final cart = Cart(onCartChanged: () => setState(() {}));

    return Container(
      width: screenWidth - searchbarWidth,
      height: 50,
      alignment: Alignment.topRight,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: screenWidth * 0.20,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  top: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  bottom: BorderSide(
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
                        child: Text(
                          value,
                          style: TextStyle(fontWeight: FontWeight.normal),
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
                top: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                bottom: BorderSide(
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
                  value: Table,
                  items: <String>[
                    '1',
                    '2',
                    '3',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value, // Hanya angka yang ditampilkan dalam pilihan dropdown
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      Table = newValue;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return <String>[
                      '1',
                      '2',
                      '3',
                    ].map((String value) {
                      return Text(
                        'Table $value', // Teks "Table" ditambahkan saat item dipilih
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
          Container(
            width: 60,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                top: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
            child: MaterialButton(
              height: 50,
              padding: EdgeInsets.zero,
              onPressed: () {
                // Clear all items from the cart
                setState(() {
                  cart.clearCart();
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
