import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kontena_pos/core/api/frappe_thunder_pos/item.dart'
    as FrappeFetchDataItem;
import 'package:kontena_pos/core/api/frappe_thunder_pos/item_group.dart'
    as FrappeFetchDataItemGroup;
import 'package:kontena_pos/core/api/frappe_thunder_pos/item_price.dart'
    as FrappeFetchDataItemPrice;
import 'package:kontena_pos/core/api/frappe_thunder_pos/pos_cart.dart'
    as FrappeFetchDataGetCart;
import 'package:kontena_pos/core/api/frappe_thunder_pos/pos_order.dart'
    as FrappeFetchDataGetOrder;
import 'package:kontena_pos/core/api/frappe_thunder_pos/create_pos_cart.dart'
    as FrappeFetchCreateCart;
import 'package:kontena_pos/core/api/frappe_thunder_pos/create_pos_order.dart'
    as FrappeFetchCreateOrder;

import 'package:flutter/material.dart';
import 'package:kontena_pos/core/app_export.dart';
import 'package:kontena_pos/core/functions/order_new.dart';
import 'package:kontena_pos/core/functions/reformat_item_with_price.dart';
import 'package:kontena_pos/core/theme/custom_text_style.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/core/utils/alert.dart';
import 'package:kontena_pos/core/utils/datetime_ui.dart';
import 'package:kontena_pos/core/utils/number_ui.dart';
import 'package:kontena_pos/features/cart/persentation/add_to_cart.dart';
import 'package:kontena_pos/features/orders/persentation/bottom_navigation.dart';
import 'package:kontena_pos/features/products/persentation/product_grid.dart';
import 'package:kontena_pos/widgets/custom_dialog.dart';
import 'package:kontena_pos/widgets/empty_cart.dart';
import 'package:kontena_pos/widgets/filter_bar.dart';
import 'package:kontena_pos/widgets/searchbar.dart';
import 'package:kontena_pos/widgets/top_bar.dart';
import 'package:kontena_pos/widgets/type_transaction.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:styled_divider/styled_divider.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  OrderCart cart = OrderCart();
  late Map cartRecapData;
  late List<OrderCartItem> cartData;
  TextEditingController enterGuestNameController =
      TextEditingController();
  String? table;
  String? pickupType;
  String typeTransaction = 'dine-in';
  String modeView = 'order';

  bool isLoading = true;

  List<dynamic> itemDisplay = [];
  List<dynamic> orderDisplay = [];
  List<dynamic> tempPosCart = [];
  List<dynamic> tempPosOrder = [];

  dynamic cartSelected;
  dynamic orderCartSelected;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    cartData = cart.getAllItemCart();
  }

  @override
  void initState() {
    super.initState();
    // enterGuestNameController.addListener(_updateState);
    onTapRefresh();

    setState(() {
      cartData = cart.getAllItemCart();
      AppState().typeTransaction = 'dine-in';
      typeTransaction = 'dine-in';
    });

    print('check cartdata, $cartData');
  }

  @override
  void dispose() {
    // enterGuestNameController.removeListener(_updateState);
    // enterGuestNameController.dispose();
    super.dispose();
  }

  // void _updateState() {
  //   setState(() {});
  // }

  // void _showItemDetailsDialog(
  //     String name, int price, String idMenu, String type) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return ItemDetailsDialog(
  //         name: name,
  //         price: price,
  //         idMenu: idMenu,
  //         type: type,
  //       );
  //     },
  //   );
  // }

  // void _handleFilterSelected(String type) {
  //   setState(() {
  //     _selectedFilterType = type;
  //   });
  // }

  // void _handleSearchChanged(String query) {
  //   setState(() {
  //     _searchQuery = query;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            TopBar(
              isSelected: 'order',
              onTapRefresh: () {
                onTapRefresh();
              },
            ),
            Expanded(
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Searchbar(
                                  onCompleted: () {},
                                ),
                              ],
                            ),
                            if (modeView == 'order')
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 60.0, 8.0, 8.0),
                                child: FilterBar(
                                  onFilterSelected: (String type) {},
                                ),
                              ),
                            if (modeView == 'order')
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 120.0, 8.0, 0.0),
                                child: Align(
                                  alignment: AlignmentDirectional(0.00, 0.00),
                                  child: SingleChildScrollView(
                                    child: (isLoading == false &&
                                            itemDisplay.isEmpty)
                                        ? SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: Skeletonizer(
                                              enabled: isLoading,
                                              child: Container(),
                                            ),
                                          )
                                        : SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            child: Column(
                                              children: [
                                                MasonryGridView.count(
                                                  crossAxisCount: 5,
                                                  mainAxisSpacing: 6,
                                                  crossAxisSpacing: 6,
                                                  shrinkWrap: true,
                                                  itemCount: itemDisplay.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final currentItem =
                                                        itemDisplay[index];
                                                    return ProductGrid(
                                                      name: currentItem[
                                                              'item_name'] ??
                                                          '',
                                                      category: currentItem[
                                                              'item_group'] ??
                                                          '',
                                                      price: numberFormat(
                                                          'idr',
                                                          currentItem[
                                                              'standard_rate']),
                                                      image: CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgAdl1,
                                                        height: 90.v,
                                                        width: 70.h,
                                                        margin: EdgeInsets.only(
                                                            bottom: 1.v),
                                                      ),
                                                      onTap: () {
                                                        onTapOpenItem(
                                                          context,
                                                          currentItem,
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            if (modeView == 'confirm')
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8.0, 50.0, 8.0, 0.0),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        AlignedGridView.count(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 6,
                                          crossAxisSpacing: 6,
                                          shrinkWrap: true,
                                          itemCount: orderDisplay.length,
                                          itemBuilder: (context, index) {
                                            final order = orderDisplay[index];
                                            dynamic orderItemList =
                                                order['items'];
                                            return InkWell(
                                              onTap: () {
                                                addToCartFromOrder(
                                                    context, order);
                                              },
                                              child: Card(
                                                elevation: 2,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                        16.0,
                                                        16.0,
                                                        16.0,
                                                        10.0,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                order['name'],
                                                                style: theme
                                                                    .textTheme
                                                                    .titleMedium,
                                                              ),
                                                              Text(
                                                                'Table ${order['table']}',
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                order['customer_name']
                                                                    .toString(),
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                              0.0,
                                                              4.0,
                                                              0.0,
                                                              4.0,
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  dateTimeFormat(
                                                                    'dateui',
                                                                    order[
                                                                        'date'],
                                                                  ).toString(),
                                                                  style: theme
                                                                      .textTheme
                                                                      .labelSmall,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Divider(
                                                            height: 5.0,
                                                            thickness: 0.5,
                                                            color: theme
                                                                .colorScheme
                                                                .outline,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                              0.0,
                                                              4.0,
                                                              0.0,
                                                              4.0,
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                ListView
                                                                    .separated(
                                                                  separatorBuilder:
                                                                      (context,
                                                                              index) =>
                                                                          Divider(
                                                                    height: 12,
                                                                    thickness:
                                                                        0.5,
                                                                    color: theme
                                                                        .colorScheme
                                                                        .outline,
                                                                  ),
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      const NeverScrollableScrollPhysics(),
                                                                  itemCount:
                                                                      orderItemList
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          idx) {
                                                                    dynamic
                                                                        orderItem =
                                                                        orderItemList[
                                                                            idx];
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "${orderItem['quantity']}",
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 8),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                AutoSizeText(
                                                                                  "${orderItem['item_name']} - ${orderItem['variant'] ?? ''}",
                                                                                  style: theme.textTheme.titleMedium,
                                                                                  maxLines: 2, // Allows up to 2 lines
                                                                                  minFontSize: 10,
                                                                                  maxFontSize: 14,
                                                                                  overflow: TextOverflow.ellipsis, // Ellipsis if it exceeds 2 lines
                                                                                ),
                                                                                // if ((orderItem['preference'] != null) && (orderItem['preference'] != null)) const SizedBox(height: 4),
                                                                                // AutoSizeText(
                                                                                //   "Preference: ${orderItem['preference']}",
                                                                                //   style: theme.textTheme.labelSmall,
                                                                                //   maxLines: 1,
                                                                                //   minFontSize: 10,
                                                                                //   maxFontSize: 12,
                                                                                //   overflow: TextOverflow.ellipsis,
                                                                                // ),
                                                                                // if (orderItem['addons'] != null && orderItem['addons']!.isNotEmpty) const SizedBox(height: 4),
                                                                                // AutoSizeText(
                                                                                //   "+ ${orderItem['addons']!.keys.join(', ')}",
                                                                                //   style: theme.textTheme.labelSmall,
                                                                                //   maxLines: 1,
                                                                                //   minFontSize: 10,
                                                                                //   maxFontSize: 12,
                                                                                //   overflow: TextOverflow.ellipsis,
                                                                                // ),
                                                                                if ((orderItem['note'] != null) && (orderItem['note'] != '')) const SizedBox(height: 4),
                                                                                AutoSizeText(
                                                                                  "Notes: ${orderItem['note']}",
                                                                                  style: theme.textTheme.labelSmall,
                                                                                  maxLines: 2,
                                                                                  minFontSize: 10,
                                                                                  maxFontSize: 12,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            (orderItem['docstatus'] == 1)
                                                                                ? 'Confirm'
                                                                                : 'Draft',
                                                                            style: (orderItem['docstatus'] != 1)
                                                                                ? TextStyle(
                                                                                    color: theme.colorScheme.secondary,
                                                                                    fontWeight: FontWeight.w700,
                                                                                    fontSize: 12,
                                                                                  )
                                                                                : TextStyle(
                                                                                    color: theme.colorScheme.primary,
                                                                                    fontWeight: FontWeight.w700,
                                                                                    fontSize: 12,
                                                                                  ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Column(
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.25,
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              border: Border(
                                left: BorderSide(
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter Customer Name',
                                hintStyle: TextStyle(
                                  color: theme.colorScheme.onPrimaryContainer,
                                  fontSize: 14.0,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(12.0),
                                suffixIcon: enterGuestNameController
                                        .text.isNotEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          enterGuestNameController.clear();
                                          setState(() {
                                            enterGuestNameController.text = '';
                                          });
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          color: theme.colorScheme.outline,
                                          size: 24.0,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          Divider(
                            height: 1.0,
                            thickness: 0.5,
                            color: theme.colorScheme.outline,
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.25,
                            height: 65.0,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          onTapTypeTransaction(context);
                                        },
                                        child: Container(
                                          height: 48.0,
                                          decoration: BoxDecoration(
                                            color: theme
                                                .colorScheme.primaryContainer,
                                            border: Border(
                                              bottom: BorderSide(
                                                color:
                                                    theme.colorScheme.outline,
                                                width: 0.5,
                                              ),
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 0.0, 8.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                if (typeTransaction == '')
                                                  Text(
                                                    'Pilih Jenis Transaksi',
                                                    style: theme
                                                        .textTheme.labelMedium,
                                                  ),
                                                if (typeTransaction != '')
                                                  Text(
                                                    typeTransaction,
                                                    style: theme
                                                        .textTheme.titleSmall,
                                                  ),
                                                Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: theme
                                                      .colorScheme.secondary,
                                                  size: 24.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if (cartData.isNotEmpty) {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            barrierColor: Color(0x80000000),
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child: DialogCustomWidget(
                                                    description:
                                                        'Are you sure to reset cart?',
                                                    isConfirm: true,
                                                    captionConfirm: 'Reset',
                                                    styleConfirm: TextStyle(
                                                      color: theme
                                                          .colorScheme.error,
                                                    ),
                                                    onConfirm: () {
                                                      setState(() {
                                                        AppState
                                                            .resetOrderCart();
                                                        cartData = [];
                                                        cartSelected = null;
                                                        
                                                        // modeView == 'order';
                                                      });
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: Container(
                                        height: 48.0,
                                        decoration: BoxDecoration(
                                          color: theme
                                              .colorScheme.primaryContainer,
                                          border: Border(
                                            left: BorderSide(
                                              color: theme.colorScheme.outline,
                                              width: 0.6,
                                            ),
                                            bottom: BorderSide(
                                              color: theme.colorScheme.outline,
                                              width: 0.6,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          child: Icon(
                                            Icons.delete_forever_outlined,
                                            color: cartData.isNotEmpty
                                                ? theme.colorScheme.onError
                                                : theme.colorScheme.outline,
                                            size: 30.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.25,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (cartData.isNotEmpty)
                                    SingleChildScrollView(
                                      primary: true,
                                      child: SizedBox(
                                        height: 700,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: cartData.length,
                                          itemBuilder: (context, index) {
                                            final itemData = cartData[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      8.0, 4.0, 8.0, 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${itemData.qty}x ${itemData.itemName}',
                                                        style: CustomTextStyles
                                                            .labelLargeBlack,
                                                      ),
                                                      if (modeView == 'confirm')
                                                        Checkbox(
                                                          value: itemData.status,
                                                          onChanged: (bool? value) {
                                                            Map<String, dynamic> itemNew = cart.getItemCart(itemData.name);
                                                            OrderCartItem newItem = OrderCartItem(
                                                              id: itemNew['id'],
                                                              name: itemNew['name'],
                                                              itemName: itemNew['itemName'],
                                                              itemGroup: itemNew['itemGroup'],
                                                              uom: itemNew['uom'] ?? '',
                                                              description: itemNew['description'] ?? '',
                                                              qty: itemNew['qty'],
                                                              price: itemNew['price'].floor(),
                                                              notes: itemNew['note'],
                                                              preference: itemNew['preference'] ?? {},
                                                              status: itemNew['docstatus'] == null ? true : false,
                                                            );
                                                            print('check itemNew, ${itemNew['status']}');
                                                            setState((){
                                                              itemNew['status'] = true;
                                                              cart.addItem(newItem, mode: OrderCartMode.update);
                                                           });
                                                           print('check cart, ${cartData}');
                                                            // appState.setItemCheckedStatus(
                                                            //   currentOrderId,
                                                            //   listItem.items[i].id,
                                                            //   value ?? false,
                                                            // );
                                                            // _checkAllCheckedStatus();
                                                          },
                                                        ),
                                                    ],
                                                  ),
                                                  // Dotted Divider Line
                                                  StyledDivider(
                                                    height: 15.0,
                                                    thickness: 2.0,
                                                    color: theme
                                                        .colorScheme.outline,
                                                    lineStyle:
                                                        DividerLineStyle.dotted,
                                                  ),
                                                  Text(
                                                    '${itemData.qty} x Rp ${numberFormat('idr_fixed', itemData.price)}',
                                                    style: TextStyle(
                                                      color: theme.colorScheme
                                                          .secondary,
                                                    ),
                                                  ),
                                                  if (itemData.notes != '')
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4.0),
                                                      child: Text(
                                                        'Notes: ${itemData.notes}',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: theme
                                                              .colorScheme
                                                              .secondary,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                  SizedBox(height: 8),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor: theme
                                                              .colorScheme
                                                              .primary,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16),
                                                        ),
                                                        onPressed: () {},
                                                        child: Text(
                                                          'Edit',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor: theme
                                                              .colorScheme
                                                              .error,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16),
                                                        ),
                                                        onPressed: () {},
                                                        child: Text(
                                                          'Delete',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 16.0,
                                                                8.0, 0.0),
                                                    child: Divider(
                                                      height: 5.0,
                                                      thickness: 0.5,
                                                      color: theme
                                                          .colorScheme.outline,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  if (cart.items.isEmpty) EmptyCart()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Container(
            //   height: 50,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(
            //         width: screenWidth * 0.65,
            //         child: Footer(screenWidth: screenWidth),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.07,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: BottomNavigationOrder(
                isSelected: 'menu',
                onTapMenu: () {
                  setState(() {
                    modeView = 'order';
                  });
                  // Navigator.pushNamed(context, AppRoutes.orderScreen);
                },
                onTapOrderToConfirm: () {
                  setState(() {
                    modeView = 'confirm';
                  });
                  // Navigator.pushNamed(context, AppRoutes.confirmScreen);
                },
                onTapOrderToServed: () {
                  if (cartData.isNotEmpty) {
                    // onTapAction(context);
                  }
                  // Navigator.pushNamed(context, AppRoutes.servescreen);
                },
                onTapAction: () {
                  if (cartData.isNotEmpty) {
                    onTapAction(context);
                  }
                },
              ),
              // child: ActionButton(
              //     // screenWidth: screenWidth,
              //     // //cart: cart,
              //     // guestNameController: _guestNameController,
              //     // resetDropdown: () {
              //     //   setState(() {
              //     //     table = null;
              //     //     pickupType = null;
              //     //   });
              //     // },
              //     ),
            ),
          ],
        ),
      ),
    );
  }

  onTapRefresh() {
    print('tap refresjh');
    onCallItemGroup();
    onCallItemPrice();
    onCallItem();
    onCallDataPosCart();
    onCallDataPosOrder();

    reformatOrderCart();
  }

  onTapAction(BuildContext context) async {
    // if (enterGuestNameController.text.isEmpty || cart.items.isEmpty) {
    //   String errorMessage = enterGuestNameController.text.isEmpty
    //       ? 'Nama pemesan tidak boleh kosong!'
    //       : 'Item keranjang tidak boleh kosong!';

    //   if (context.mounted) {
    //     alertError(context, errorMessage);
    //   }
    //   return;
    // }
    if (modeView == 'order') {
      onCallCreatePosCart();
    }
    // try {
    //   await cart.createOrder(
    //     guestNameController: enterGuestNameController,
    //     resetDropdown: () {},
    //     onSuccess: () {
    //       Navigator.pushReplacementNamed(
    //         context,
    //         AppRoutes.orderScreen,
    //       );
    //     },
    //   );
    //   if (context.mounted) {
    //     alertSuccess(context, 'Order berhasil ditambahkan');
    //   }
    // } catch (e) {
    //   if (context.mounted) {
    //     alertError(context, e.toString());
    //   }
    //   // ScaffoldMessenger.of(context).showSnackBar(
    //   //   SnackBar(content: Text('Error: $e')),
    //   // );
    // }
  }

  void onCallItemGroup() async {
    // isLoading = true;

    final FrappeFetchDataItemGroup.ItemGroupRequest requestItemGroup =
        FrappeFetchDataItemGroup.ItemGroupRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: '[]',
    );

    try {
      final itemGroupRequest = await FrappeFetchDataItemGroup.requestItemGroup(
              requestQuery: requestItemGroup)
          .timeout(
        Duration(seconds: 30),
      );

      setState(() {
        AppState().dataItemGroup = itemGroupRequest;
        // itemDisplay = itemGroupRequset;
        // isLoading = false;
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
    final FrappeFetchDataItemPrice.ItemPriceRequest requestItemPrice =
        FrappeFetchDataItemPrice.ItemPriceRequest(
      cookie: AppState().setCookie,
      filters: '[["selling","=",1],["valid_from","<=","$today"]]',
      limit: 5000,
    );

    try {
      // Add a timeout of 30 seconds to the profile request
      final itemPriceRequest = await FrappeFetchDataItemPrice.requestItemPrice(
              requestQuery: requestItemPrice)
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

    final FrappeFetchDataItem.ItemRequest requestItem =
        FrappeFetchDataItem.ItemRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: '[["disabled","=",0],["is_sales_item","=",1]]',
      limit: 1500,
    );

    try {
      // Add a timeout of 30 seconds to the profile request
      final itemRequest =
          await FrappeFetchDataItem.requestItem(requestQuery: requestItem)
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
        isLoading = false;
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

  List<dynamic> reformatItem(List<dynamic> item) {
    return item.where((itm) => itm['item_group'] != 'Addon').toList();
  }

  onCallDataPosCart() async {
    final FrappeFetchDataGetCart.PosCartRequest request =
        FrappeFetchDataGetCart.PosCartRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: '[]',
      limit: 1500,
    );

    try {
      final callRequest =
          await FrappeFetchDataGetCart.requestPosCart(requestQuery: request);
      print('check pos cart, $callRequest');
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
    final FrappeFetchDataGetOrder.PosOrderRequest request =
        FrappeFetchDataGetOrder.PosOrderRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: '[]',
      limit: 2000,
    );

    try {
      final callRequest =
          await FrappeFetchDataGetOrder.requestPosOrder(requestQuery: request);
      print('check pos order, $callRequest');
      if (callRequest.isNotEmpty) {
        setState(() {
          tempPosOrder = callRequest;
        });
      }
    } catch (error) {
      print('error call data pos order, $error');
      if (context.mounted) {
        alertError(context, error.toString());
      }
    }
  }

  onCallCreatePosCart() async {
    final FrappeFetchCreateCart.CreatePosCartRequest request =
        FrappeFetchCreateCart.CreatePosCartRequest(
      cookie: AppState().setCookie,
      customer: '0',
      customerName: 'Guest',
      company: AppState().configCompany['name'],
      outlet: AppState().configPOSProfile['name'],
      postingDate: dateTimeFormat('date', null).toString(),
      priceList: AppState().configPOSProfile['selling_price_list'],
      table: '1',
      id: cartSelected != null ? cartSelected['name'] : null,
    );
    // print('cart selected, $cartSelected');

    // request.getParamID()

    try {
      final callCreatePosCart =
          await FrappeFetchCreateCart.request(requestQuery: request);

      if (callCreatePosCart.isNotEmpty) {
        cartSelected = callCreatePosCart;

        if (cartSelected != null) {
          for (OrderCartItem itm in cartData) {
            print('cart data, ${itm.qty}');
            dynamic itemReq = {
              'item': itm.name,
              'item_name': itm.itemName,
              'item_group': itm.itemGroup,
              'qty': itm.qty,
              'notes': itm.notes
            };
            // onCallPosOrder(itemReq);
            onCallCreatePosOrder(itemReq);
          }
        }
      }
    } catch (error) {
      if (context.mounted) {
        print('error pos cart, $error');
        alertError(context, error.toString());
      }
    }

    // if (cartSelected != null) {
    //   for (OrderCartItem itm in cartData) {
    //     print('cart data, ${itm.qty}');
    //     dynamic itemReq = {
    //       'item': itm.name,
    //       'item_name': itm.itemName,
    //       'item_group': itm.itemGroup,
    //       'qty': itm.qty,
    //       'notes': itm.notes
    //     };
    //     onCallCreatePosOrder(itemReq);
    //   }
    // }
  }

  onCallCreatePosOrder(dynamic paramItem) async {
    final FrappeFetchCreateOrder.CreatePosOrderRequest request =
        FrappeFetchCreateOrder.CreatePosOrderRequest(
      cookie: AppState().setCookie,
      customer: '0',
      customerName: 'Guest',
      company: AppState().configCompany['name'],
      postingDate: dateTimeFormat('date', null).toString(),
      outlet: AppState().configPOSProfile['name'],
      priceList: AppState().configPOSProfile['selling_price_list'],
      cartNo: cartSelected['name'],
      item: paramItem['item'],
      itemName: paramItem['item_name'],
      itemGroup: paramItem['item_group'],
      note: paramItem['notes'] ?? '-',
      qty: paramItem['qty'],
    );

    try {
      final callCreatePosOrder =
          await FrappeFetchCreateOrder.request(requestQuery: request);

      if (callCreatePosOrder.isNotEmpty) {
        // cartSelected = callCreatePosCart;
        if (context.mounted) {
          alertSuccess(context, 'Success, order saved..');
        }
        setState(() {
          AppState.resetOrderCart();
          cartData = [];
          // modeView = 'item';
          cartSelected = null;
        });
      } else {
        if (context.mounted) {
          alertError(context, 'Gagal mendapatkan balikkan server');
        }
      }
    } catch (error) {
      print('error pos order, $error');
      if (context.mounted) {
        alertError(context, error.toString());
      }
    }
  }

  reformatOrderCart() async {
    List<dynamic> cartNew = [];

    // print('temp cart, ${tempPosCart[0]}');
    // print('temp order, ${tempPosOrder[0]}');

    if (tempPosCart.isNotEmpty) {
      for (dynamic cartTemp in tempPosCart) {
        dynamic tmp = cartTemp;
        // print('test, ${tmp['name']}');
        tmp['items'] = tempPosOrder
            .where((ord) => ord['pos_cart'] == tmp['name'])
            .toList();
        cartNew.add(tmp);
      }
    }

    // print('check cart new, $cartNew');
    print('check cart new, ${cartNew.length}');
    setState(() {
      orderDisplay = cartNew;
    });
  }

  void onTapTypeTransaction(BuildContext context) async {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: const Color(0x8A000000),
      barrierColor: const Color(0x00000000),
      context: context,
      builder: (context) {
        return TypeTransaction(
          selected: typeTransaction,
        );
      },
    ).then((value) => {
          setState(() {
            typeTransaction = AppState().typeTransaction;
          }),
          print('check type transaction, $typeTransaction')
        });
  }

  void onTapOpenItem(BuildContext context, dynamic item) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: const Color(0x8A000000),
      barrierColor: const Color(0x00000000),
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.viewInsetsOf(context),
          // child: ItemDetailsDialog(
          //   name: item['nama_menu'],
          //   price: int.parse(item['harga'].toString()),
          //   idMenu: item['id_menu'],
          //   type: item['type'],
          //   onAddToCart: (item) {},
          // ),
          // child: Container(),
          child: AddToCart(
            dataMenu: item,
            order: true,
          ),
        );
      },
    ).then((value) => {});
    setState(() {
      // Map<String, dynamic> recap = cart.recapCart();
      // AppState().totalPrice = double.parse(recap['totalPrice']);
      // print('test, ${(cart.recapCart()).totalPrice}');

      cartData = cart.getAllItemCart();
      print('check cart data, ${cartData}');
    });
  }

  void addToCartFromOrder(BuildContext context, dynamic order) async {
    setState(() {
      cart.clearCart();
    });
    const Duration(seconds: 1);

    print('check items, ${order['items'][0]['name']}');
    for (int a = 0; a < order['items'].length; a++) {
      OrderCartItem newItem = OrderCartItem(
        id: order['items'][a]['id'] ?? order['items'][a]['name'],
        name: order['items'][a]['name'],
        itemName: order['items'][a]['item_name'],
        itemGroup: order['items'][a]['item_group'],
        uom: order['items'][a]['uom'] ?? '',
        description: order['items'][a]['description'] ?? '',
        qty: order['items'][a]['qty'],
        price: order['items'][a]['price'].floor(),
        notes: order['items'][a]['note'],
        preference: order['items'][a]['preference'] ?? {},
        status: order['items'][a]['docstatus'] == 1 ? true : false,
      );

      setState(() {
        cart.addItem(newItem, mode: OrderCartMode.add);
      });
    }
    setState(() {
      print('chekc ${order['customer_name']}');
      enterGuestNameController.text = order['customer_name'].toString();
      typeTransaction = 'dine-in';
      cartData = cart.getAllItemCart();
      // isEdit = false;
    });
    // order.forEach((dt) {
    //   print('check, $dt');
    // });
  }
}
