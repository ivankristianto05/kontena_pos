import 'package:flutter/material.dart';
import 'package:pos_kontena/Screen/components/appbar_section.dart';
import 'package:pos_kontena/Screen/components/buttonfilter_section.dart';
import 'package:pos_kontena/Screen/components/cardmenu_section.dart';
import 'package:pos_kontena/Screen/components/dropdown_delete_section.dart';
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
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  width: screenWidth - searchbarWidth,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
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
                        width: smallButtonWidth,
                        color: Colors.white,
                        child: MaterialButton(
                          height: 65,
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
                DropdownDeleteSection()
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
