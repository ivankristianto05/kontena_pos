import 'package:flutter/material.dart';
// <<<<<<< HEAD
// import 'package:kontena_pos/Screen/components/appbar_section.dart';
// import 'package:kontena_pos/Screen/components/buttonfilter_section.dart';
// import 'package:kontena_pos/Screen/components/cardmenu_section.dart';
// import 'package:kontena_pos/Screen/components/dropdown_delete_section.dart';
// import 'package:kontena_pos/Screen/components/footer_section.dart';
// import 'package:kontena_pos/Screen/components/itemcart_section.dart';
// import 'package:kontena_pos/Screen/components/searchbar_section.dart';
// import 'package:kontena_pos/constants.dart';

import 'package:kontena_pos/Screen/components/actionbutton_section.dart';
import 'package:kontena_pos/Screen/components/appbar_section.dart';
import 'package:kontena_pos/Screen/components/buttonfilter_section.dart';
import 'package:kontena_pos/Screen/components/cardmenu_section.dart';
import 'package:kontena_pos/Screen/components/dropdown_delete_section.dart';
import 'package:kontena_pos/Screen/components/footer_section.dart';
import 'package:kontena_pos/Screen/components/guestinputwithbutton_section.dart';
import 'package:kontena_pos/Screen/components/itemcart_section.dart';
import 'package:kontena_pos/Screen/components/searchbar_section.dart';
import 'package:kontena_pos/constants.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final TextEditingController _guestNameController = TextEditingController();
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    _guestNameController.addListener(_updateState);
  }

  @override
  void dispose() {
    _guestNameController.removeListener(_updateState);
    _guestNameController.dispose();
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

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
                GuestInputWithButton(
                    screenWidth: screenWidth,
                    searchbarWidth: searchbarWidth,
                    guestNameController: _guestNameController,
                    smallButtonWidth: smallButtonWidth),
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
                  ActionButton(screenWidth: screenWidth),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
