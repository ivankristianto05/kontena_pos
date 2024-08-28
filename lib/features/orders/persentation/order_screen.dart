import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kontena_pos/Screen/components/Menu/orderbutton_section.dart';
import 'package:kontena_pos/Screen/components/appbar_section.dart';
import 'package:kontena_pos/Screen/components/Menu/buttonfilter_section.dart';
import 'package:kontena_pos/Screen/components/Menu/cardmenu_section.dart';
import 'package:kontena_pos/Screen/components/Menu/dropdown_delete_section.dart';
import 'package:kontena_pos/Screen/components/footer_section.dart';
import 'package:kontena_pos/Screen/components/Menu/guestinputwithbutton_section.dart';
import 'package:kontena_pos/Screen/components/Menu/itemcart_section.dart';
import 'package:kontena_pos/Screen/components/searchbar_section.dart';
import 'package:kontena_pos/Screen/popup/itemdialog_section.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/constants.dart';
import 'package:kontena_pos/core/functions/cart.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final TextEditingController _guestNameController = TextEditingController();
  String _selectedFilterType = 'All';
  String _searchQuery = '';
  String? table;
  String? pickupType;

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
      String name, int price, String idMenu, String type) {
    showDialog(
      context: context,
      builder: (context) {
        return ItemDetailsDialog(
          name: name,
          price: price,
          idMenu: idMenu,
          type: type,
        );
      },
    );
  }

  void _handleFilterSelected(String type) {
    setState(() {
      _selectedFilterType = type;
    });
  }

  void _handleSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double searchbarWidth = screenWidth * 0.65;
    double smallButtonWidth = screenWidth * 0.05;
    double buttonWidth = screenWidth * 0.15;

    // Create an instance of Cart and pass AppState to it
    Cart cart = Cart();

    return Scaffold(
      appBar: BuildAppbar(
        smallButtonWidth: smallButtonWidth,
        buttonWidth: buttonWidth,
      ),
      body: Container(
        color: itembackgroundcolor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 55,
                  child: Searchbar(
                    screenWidth: searchbarWidth,
                    onSearchChanged: _handleSearchChanged,
                  ),
                ),
                GuestInputWithButton(
                  screenWidth: screenWidth,
                  guestNameController: _guestNameController,
                  smallButtonWidth: smallButtonWidth,
                  onNameSubmitted: (name) {
                    // Update AppState with the guest name
                    appState.setNamaPemesan(name);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: searchbarWidth,
                  child: Row(
                    children: [
                      ButtonFilter(onFilterSelected: _handleFilterSelected),
                    ],
                  ),
                ),
                Container(
                    width: screenWidth - searchbarWidth,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          top: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          )),
                    ),
                    child: DropdownDeleteSection(
                    )),
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
                      filterType: _selectedFilterType,
                      searchQuery: _searchQuery,
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ItemCart(
                      cartItems: appState.cartItems,
                      screenWidth: screenWidth,
                      onEditItem: (editedItem) {
                        final index = appState.cartItems
                            .indexWhere((item) => item.id == editedItem.id);
                        if (index != -1) {
                          setState(() {
                            appState.cartItems[index] = editedItem;
                          });
                        }
                      },
                      appState: appState,
                      cart: cart,
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
                    cart: cart,
                    guestNameController: _guestNameController,
                    resetDropdown: () {
                      setState(() {
                        table = null;
                        pickupType = null;
                      });
                    },
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
