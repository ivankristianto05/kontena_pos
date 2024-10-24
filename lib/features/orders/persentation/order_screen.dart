import 'dart:async';

import 'package:kontena_pos/core/api/frappe_thunder_pos/item.dart'
    as frappeFetchDataItem;
import 'package:kontena_pos/core/api/frappe_thunder_pos/item_group.dart'
    as frappeFetchDataItemGroup;
import 'package:kontena_pos/core/api/frappe_thunder_pos/item_price.dart'
    as frappeFetchDataItemPrice;
import 'package:kontena_pos/core/api/frappe_thunder_pos/create_pos_cart.dart'
    as frappeFetchDataCart;
import 'package:kontena_pos/core/api/frappe_thunder_pos/pos_cart.dart'
    as frappeFetchDataGetCart;
import 'package:kontena_pos/core/api/frappe_thunder_pos/create_pos_order.dart'
    as frappeFetchDataOrder;
import 'package:kontena_pos/core/api/frappe_thunder_pos/pos_order.dart'
    as frappeFetchDataGetOrder;

import 'package:flutter/material.dart';
import 'package:kontena_pos/core/functions/reformat_item_with_price.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/core/utils/datetime_ui.dart';
import 'package:kontena_pos/features/orders/Screen/popup/itemdialog_section.dart';
import 'package:kontena_pos/widgets/dropdown_delete.dart';
import 'package:kontena_pos/widgets/filter_bar.dart';
import 'package:kontena_pos/widgets/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:kontena_pos/features/orders/Screen/components/Menu/orderbutton_section.dart';
import 'package:kontena_pos/features/orders/Screen/components/Menu/cardmenu_section.dart';
import 'package:kontena_pos/features/orders/Screen/components/footer_section.dart';
import 'package:kontena_pos/features/orders/Screen/components/Menu/guestinput_section.dart';
import 'package:kontena_pos/features/orders/Screen/components/Menu/itemcart_section.dart';
import 'package:kontena_pos/features/orders/Screen/components/searchbar_section.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/constants.dart';
import 'package:kontena_pos/core/functions/cart.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _guestNameController = TextEditingController();
  String _selectedFilterType = 'All';
  String _searchQuery = '';
  String? table;
  String? pickupType;
  bool isLoading = true;
  List<dynamic> itemDisplay = [];
  List<dynamic> tempPosCart = [];
  List<dynamic> tempPosOrder = [];

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
    return Consumer<AppState>(
      builder: (context, appState, child) {
        double screenWidth = MediaQuery.of(context).size.width;
        double searchbarWidth = screenWidth * 0.65;
        double smallButtonWidth = screenWidth * 0.05;
        double buttonWidth = screenWidth * 0.15;

        Cart cart = Cart(appState);

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: theme.colorScheme.background,
          body: Container(
            color: itembackgroundcolor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBar(
                  isSelected: 'order',
                ),
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
                      child: Row(
                        children: [
                          FilterBar(onFilterSelected: _handleFilterSelected),
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth - searchbarWidth,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1),
                          top: BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                      child: DropdownDelete(),
                    ),
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
                        decoration: BoxDecoration(color: Colors.white),
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
      },
    );
  }
  void onCallItemGroup() async {
    // isLoading = true;

    final frappeFetchDataItemGroup.ItemGroupRequest requestItemGroup =
        frappeFetchDataItemGroup.ItemGroupRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: '[]',
    );

    try {
      final itemGroupRequset = await frappeFetchDataItemGroup
          .requestItemGroup(requestQuery: requestItemGroup)
          .timeout(
            Duration(seconds: 30),
          );

      setState(() {
        AppState().dataItemGroup = itemGroupRequset;
        // itemDisplay = itemGroupRequset;
        isLoading = false;
      });
    } catch (error) {
      isLoading = false;
      if (error is TimeoutException) {
        // Handle timeout error
        // _bottomScreenTimeout(context);
      } else {
        print(error);
      }
      return;
    }
  }

  void onCallItemPrice() async {
    String? today = dateTimeFormat('date', null);
    final frappeFetchDataItemPrice.ItemPriceRequest requestItemPrice =
        frappeFetchDataItemPrice.ItemPriceRequest(
      cookie: AppState().setCookie,
      filters: '[["selling","=",1],["valid_from","<=","$today"]]',
      limit: 5000,
    );

    try {
      // Add a timeout of 30 seconds to the profile request
      final itemPriceRequest = await frappeFetchDataItemPrice
          .requestItemPrice(requestQuery: requestItemPrice)
          .timeout(
            Duration(seconds: 30),
          );

      // print("item price request: $itemPriceRequest");
      setState(() {
        AppState().dataItemPrice = itemPriceRequest;
        // itemDisplay = reformatItem(itemPriceRequest);
      });
    } catch (error) {
      isLoading = false;
      if (error is TimeoutException) {
        // Handle timeout error
        // _bottomScreenTimeout(context);
      } else {
        print(error);
      }
      return;
    }
  }

   void onCallItem() async {
    isLoading = true;

    final frappeFetchDataItem.ItemRequest requestItem =
        frappeFetchDataItem.ItemRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: '[["disabled","=",0],["is_sales_item","=",1]]',
      limit: 1500,
    );

    try {
      // Add a timeout of 30 seconds to the profile request
      final itemRequest = await frappeFetchDataItem
          .requestItem(requestQuery: requestItem)
          .timeout(
            Duration(seconds: 30),
          );

      // print("titiew: $itemRequset");
      setState(() {
        AppState().dataItem = ReformatItemWithPrice(
          itemRequest,
          AppState().dataItemPrice,
        );
        itemDisplay = AppState().dataItem;
      });
      // AppState().userDetail = profileResult;
    } catch (error) {
      isLoading = false;
      if (error is TimeoutException) {
        // Handle timeout error
        // _bottomScreenTimeout(context);
      } else {
        print(error);
      }
      return;
    }
  }

  onCallDataPosCart() async {
    final frappeFetchDataGetCart.PosCartRequest request =
        frappeFetchDataGetCart.PosCartRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: '[]',
      limit: 1500,
    );

    try {
      final callRequest =
          await frappeFetchDataGetCart.requestPosCart(requestQuery: request);

      if (callRequest.isNotEmpty) {
        setState(() {
          tempPosCart = callRequest;
        });
      }
    } catch (error) {
      print('error call data pos cart, $error');
    }
  }

  onCallDataPosOrder() async {
    final frappeFetchDataGetOrder.PosOrderRequest request =
        frappeFetchDataGetOrder.PosOrderRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: '[]',
      limit: 2000,
    );

    try {
      final callRequest =
          await frappeFetchDataGetOrder.requestPosOrder(requestQuery: request);

      if (callRequest.isNotEmpty) {
        setState(() {
          tempPosOrder = callRequest;
        });
      }
    } catch (error) {
      print('error call data pos order, $error');
    }
  }
}