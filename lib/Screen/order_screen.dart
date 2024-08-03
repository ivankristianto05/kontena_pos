import 'package:flutter/material.dart';
import 'package:pos_kontena/Screen/components/appbar_section.dart';
import 'package:pos_kontena/Screen/components/buttonfilter_section.dart';
import 'package:pos_kontena/Screen/components/cardmenu_section.dart';
import 'package:pos_kontena/Screen/components/footer_section.dart';
import 'package:pos_kontena/Screen/components/itemcart_section.dart';
import 'package:pos_kontena/Screen/components/searchbar_section.dart';
import 'package:pos_kontena/constants.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isWideScreen = screenWidth > 800;

    double searchbarWidth = screenWidth * 0.65;
    double inputGuestNameWidth = screenWidth * 0.25;
    double smallButtonWidth = screenWidth * 0.05;
    double buttonWidth = screenWidth * 0.15;

    return Scaffold(
      appBar: BuildAppbar(
        smallButtonWidth: smallButtonWidth,
        buttonWidth: buttonWidth,
        isWideScreen: isWideScreen,
      ),
      body: Container(
        color: itembackgroundcolor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for Searchbar and Input Guest Name with Buttons
            Row(
              children: [
                // Searchbar
                Container(
                  width: searchbarWidth,
                  child: Searchbar(screenWidth: screenWidth),
                ),
                // Input Guest Name and buttons
                Container(
                  width: screenWidth - searchbarWidth,
                  child: Row(
                    children: [
                      Container(
                        width: inputGuestNameWidth,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Input Guest Name',
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: smallButtonWidth,
                        child: MaterialButton(
                          height: 55,
                          minWidth: 0,
                          onPressed: () {
                            // Handle the action for the search button
                          },
                          child:
                              Icon(Icons.search_outlined, color: Colors.black),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: smallButtonWidth,
                        child: MaterialButton(
                          height: 55,
                          minWidth: 0,
                          onPressed: () {
                            // Handle the action for the person button
                          },
                          child: Icon(Icons.person, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Row for Button Filter and Dropdown with Delete Button
            Row(
              children: [
                // Button Filter
                Container(
                  width: searchbarWidth,
                  child: Row(
                    children: [
                      ButtonFilter(),
                    ],
                  ),
                ),
                // Dropdown and Delete Button
                Container(
                  width: screenWidth - searchbarWidth,
                  height: 50,
                  alignment: Alignment.topRight,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 50,
                          child: DropdownButtonHideUnderline(
                            // Use this to hide the underline
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text("Select an Option"),
                              value: selectedValue,
                              items: <String>[
                                'Option 1',
                                'Option 2',
                                'Option 3',
                                'Option 4'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: smallButtonWidth,
                        height: 50, // Set the height to match the dropdown
                        child: MaterialButton(
                          minWidth: 0,
                          height: 50, // Set the height to match the container
                          onPressed: () {
                            // Handle the action for the delete button
                          },
                          child: Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Row for Menu Cards and Item Cart
            Expanded(
              child: Row(
                children: [
                  // Menu Cards
                  Expanded(
                    flex: 2,
                    child: CardMenu(),
                  ),
                  // Item Cart
                  ItemCart(screenWidth: screenWidth),
                ],
              ),
            ),
            // Footer with Order Button
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: screenWidth * 0.65,
                    child: Footer(screenWidth: screenWidth),
                  ),
                  Container(
                    height: 50,
                    width: screenWidth * 0.35,
                    child: MaterialButton(
                      color: buttoncolor,
                      textColor: Colors.white,
                      onPressed: () {
                        // Handle the action for the order button
                      },
                      child: Text("Order"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
