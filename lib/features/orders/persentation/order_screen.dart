import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kontena_pos/core/api/frappe_thunder_pos/pos_invoice.dart'
    as FrappeFetchDataGetInvoice;
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
import 'package:kontena_pos/core/api/frappe_thunder_pos/pos_delivery.dart'
    as FrappeFetchDataGetDelivery;
import 'package:kontena_pos/core/api/frappe_thunder_pos/create_pos_cart.dart'
    as FrappeFetchCreateCart;
import 'package:kontena_pos/core/api/frappe_thunder_pos/create_pos_order.dart'
    as FrappeFetchCreateOrder;
import 'package:kontena_pos/core/api/frappe_thunder_pos/submit_pos_order.dart'
    as FrappeFetchSubmitOrder;
import 'package:kontena_pos/core/api/frappe_thunder_pos/cancel_pos_order.dart'
    as FrappeFetchCancelOrder;
import 'package:kontena_pos/core/api/frappe_thunder_pos/submit_pos_delivery.dart'
    as FrappeFetchSubmitDelivery;
import 'package:kontena_pos/core/api/send_printer.dart' as sendToPrinter;

import 'package:flutter/material.dart';
import 'package:kontena_pos/core/app_export.dart';
import 'package:kontena_pos/core/functions/order_new.dart';
import 'package:kontena_pos/core/functions/reformat_item_with_price.dart';
import 'package:kontena_pos/core/theme/custom_text_style.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/core/utils/alert.dart';
import 'package:kontena_pos/core/utils/datetime_ui.dart';
import 'package:kontena_pos/core/utils/number_ui.dart';
import 'package:kontena_pos/core/utils/print.dart';
import 'package:kontena_pos/core/utils/print_bluetooth.dart';
import 'package:kontena_pos/features/cart/persentation/add_to_cart.dart';
import 'package:kontena_pos/features/orders/persentation/bottom_navigation.dart';
import 'package:kontena_pos/features/products/persentation/product_grid.dart';
import 'package:kontena_pos/widgets/custom_dialog.dart';
import 'package:kontena_pos/widgets/custom_outlined_button.dart';
import 'package:kontena_pos/widgets/empty_cart.dart';
import 'package:kontena_pos/widgets/empty_data.dart';
import 'package:kontena_pos/widgets/filter_bar.dart';
import 'package:kontena_pos/widgets/loading_content.dart';
import 'package:kontena_pos/widgets/searchbar.dart';
import 'package:kontena_pos/widgets/top_bar.dart';
import 'package:kontena_pos/widgets/type_transaction.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
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
  TextEditingController enterGuestNameController = TextEditingController();
  String? table;
  String? pickupType;
  String typeTransaction = 'dine-in';
  String modeView = 'order';

  bool isLoading = true;
  bool isLoadingContent = false;

  List<dynamic> itemDisplay = [];
  List<dynamic> orderDisplay = [];
  List<dynamic> servedDisplay = [];
  List<dynamic> tempPosCart = [];
  List<dynamic> tempPosOrder = [];
  List<dynamic> tempPosServed = [];

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
    onTapRefreshMenu();
    onTapRefreshOrder();
    onTapRefreshHistory();

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
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            TopBar(
              isSelected: 'order',
              onTapRefresh: () {
                if (modeView == 'order') {
                  onTapRefreshMenu();
                } else if (modeView == 'confirm') {
                  onTapRefreshOrder();
                } else if (modeView == 'served') {
                  onTapRefreshHistory();
                }
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
                            if (modeView == 'order' &&
                                isLoadingContent == false)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 120.0, 8.0, 0.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: SingleChildScrollView(
                                    primary: true,
                                    child: SizedBox(
                                      width: MediaQuery.sizeOf(context).width,
                                      child: Column(
                                        children: [
                                          if (itemDisplay.isNotEmpty)
                                            MasonryGridView.count(
                                              crossAxisCount: 5,
                                              mainAxisSpacing: 6,
                                              crossAxisSpacing: 6,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: itemDisplay.length,
                                              itemBuilder: (context, index) {
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
                                                    imagePath:
                                                        ImageConstant.imgAdl1,
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
                                          if (itemDisplay.isEmpty) EmptyData(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (modeView == 'confirm' &&
                                isLoadingContent == false)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8.0, 50.0, 8.0, 0.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: SingleChildScrollView(
                                    primary: true,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Confirm',
                                            style: TextStyle(
                                              color:
                                                  theme.colorScheme.secondary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (orderDisplay.isNotEmpty)
                                            AlignedGridView.count(
                                              crossAxisCount: 4,
                                              mainAxisSpacing: 6,
                                              crossAxisSpacing: 6,
                                              shrinkWrap: true,
                                              itemCount: orderDisplay.length,
                                              itemBuilder: (context, index) {
                                                final order =
                                                    orderDisplay[index];
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
                                                        if ((cartSelected !=
                                                                null) &&
                                                            (cartSelected[
                                                                    'name'] ==
                                                                order['name']))
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            height: 24.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: theme
                                                                  .colorScheme
                                                                  .primary,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          4.0,
                                                                          0.0,
                                                                          4.0),
                                                              child: Text(
                                                                'Selected',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: theme
                                                                      .colorScheme
                                                                      .primaryContainer,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
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
                                                                    order[
                                                                        'name'],
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
                                                                          (context, index) =>
                                                                              Divider(
                                                                        height:
                                                                            12,
                                                                        thickness:
                                                                            0.5,
                                                                        color: theme
                                                                            .colorScheme
                                                                            .outline,
                                                                      ),
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount:
                                                                          orderItemList
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              idx) {
                                                                        dynamic
                                                                            orderItem =
                                                                            orderItemList[idx];
                                                                        return Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              bottom: 8.0),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                "${orderItem['qty']}x",
                                                                                style: const TextStyle(
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                              const SizedBox(width: 8),
                                                                              Expanded(
                                                                                child: Column(
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
                                                                                    const SizedBox(height: 4),
                                                                                    if ((orderItem.containsKey('note')) && (orderItem['note'] != null) && (orderItem['note'] != ''))
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
                                                                                    : (orderItem['docstatus'] == 2)
                                                                                        ? 'Cancelled'
                                                                                        : 'Draft',
                                                                                style: (orderItem['docstatus'] != 1)
                                                                                    ? TextStyle(
                                                                                        color: () {
                                                                                          if (orderItem['docstatus'] == 1) {
                                                                                            return theme.colorScheme.primary;
                                                                                          } else if (orderItem['docstatus'] == 2) {
                                                                                            return theme.colorScheme.error;
                                                                                          } else {
                                                                                            return theme.colorScheme.onPrimaryContainer;
                                                                                          }
                                                                                        }(),
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
                                          if (itemDisplay.isEmpty) EmptyData(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (modeView == 'served' &&
                                isLoadingContent == false)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8.0, 50.0, 8.0, 0.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: SingleChildScrollView(
                                    primary: true,
                                    scrollDirection: Axis.vertical,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Served',
                                            style: TextStyle(
                                              color:
                                                  theme.colorScheme.secondary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (servedDisplay.isNotEmpty)
                                            AlignedGridView.count(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 6,
                                              crossAxisSpacing: 6,
                                              shrinkWrap: true,
                                              itemCount: servedDisplay.length,
                                              //itemCount:tempPosServed.length,
                                              itemBuilder: (context, index) {
                                                final order =
                                                    servedDisplay[index];
                                                //final order = tempPosServed[index];
                                                print('served, ${order}');
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
                                                        if ((cartSelected !=
                                                                null) &&
                                                            (cartSelected[
                                                                    'name'] ==
                                                                order['name']))
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            height: 24.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: theme
                                                                  .colorScheme
                                                                  .primary,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          4.0,
                                                                          0.0,
                                                                          4.0),
                                                              child: Text(
                                                                'Selected',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: theme
                                                                      .colorScheme
                                                                      .primaryContainer,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
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
                                                                    order[
                                                                        'name'],
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
                                                                          (context, index) =>
                                                                              Divider(
                                                                        height:
                                                                            12,
                                                                        thickness:
                                                                            0.5,
                                                                        color: theme
                                                                            .colorScheme
                                                                            .outline,
                                                                      ),
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount:
                                                                          orderItemList
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              idx) {
                                                                        dynamic
                                                                            orderItem =
                                                                            orderItemList[idx];
                                                                        print(
                                                                            'check served order, ${orderItem} ');
                                                                        print(
                                                                            '-=-=-=-=-=-=-=-=-=-');
                                                                        return Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              bottom: 8.0),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                "${orderItem['qty']}x",
                                                                                style: const TextStyle(
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                              const SizedBox(width: 8),
                                                                              Expanded(
                                                                                child: Column(
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
                                                                                    const SizedBox(height: 4),
                                                                                    if ((orderItem.containsKey('note')) && (orderItem['note'] != null))
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
                                                                                    : (orderItem['docstatus'] == 2)
                                                                                        ? 'Cancelled'
                                                                                        : 'Draft',
                                                                                style: (orderItem['docstatus'] != 1)
                                                                                    ? TextStyle(
                                                                                        color: () {
                                                                                          if (orderItem['docstatus'] == 1) {
                                                                                            return theme.colorScheme.primary;
                                                                                          } else if (orderItem['docstatus'] == 2) {
                                                                                            return theme.colorScheme.error;
                                                                                          } else {
                                                                                            return theme.colorScheme.onPrimaryContainer;
                                                                                          }
                                                                                        }(),
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
                                          if (itemDisplay.isEmpty) EmptyData(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (isLoadingContent)
                              const Align(
                                alignment: AlignmentDirectional(0.00, 0.00),
                                child: LoadingContent(),
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
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (cartSelected != null)
                                    Container(
                                      width: double.infinity,
                                      height: 24.0,
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.outline,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 4.0, 0.0, 4.0),
                                        child: Text(
                                          cartSelected['name'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: theme.colorScheme.secondary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (cartData.isNotEmpty)
                                    Expanded(
                                        child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            child: Builder(
                                              builder: (context) {
                                                return ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: cartData.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final itemData =
                                                        cartData[index];
                                                    bool isCheck =
                                                        itemData.status
                                                            ? true
                                                            : false;
                                                    print(
                                                        'is checked, $isCheck');
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(8.0,
                                                              4.0, 8.0, 8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                '${itemData.qty}x ${itemData.itemName}',
                                                                style: CustomTextStyles
                                                                    .labelLargeBlack,
                                                              ),
                                                              if (((modeView ==
                                                                          'confirm') ||
                                                                      ((modeView ==
                                                                          'served'))) &&
                                                                  (itemData
                                                                          .docstatus !=
                                                                      2))
                                                                Checkbox(
                                                                  value:
                                                                      isCheck,
                                                                  onChanged:
                                                                      (bool?
                                                                          value) {
                                                                    if (value !=
                                                                        null) {
                                                                      print(
                                                                          'check , $value');
                                                                      setState(
                                                                          () {
                                                                        isCheck =
                                                                            value;
                                                                      });
                                                                      onCheckboxChange(
                                                                        itemData,
                                                                        index,
                                                                        value,
                                                                      );
                                                                      print(
                                                                          'check , $isCheck');
                                                                    }
                                                                    // isCheck = value!;
                                                                  },
                                                                ),
                                                              if ((modeView ==
                                                                      'confirm') &&
                                                                  (itemData
                                                                          .docstatus ==
                                                                      2))
                                                                Text(
                                                                  'Cancelled',
                                                                  style:
                                                                      TextStyle(
                                                                    color: theme
                                                                        .colorScheme
                                                                        .error,
                                                                  ),
                                                                )
                                                            ],
                                                          ),
                                                          // Dotted Divider Line
                                                          StyledDivider(
                                                            height: 15.0,
                                                            thickness: 2.0,
                                                            color: theme
                                                                .colorScheme
                                                                .outline,
                                                            lineStyle:
                                                                DividerLineStyle
                                                                    .dotted,
                                                          ),
                                                          Text(
                                                            '${itemData.qty} x Rp ${numberFormat('idr_fixed', itemData.price)}',
                                                            style: TextStyle(
                                                              color: theme
                                                                  .colorScheme
                                                                  .secondary,
                                                            ),
                                                          ),
                                                          if ((itemData.notes !=
                                                                  null) &&
                                                              (itemData.notes !=
                                                                  ''))
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 4.0),
                                                              child: Text(
                                                                'Notes: ${itemData.notes}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  color: theme
                                                                      .colorScheme
                                                                      .secondary,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ),
                                                          SizedBox(height: 8),
                                                          if (itemData
                                                                  .docstatus !=
                                                              2)
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      CustomOutlinedButton(
                                                                        height:
                                                                            32.0,
                                                                        width:
                                                                            80.0,
                                                                        text:
                                                                            "Edit",
                                                                        buttonTextStyle:
                                                                            TextStyle(color: theme.colorScheme.primary),
                                                                        buttonStyle:
                                                                            CustomButtonStyles.outlinePrimary,
                                                                        onPressed:
                                                                            () {
                                                                          onTapEditItem(
                                                                            context,
                                                                            itemData,
                                                                            index,
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      CustomOutlinedButton(
                                                                        height:
                                                                            32.0,
                                                                        width:
                                                                            80.0,
                                                                        text:
                                                                            "Delete",
                                                                        buttonTextStyle:
                                                                            TextStyle(color: theme.colorScheme.error),
                                                                        buttonStyle:
                                                                            CustomButtonStyles.outlineError,
                                                                        onPressed:
                                                                            () {
                                                                          onTapDelete(
                                                                            context,
                                                                            itemData,
                                                                            index,
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                // CustomElevatedButton(
                                                                //   text: "Delete",
                                                                //   buttonTextStyle: TextStyle(
                                                                //       color: theme
                                                                //           .colorScheme
                                                                //           .primaryContainer),
                                                                //   buttonStyle:
                                                                //       CustomButtonStyles
                                                                //           .outlineError,
                                                                //   onPressed: () {
                                                                //     onTapDelete(
                                                                //       context,
                                                                //       itemData,
                                                                //       index,
                                                                //     );
                                                                //   },
                                                                // ),
                                                                // ElevatedButton(
                                                                //   style: ElevatedButton
                                                                //       .styleFrom(
                                                                //     backgroundColor: theme
                                                                //         .colorScheme
                                                                //         .primaryContainer,
                                                                //     padding: EdgeInsets
                                                                //         .symmetric(
                                                                //             horizontal:
                                                                //                 16),
                                                                //   ),
                                                                //   onPressed: () {},
                                                                //   child: Text(
                                                                //     'Edit',
                                                                //     style: TextStyle(
                                                                //       color: theme
                                                                //           .colorScheme
                                                                //           .primary,
                                                                //       fontSize: 14,
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                                // ElevatedButton(
                                                                //   style: ElevatedButton
                                                                //       .styleFrom(
                                                                //     backgroundColor: theme
                                                                //         .colorScheme
                                                                //         .error,
                                                                //     padding: EdgeInsets
                                                                //         .symmetric(
                                                                //             horizontal:
                                                                //                 16),
                                                                //   ),
                                                                //   onPressed: () {},
                                                                //   child: Text(
                                                                //     'Delete',
                                                                //     style: TextStyle(
                                                                //         color:
                                                                //             Colors.white,
                                                                //         fontSize: 14),
                                                                //   ),
                                                                // ),
                                                              ],
                                                            ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        16.0,
                                                                        8.0,
                                                                        0.0),
                                                            child: Divider(
                                                              height: 5.0,
                                                              thickness: 0.5,
                                                              color: theme
                                                                  .colorScheme
                                                                  .outline,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ))),
                                  if (cartSelected != null)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 8.0, 0.0, 8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          CustomOutlinedButton(
                                            height: 48.0,
                                            text: "Reprint Checker",
                                            buttonTextStyle: TextStyle(
                                                color:
                                                    theme.colorScheme.primary),
                                            buttonStyle: CustomButtonStyles
                                                .outlinePrimary,
                                            onPressed: () {
                                              print(
                                                  'check app state, ${AppState().configPrinter}');
                                              if (AppState().configPrinter[
                                                      'tipeConnection'] ==
                                                  'Bluetooth') {
                                                onPrintCheckerBluetooth();
                                              } else {
                                                onPrintChecker();
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (cartData.isEmpty) EmptyCart()
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
                isSelected: modeView,
                onTapMenu: () {
                  setState(() {
                    modeView = 'order';
                  });
                  // Navigator.pushNamed(context, AppRoutes.orderScreen);
                },
                onTapOrderToConfirm: () {
                  setState(() {
                    modeView = 'confirm';
                    cartSelected = null;
                    cart.clearCart();
                    cartData = cart.getAllItemCart();
                  });
                  onTapRefreshOrder();
                  // Navigator.pushNamed(context, AppRoutes.confirmScreen);
                },
                onTapOrderToServed: () {
                  setState(() {
                    modeView = 'served';
                    cartSelected = null;
                    cart.clearCart();
                    cartData = cart.getAllItemCart();
                  });
                  onTapRefreshHistory();
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

  onTapRefreshHistory() async {
    print('serve screen');
    setState(() {
      isLoadingContent = true;
    });
    //await onCallDataInvoicePosOrder();
    await onCallDataPosCart();
    await onCallDataPosDelivery();
    await reformatServedCart();
  }

  onTapRefreshMenu() async {
    print('tap refresjh');
    setState(() {
      isLoadingContent = true;
    });
    await onCallItemGroup();
    await onCallItemPrice();
    await onCallItem();
    // onCallDataPosCart();
    // onCallDataPosOrder();

    // reformatOrderCart();
  }

  onTapRefreshOrder() async {
    setState(() {
      isLoadingContent = true;
    });
    await onCallDataPosCart();
    await onCallDataPosOrder();
    await reformatOrderCart();
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
    print('tap action');
    if (modeView == 'order') {
      if (cartSelected == null) {
        await onCallCreatePosCart();
      } else {
        for (OrderCartItem itm in cartData) {
          dynamic itemReq = {};
          if (itm.id.contains('CORD')) {
            itemReq = {
              'id': itm.id,
              'name': itm.name,
              'item_name': itm.itemName,
              'item_group': itm.itemGroup,
              'uom': itm.uom,
              'qty': itm.qty,
              'notes': itm.notes,
            };
          } else {
            itemReq = {
              'name': itm.name,
              'item_name': itm.itemName,
              'item_group': itm.itemGroup,
              'uom': itm.uom,
              'qty': itm.qty,
              'notes': itm.notes,
            };
          }
          // onCallPosOrder(itemReq);
          await onCallCreatePosOrder(itemReq);
        }
        setState(() {
          AppState.resetOrderCart();
          cartData = [];
          // modeView = 'item';
          cartSelected = null;
        });
      }
      await onTapRefreshOrder();
    } else if (modeView == 'confirm') {
      if (cartSelected != null) {
        for (OrderCartItem itm in cartData) {
          dynamic itemReq = {
            'id': itm.id,
            'name': itm.name,
            'item_name': itm.itemName,
            'item_group': itm.itemGroup,
            'uom': itm.uom,
            'qty': itm.qty,
            'notes': itm.notes,
            'status': itm.status,
          };
          // onCallPosOrder(itemReq);
          if (itm.docstatus == 0) {
            await onCallSubmitPosOrder(itemReq);
          }
        }
        setState(() {
          AppState.resetOrderCart();
          cartData = [];
          modeView = 'confirm';
          cartSelected = null;
        });
        await onTapRefreshOrder();
      }
    } else if (modeView == 'served') {
      if (cartSelected != null) {
        for (OrderCartItem itm in cartData) {
          dynamic itemReq = {
            'id': itm.id,
            'name': itm.name,
            'item_name': itm.itemName,
            'item_group': itm.itemGroup,
            'uom': itm.uom,
            'qty': itm.qty,
            'notes': itm.notes,
            'status': itm.status,
          };
          // onCallPosOrder(itemReq);
          if (itm.docstatus == 0) {
            await onCallSubmitPosDelivery(itemReq);
          }
        }
        setState(() {
          AppState.resetOrderCart();
          cartData = [];
          modeView = 'confirm';
          cartSelected = null;
        });
        await onTapRefreshHistory();
      }
    }

    // onCallDataPosCart();
    // onCallDataPosOrder();

    // reformatOrderCart();

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

  onTapDelete(BuildContext context, dynamic item, int index) async {
    dynamic itemReq = {
      'id': item.id,
      'name': item.name,
      'item_name': item.itemName,
      'item_group': item.itemGroup,
      'uom': item.uom,
      'qty': item.qty,
      'notes': item.notes,
      'status': item.status,
    };
    await onCallCancelPosOrder(itemReq);
    await onTapRefreshOrder();

    // setState(() { })
  }

  onCallItemGroup() async {
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
      isLoadingContent = false;
      if (error is TimeoutException) {
        // Handle timeout error
        // _bottomScreenTimeout(context);
      } else {
        print(error);
      }
      return;
    }
  }

  onCallItemPrice() async {
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
      isLoadingContent = false;
      if (error is TimeoutException) {
        // Handle timeout error
        // _bottomScreenTimeout(context);
      } else {
        print(error);
      }
      return;
    }
  }

  onCallItem() async {
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
        isLoadingContent = false;
      });
      // AppState().userDetail = profileResult;
    } catch (error) {
      isLoadingContent = false;
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

  onCallDataPosCart({String? id}) async {
    final FrappeFetchDataGetCart.PosCartRequest request =
        FrappeFetchDataGetCart.PosCartRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: id != null ? '[["name","=","$id"]]' : '[]',
      limit: 1500,
    );

    try {
      final callRequest =
          await FrappeFetchDataGetCart.requestPosCart(requestQuery: request);
      // print('check pos cart, $callRequest');
      if (callRequest.isNotEmpty) {
        setState(() {
          tempPosCart = callRequest;
        });
      }
    } catch (error) {
      print('error call data pos cart, $error');
    }
  }

  onCallDataPosOrder({String? id}) async {
    final FrappeFetchDataGetOrder.PosOrderRequest request =
        FrappeFetchDataGetOrder.PosOrderRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: id != null ? '[["name","=","$id"]]' : '[]',
      limit: 2000,
    );

    try {
      final callRequest =
          await FrappeFetchDataGetOrder.requestPosOrder(requestQuery: request);
      // print('check pos order, $callRequest');
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

  onCallDataPosDelivery({String? id}) async {
    final FrappeFetchDataGetDelivery.PosDeliveryRequest request =
        FrappeFetchDataGetDelivery.PosDeliveryRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: id != null ? '[["name","=","$id"]]' : '[]',
      limit: 2000,
    );

    try {
      final callRequest =
          await FrappeFetchDataGetDelivery.request(requestQuery: request);
      // print('check pos order, $callRequest');
      if (callRequest.isNotEmpty) {
        setState(() {
          tempPosServed = callRequest;
        });
      }
    } catch (error) {
      print('error call data pos order, $error');
      if (context.mounted) {
        alertError(context, error.toString());
      }
    }
  }

  onCallDataInvoicePosOrder() async {
    final FrappeFetchDataGetInvoice.PosInvoiceRequest request =
        FrappeFetchDataGetInvoice.PosInvoiceRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: '[["pos_profile","=","${AppState().configPOSProfile['name']}"]]',
      orderBy: 'posting_date desc',
      limit: 2000,
    );

    try {
      final callRequest =
          await FrappeFetchDataGetInvoice.request(requestQuery: request);

      if (callRequest.isNotEmpty) {
        setState(() {
          tempPosServed = callRequest;
          isLoading = false;
          print('Data received: $tempPosServed');
        });
        // print('check ata, $tempPosOrder');
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
            // print('cart data, ${itm.qty}');
            dynamic itemReq = {
              'name': itm.name,
              'item_name': itm.itemName,
              'item_group': itm.itemGroup,
              'uom': itm.uom,
              'qty': itm.qty,
              'notes': itm.notes,
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
      item: paramItem['name'],
      itemName: paramItem['item_name'],
      itemGroup: paramItem['item_group'],
      uom: paramItem['uom'],
      note: paramItem['notes'] ?? '-',
      qty: paramItem['qty'],
      status: paramItem['status'] == true ? 1 : 0,
      id: paramItem['id'],
    );

    // print('check request, ${request}');
    try {
      final callCreatePosOrder =
          await FrappeFetchCreateOrder.request(requestQuery: request);

      if (callCreatePosOrder.isNotEmpty) {
        // cartSelected = callCreatePosCart;
        if (context.mounted) {
          alertSuccess(context, 'Success, order saved..');
        }
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

  onCallSubmitPosOrder(dynamic paramItem) async {
    final FrappeFetchSubmitOrder.SubmitPosOrderRequest request =
        FrappeFetchSubmitOrder.SubmitPosOrderRequest(
      cookie: AppState().setCookie,
      cartNo: cartSelected['name'],
      id: paramItem['id'],
      status: paramItem['status'] == true ? 1 : 0,
    );

    try {
      final callSubmitPosOrder =
          await FrappeFetchSubmitOrder.request(requestQuery: request);

      if (callSubmitPosOrder.isNotEmpty) {
        if (context.mounted) {
          alertSuccess(context, 'Success, order confirm..');
        }
        setState(() {
          // AppState.resetOrderCart();
          // cartData = [];
          // // modeView = 'item';
          // cartSelected = null;
          // isLoadingContent = true;
        });
        // onTapRefreshOrder();
      }
    } catch (error) {
      print('check error, ${error}');
      if (context.mounted) {
        alertError(context, error.toString());
      }
    }
  }

  onCallCancelPosOrder(dynamic paramItem) async {
    final FrappeFetchCancelOrder.CancelPosOrderRequest request =
        FrappeFetchCancelOrder.CancelPosOrderRequest(
      cookie: AppState().setCookie,
      cartNo: cartSelected['name'],
      id: paramItem['id'],
      status: paramItem['status'] == true ? 1 : 0,
    );

    try {
      final callCancelPosOrder =
          await FrappeFetchCancelOrder.request(requestQuery: request);

      if (callCancelPosOrder.isNotEmpty) {
        if (context.mounted) {
          alertSuccess(context, 'Success order cancelled..');
        }
      }
    } catch (error) {
      print('check error, ${error}');
      if (context.mounted) {
        alertError(context, error.toString());
      }
    }
  }

  onCallSubmitPosDelivery(dynamic paramItem) async {
    final FrappeFetchSubmitDelivery.SubmitPosServedReq request =
        FrappeFetchSubmitDelivery.SubmitPosServedReq(
      cookie: AppState().setCookie,
      id: paramItem['id'],
    );

    try {
      final callSubmitPosOrder =
          await FrappeFetchSubmitDelivery.request(requestQuery: request);

      if (callSubmitPosOrder.isNotEmpty) {
        if (context.mounted) {
          alertSuccess(context, 'Success, order confirm..');
        }
        setState(() {
          // AppState.resetOrderCart();
          // cartData = [];
          // // modeView = 'item';
          // cartSelected = null;
          // isLoadingContent = true;
        });
        // onTapRefreshOrder();
      }
    } catch (error) {
      print('check error, ${error}');
      if (context.mounted) {
        alertError(context, error.toString());
      }
    }
  }

  reformatOrderCart() async {
    List<dynamic> cartNew = [];

    // print('temp cart, ${tempPosCart[0]}');
    print('temp order, ${tempPosOrder}');

    if (tempPosCart.isNotEmpty) {
      for (dynamic cartTemp in tempPosCart) {
        dynamic tmp = cartTemp;
        // print('temp order, $tempPosOrder');

        tmp['items'] = tempPosOrder
            .where((ord) => ord['pos_cart'] == tmp['name'])
            .toList();
        cartNew.add(tmp);
      }
    }

    // print('check cart new, $cartNew');
    // print('check cart new, ${cartNew.length}');
    setState(() {
      orderDisplay = cartNew;
      isLoadingContent = false;
    });
    // onTapRefreshOrder();
  }

  reformatServedCart() async {
    List<dynamic> cartNew = [];

    // print('temp cart, ${tempPosCart[0]}');
    print('temp served, ${tempPosServed}');

    if (tempPosCart.isNotEmpty) {
      for (dynamic cartTemp in tempPosCart) {
        dynamic tmp = cartTemp;
        // print('temp order, $tempPosOrder');

        tmp['items'] = tempPosServed
            .where((ord) => ord['pos_cart'] == tmp['name'])
            .toList();
        cartNew.add(tmp);
      }
    }

    // print('check cart new, $cartNew');
    // print('check cart new, ${cartNew.length}');
    setState(() {
      servedDisplay = cartNew;
      isLoadingContent = false;
    });
    // onTapRefreshOrder();
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
      // print('check cart data, ${cartData}');
    });
  }

  void onTapEditItem(BuildContext context, dynamic item, int index) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: const Color(0x8A000000),
      barrierColor: const Color(0x00000000),
      context: context,
      builder: (context) {
        dynamic editItem = {
          'id': item.id,
          'item_name': item.itemName,
          'notes': item.notes,
          'name': item.name,
          'qty': item.qty,
          'price': item.price,
          'uom': item.uom,
          'item_group': item.itemGroup,

          // 'variantPrice': item.variantPrice,
          // 'totalPrice': item.totalPrice,
          // 'addonsPrice': item.addonsPrice,
        };

        return Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: AddToCart(
            dataMenu: editItem,
            idxMenu: index,
            order: true,
          ),
        );
      },
    ).then((value) => {});
    setState(() {
      cartData = cart.getAllItemCart();
    });
  }

  void addToCartFromOrder(BuildContext context, dynamic order) async {
    setState(() {
      cart.clearCart();
    });
    const Duration(seconds: 1);

    print('check items, ${order['items'][0]['qty']}');
    for (int a = 0; a < order['items'].length; a++) {
      OrderCartItem newItem = OrderCartItem(
        id: order['items'][a]['name'],
        name: order['items'][a]['item'],
        itemName: order['items'][a]['item_name'],
        itemGroup: order['items'][a]['item_group'],
        uom: order['items'][a]['uom'] ?? '',
        description: order['items'][a]['description'] ?? '',
        qty: order['items'][a]['qty'],
        price: order['items'][a]['price'] != null
            ? order['items'][a]['price'].floor()
            : 0,
        notes: order['items'][a]['note'],
        preference: order['items'][a]['preference'] ?? {},
        status: order['items'][a]['docstatus'] == 1 ? true : false,
        docstatus: order['items'][a]['docstatus'],
        addon: [],
        totalAddon: 0,
      );

      setState(() {
        cart.addItem(newItem, mode: OrderCartMode.add);
      });
    }
    setState(() {
      // print('chekc ${order['customer_name']}');
      enterGuestNameController.text = order['customer_name'].toString();
      typeTransaction = 'dine-in';
      cartData = cart.getAllItemCart();
      cartSelected = order;
      // isEdit = false;
    });
    // order.forEach((dt) {
    //   print('check, $dt');
    // });
  }

  onCheckboxChange(OrderCartItem itemOrder, int? index, bool? value) {
    // print('chekc item order, $itemOrder');
    // print('test--- 1, ${tempPosOrder}');
    // print('test--- 2, ${tempPosCart}');
    OrderCartItem itemNew = cart.getItemByIndex(index!);
    // itemNew.status = value;
    // print('check item --- 3, ${itemNew.id}');
    OrderCartItem newItem = OrderCartItem(
      id: itemNew.id,
      name: itemNew.name,
      itemName: itemNew.itemName,
      itemGroup: itemNew.itemGroup,
      uom: itemNew.uom,
      description: itemNew.description,
      qty: itemNew.qty,
      price: itemNew.price,
      notes: itemNew.notes,
      preference: itemNew.preference,
      status: value ?? false,
      docstatus: itemNew.docstatus,
      addon: itemNew.addon,
      totalAddon: itemNew.totalAddon,
    );
    // print('check itemNew, ${itemNew['status']}');
    setState(() {
      //   itemNew['status'] = true;
      cart.addItem(newItem, mode: OrderCartMode.update);
    });
    // print('check cart, ${cartData}');
    // appState.setItemCheckedStatus(
    //   currentOrderId,
    //   listItem.items[i].id,
    //   value ?? false,
    // );
    // _checkAllCheckedStatus();
  }

  onPrintChecker() async {
    dynamic docPrint = await printChecker(
      cartSelected,
      AppState().configPrinter,
    );

    // print('print invoce, $docPrint');

    final sendToPrinter.ToPrint request =
        sendToPrinter.ToPrint(doc: docPrint, ipAddress: '127.0.0.1');
    try {
      final callRespon = await sendToPrinter.request(requestQuery: request);
      print('call respon, ${callRespon}');
      if (callRespon != null) {
        // setState((){
        //   paymentStatus = true;
        //   invoice = callRespon;
        // });
      }
    } catch (error) {
      print('error pos invoice, ${error}');
      if (context.mounted) {
        alertError(context, error.toString());
      }
    }
  }

  onPrintCheckerBluetooth() async {
    bool connectionStatus = await PrintBluetoothThermal.connectionStatus;
    if (connectionStatus) {
      bool result = false;
      List<int> ticket = await testTicket();
      result = await PrintBluetoothThermal.writeBytes(ticket);
      print('result print, $result');
    }
    // BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
    // // String name = cartSelected[];
    // bluetooth.isConnected.then((isConnected) {
    //   if (isConnected == true) {
    //     List<dynamic> tempItem = [];
    //     List<dynamic> docItem = [];
    //     bluetooth.printLeftRight(
    //       "No",
    //       cartSelected['name'],
    //       Size.medium.val,
    //     );

    //     String docTime = '';

    //     if ((cartSelected['posting_date'] != null) ||
    //         (cartSelected['posting_time'] != null)) {
    //       var tmpDate = dateTimeFormat('dateui', cartSelected['posting_date']);
    //       var tmpTime = timeFormat('time_simple', cartSelected['posting_time']);
    //       docTime = '$tmpDate $tmpTime';
    //     }
    //     bluetooth.printLeftRight(
    //       "Date",
    //       docTime,
    //       Size.medium.val,
    //     );

    //     if (cartSelected['customer'] != null) {
    //       String tmpCustomer = cartSelected['customer_name'] != ''
    //           ? cartSelected['customer_name']
    //           : '';
    //       bluetooth.printLeftRight(
    //         "Customer",
    //         tmpCustomer,
    //         Size.medium.val,
    //       );
    //       // docHeader.add({"key": "line", "type": "line"});
    //     }
    //     bluetooth.printNewLine();

    //     if (cartSelected['items'] != null) {
    //       tempItem = cartSelected['items'];
    //     } else {
    //       tempItem = ((cartSelected['items'] != null) &&
    //               (cartSelected['items'].length > 2))
    //           ? cartSelected['items']
    //           : [];
    //     }

    //     if (tempItem.isNotEmpty) {
    //       for (var dt in tempItem) {
    //         // if (dt['parent_addon_idx'] == null) {
    //         String qty = numberFormat('number_fixed', dt['qty']);
    //         String tmpTitle = '${qty}x  ${dt['item_name']}';
    //         bluetooth.printLeftRight(
    //           tmpTitle,
    //           "[ ]",
    //           Size.medium.val,
    //         );
    //       }
    //     }
        // bluetooth.printNewLine();
        // bluetooth.paperCut();
      // }
    // });
    // if (AppState().isConnected && AppState().selectedPrinter != null) {
    //   BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
    //   Map<String, dynamic> config = Map();
    //   List<LineText> list = [];

    //   list.add(LineText(type: LineText.TYPE_TEXT, content: 'Test Print', weight: 1, align: LineText.ALIGN_CENTER,linefeed: 1));
    //   list.add(LineText(type: LineText.TYPE_TEXT, content: 'Berhasil', weight: 0, align: LineText.ALIGN_CENTER,linefeed: 1));
    //   // list.add(LineText(type: LineText.TYPE_TEXT, content: 'Test Print', weight: 0, align: LineText.ALIGN_LEFT,linefeed: 1));
    //   list.add(LineText(linefeed: 1));
    //   // list.add(LineText(type: LineText.TYPE_TEXT, content: 'Test Print', align: LineText.ALIGN_LEFT, absolutePos: 0,relativePos: 0, linefeed: 0));
    //   // list.add(LineText(type: LineText.TYPE_TEXT, content: 'Berhasil', align: LineText.ALIGN_LEFT, absolutePos: 350, relativePos: 0, linefeed: 0));
    //   // list.add(LineText(type: LineText.TYPE_TEXT, content: '数量', align: LineText.ALIGN_LEFT, absolutePos: 500, relativePos: 0, linefeed: 1));
    //   await bluetoothPrint.printReceipt(config, list);
    // }
  }

  Future<List<int>> testTicket() async {
    List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    //bytes += generator.setGlobalFont(PosFontType.fontA);
    bytes += generator.reset();

    // final ByteData data = await rootBundle.load('assets/mylogo.jpg');
    // final Uint8List bytesImg = data.buffer.asUint8List();
    // img.Image? image = img.decodeImage(bytesImg);

    bytes += generator.text('Bold text', styles: PosStyles(bold: true));
    bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
    bytes += generator.text('Underlined text', styles: PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left', styles: PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center', styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right', styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    bytes += generator.row([
      PosColumn(
        text: 'col5',
        width: 6,
        styles: PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: 'col7',
        width: 6,
        styles: PosStyles(align: PosAlign.right, underline: true),
      ),
    ]);

    return bytes;
  }
}
