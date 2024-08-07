import 'package:flutter/material.dart';
import 'package:kontena_pos/Screen/components/actionbutton_section.dart';
import 'package:kontena_pos/Screen/components/appbar_section.dart';
import 'package:kontena_pos/Screen/components/buttonfilter_section.dart';
import 'package:kontena_pos/Screen/components/cardmenu_section.dart';
import 'package:kontena_pos/Screen/components/dropdown_delete_section.dart';
import 'package:kontena_pos/Screen/components/footer_section.dart';
import 'package:kontena_pos/Screen/components/guestinputwithbutton_section.dart';
import 'package:kontena_pos/Screen/components/itemcart_section.dart';
import 'package:kontena_pos/Screen/components/searchbar_section.dart';
import 'package:kontena_pos/Screen/popup/itemdialog_section.dart';
import 'package:kontena_pos/models/cart_item.dart';
import 'package:kontena_pos/constants.dart';

class OrderScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final void Function(CartItem item) addItemToCart;

  const OrderScreen({
    Key? key,
    required this.cartItems,
    required this.addItemToCart,
  }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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

  void _showItemDetailsDialog(
      String name, String price, String idMenu, String type) {
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

  void _editItemInCart(CartItem editedItem) {
    final index = widget.cartItems.indexWhere((item) => item.idMenu == editedItem.idMenu);
    if (index != -1) {
      setState(() {
        widget.cartItems[index] = editedItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double searchbarWidth = screenWidth * 0.65;
    double smallButtonWidth = screenWidth * 0.05;
    double buttonWidth = screenWidth * 0.15;

    return Scaffold(
      appBar: BuildAppbar(
        smallButtonWidth: smallButtonWidth,
        buttonWidth: buttonWidth,
        isWideScreen: screenWidth > 800,
      ),
      body: Container(
        color: itembackgroundcolor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Searchbar(screenWidth: screenWidth),
                GuestInputWithButton(
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
                  Container(
                    width: screenWidth * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ItemCart(
                      screenWidth: screenWidth,
                      cartItems: widget.cartItems,
                      onEditItem: _editItemInCart,
                    ),
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
                  ActionButton(
                    screenWidth: screenWidth,
                    cartItems: widget.cartItems,
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
