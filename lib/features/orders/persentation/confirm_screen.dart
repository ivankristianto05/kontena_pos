import 'package:flutter/material.dart';
import 'package:kontena_pos/Screen/components/Confirm/ConfirmCard_section.dart';
import 'package:kontena_pos/Screen/components/Confirm/confirmbutton_section.dart';
import 'package:kontena_pos/Screen/components/Confirm/confirmlist_section.dart';
import 'package:kontena_pos/models/list_to_confirm.dart';
import 'package:provider/provider.dart';
import 'package:kontena_pos/Screen/components/Menu/orderutton_section.dart';
import 'package:kontena_pos/Screen/components/appbar_section.dart';
import 'package:kontena_pos/Screen/components/Menu/dropdown_delete_section.dart';
import 'package:kontena_pos/Screen/components/footer_section.dart';
import 'package:kontena_pos/Screen/components/Menu/guestinputwithbutton_section.dart';
import 'package:kontena_pos/Screen/components/Menu/itemcart_section.dart';
import 'package:kontena_pos/Screen/components/searchbar_section.dart';
import 'package:kontena_pos/constants.dart';
import 'package:kontena_pos/core/functions/cart.dart';
import 'package:kontena_pos/app_state.dart';

class ConfirmScreen extends StatefulWidget {
  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final TextEditingController _guestNameController = TextEditingController();
  String _selectedFilterType = 'All';
  String _searchQuery = '';
  bool allItemsChecked = false; // To track if all items are checked

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

    Cart cart = Cart(appState);

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
                    appState.setNamaPemesan(name);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: searchbarWidth,
                ),
                DropdownDeleteSection(),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: screenWidth * 0.65,
                    alignment: Alignment.topLeft,
                    child: ConfirmCard(
                      screenWidth: screenWidth,
                      onOrderSelected: (orderId) {
                        appState.setCurrentOrderId(orderId);
                        appState.printCurrentOrderId();
                      },
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ConfirmList(
                      listToConfirm: appState.confirmedOrders,
                      screenWidth: screenWidth,
                      appState: appState,
                      onAllChecked: (bool isChecked) {
                        setState(() {
                          allItemsChecked = isChecked;
                        });
                      },
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
                  ConfirmButton(
                    screenWidth: screenWidth,
                    isEnabled: allItemsChecked,
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
