import 'package:flutter/material.dart';
import 'package:pos_kontena/Screen/components/searchbar_section.dart';
import 'package:pos_kontena/Screen/popup/itemdialog_section.dart';
import 'package:pos_kontena/models/cart_item.dart';
import 'package:pos_kontena/Screen/components/actionbutton_section.dart';
import 'package:pos_kontena/Screen/components/appbar_section.dart';
import 'package:pos_kontena/Screen/components/buttonfilter_section.dart';
import 'package:pos_kontena/Screen/components/cardmenu_section.dart';
import 'package:pos_kontena/Screen/components/dropdown_delete_section.dart';
import 'package:pos_kontena/Screen/components/footer_section.dart';
import 'package:pos_kontena/Screen/components/guestinputwithbutton_section.dart';
import 'package:pos_kontena/Screen/components/cart_section.dart';
import 'package:pos_kontena/constants.dart';

class OrderPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final void Function(CartItem item) addItemToCart;

  const OrderPage({
    Key? key,
    required this.cartItems,
    required this.addItemToCart,
  }) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final TextEditingController _guestNameController = TextEditingController();

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

  void _showItemDetailsDialog(String name, String price, String idMenu, String type) {
    showDialog(
      context: context,
      builder: (context) => ItemDetailsDialog(
        name: name,
        price: price,
        idMenu: idMenu,
        type: type,
        onAddToCart: widget.addItemToCart,
      ),
    );
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
            Row(
              children: [
                Container(
                  width: searchbarWidth,
                  child: Searchbar(screenWidth: screenWidth),
                ),
                GuestInputWithButton(
                  screenWidth: screenWidth,
                  searchbarWidth: searchbarWidth,
                  guestNameController: _guestNameController,
                  smallButtonWidth: smallButtonWidth,
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: searchbarWidth,
                  child: Row(
                    children: [
                      ButtonFilter(),
                    ],
                  ),
                ),
                DropdownDeleteSection()
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CardMenu(
                      onMenuTap: (name, price, idMenu, type) {
                        _showItemDetailsDialog(name, price, idMenu, type);
                      },
                    ),
                  ),
                  Cart(
                      screenWidth: screenWidth,
                      cartItems: widget.cartItems,
                    ),
                ],
              ),
            ),
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
      )
    );
  }
}
