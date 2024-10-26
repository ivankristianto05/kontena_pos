import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kontena_pos/app_state.dart';

import 'package:kontena_pos/core/api/frappe_thunder_pos/item.dart'
    as FrappeFetchDataItem;
import 'package:kontena_pos/core/api/frappe_thunder_pos/item_group.dart'
    as FrappeFetchDataItemGroup;
import 'package:kontena_pos/core/api/frappe_thunder_pos/item_price.dart'
    as FrappeFetchDataItemPrice;
import 'package:kontena_pos/core/api/frappe_thunder_pos/create_pos_cart.dart'
    as FrappeFetchCreateCart;
import 'package:kontena_pos/core/api/frappe_thunder_pos/pos_cart.dart'
    as FrappeFetchDataGetCart;
import 'package:kontena_pos/core/api/frappe_thunder_pos/create_pos_order.dart'
    as FrappeFetchCreateOrder;
import 'package:kontena_pos/core/api/frappe_thunder_pos/pos_order.dart'
    as FrappeFetchDataGetOrder;

import 'package:kontena_pos/core/app_export.dart';
import 'package:kontena_pos/core/functions/invoice.dart';
import 'package:kontena_pos/core/functions/reformat_item_with_price.dart';
import 'package:kontena_pos/core/theme/custom_text_style.dart';
import 'package:kontena_pos/core/utils/datetime_ui.dart';
import 'package:kontena_pos/core/utils/number_ui.dart';
import 'package:kontena_pos/features/cart/persentation/add_to_cart.dart';
import 'package:kontena_pos/features/invoices/persentation/bottom_navigation.dart';
import 'package:kontena_pos/features/products/persentation/product_grid.dart';
import 'package:kontena_pos/widgets/custom_dialog.dart';
import 'package:kontena_pos/widgets/empty_cart.dart';
import 'package:kontena_pos/widgets/filter_bar.dart';
import 'package:kontena_pos/widgets/list_cart.dart';
import 'package:kontena_pos/widgets/searchbar.dart';
import 'package:kontena_pos/widgets/top_bar.dart';
import 'package:kontena_pos/widgets/type_transaction.dart';
// import 'package:kontena_pos/models/cart_item.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:kontena_pos/core/utils/alert.dart' as alert;

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen({Key? key}) : super(key: key);

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  InvoiceCart cart = InvoiceCart();
  late Map cartRecapData;
  late List<InvoiceCartItem> cartData;
  // late List<Map<String, dynamic>> cartDataItem = [
  //   {
  //     'id': 'test',
  //     'name': 'Item 1',
  //     'qty': 3,
  //   }
  // ];
  String filterSearch = '';
  bool isSearchActive = false;
  bool isLoading = true;
  String selectedGroup = '';

  List<dynamic> item = [];
  List<dynamic> itemDisplay = [];
  List<dynamic> orderDisplay = [];

  List<dynamic> tempPosCart = [];
  List<dynamic> tempPosOrder = [];

  String searchItemQuery = '';
  String modeView = 'item';
  String typeTransaction = 'dine-in';
  int totalAddon = 0;
  int totalAddonCheckout = 0;
  bool isEdit = true;
  dynamic cartSelected;

// // //   //  final String id;
// // //   // final String name;
// // //   // String? variant;
// // //   // int qty;
// // //   // final int price;
// // //   // late int totalPrice;
// // //   // Map<String, Map<String, dynamic>>? addons;
// // //   // final String notes;
// // //   // final Map<String, String> preference;
// // //   // String? type;
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    cartData = cart.getAllItemCart();
  }

  @override
  void initState() {
    super.initState();
    onCallItemGroup();
    onCallItemPrice();
    onCallItem();

    onCallDataPosCart();
    onCallDataPosOrder();
    reformatOrderCart();

    setState(() {
      cartData = cart.getAllItemCart();
      AppState().typeTransaction = 'dine-in';
      typeTransaction = 'dine-in';
    });
    // cartData = cart.getAllItemCart();

    // Future.delayed(Duration(milliseconds: 300), () {
    //   setState(() {
    //     // item = AppState().item;
    //     item = ListMenu;
    //     isLoading = false;

    //     // print(itemDisplay);
    //     itemDisplay = getItem();
    //     // orderList = AppState().confirmedOrders;
    //   });
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<dynamic> getItem() {
    // List<dynamic> filteredItems = filterSearch == ""
    //     ? item.where((_item) => _item["type"] == selectedGroup).toList()
    //     : item
    //         .where((_item) =>
    //             _item["type"] == selectedGroup &&
    //             _item["name"]
    //                 .toLowerCase()
    //                 .contains(filterSearch.toLowerCase()))
    //         .toList();
    List<dynamic> filteredItems = item.toList();
    // updateQty(filteredItems);
    // print('filtered, ${cartData}');
    return filteredItems;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double smallButtonWidth = screenWidth * 0.05;
    double buttonWidth = screenWidth * 0.15;
    double dataContentWidth = MediaQuery.sizeOf(context).width * 0.25;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            TopBar(
              isSelected: 'invoice',
              onTapRefresh: () {
                onCallItemGroup();
                onCallItemPrice();
                onCallItem();
                onCallDataPosCart();
                onCallDataPosOrder();

                reformatOrderCart();
              },
            ),
            Expanded(
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    // crossAxisAlignment: CrossAxisAlignment.left,
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
                            if (modeView == 'item')
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 60.0, 8.0, 8.0),
                                child: FilterBar(
                                  onFilterSelected: (String type) {},
                                ),
                              ),
                            if (modeView == 'item')
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
                                                // Text('testing'),
                                              ],
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            if (modeView == 'orderPay')
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
                                            // print(
                                            //     'check order, ${orderDisplay[index]}');
                                            // final currentOrderId =
                                            //     AppState().currentOrderId;
                                            final order = orderDisplay[index];
                                            dynamic orderItemList =
                                                order['items'];
                                            // final isSelected =
                                            //     order.idOrder == currentOrderId;
                                            return InkWell(
                                              onTap: () {
                                                // AppState().setCurrentOrderId(order
                                                //     .idOrder); // Update the currentOrderId in AppState
                                                // onOrderSelected(order.idOrder);
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
                                                                    print(
                                                                        'check item qty, ${orderItem['quantity']}');
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
                            width: dataContentWidth,
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
                                                            .resetInvoiceCart();
                                                        cartData = [];
                                                        modeView = 'item';
                                                        cartSelected = null;
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
                              width: dataContentWidth,
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

                                            String addon2 = '';
                                            String catatan = '';
                                            String preference = '';
                                            totalAddon = 0;
                                            List<dynamic> addons = [];

                                            catatan = itemData.notes.toString();

                                            if (itemData.addon != null) {}

                                            // if (itemData.addon!.isNotEmpty) {
                                            //   itemData.addon!.forEach((value) {
                                            //     addons.add({
                                            //       'name': value['nama_menu'],
                                            //       'qty': value['qty'],
                                            //       'price': numberFormat('idr', value['harga']),
                                            //     });
                                            //     // String itemName = value["itemName"] as String;
                                            //     // String price = value["price"];

                                            //     // addon2 +=
                                            //     //     "$itemName - (${numberFormat('idr', double.parse(price))})\n";
                                            //     totalAddon +=
                                            //         (double.parse(value['harga'].toString()).toInt() *
                                            //             double.parse(value['qty'].toString()).toInt());
                                            //   });
                                            // }

                                            if (itemData.preference != null) {
                                              int i = 1;
                                              // itemData.preference.forEach((element) {
                                              //   preference +=
                                              //       "${element['type']}: ${element['name']}";
                                              //   if (i < itemData.pref!.length) {
                                              //     preference += ", ";
                                              //   }
                                              //   i++;
                                              // });
                                            }

                                            return ListCart(
                                              title:
                                                  "${itemData.itemName} (${itemData.qty})",
                                              subtitle:
                                                  itemData.itemName ?? '-',
                                              // addon: addon2,
                                              // addons: addons,
                                              qty: itemData.qty.toString(),
                                              catatan: preference,
                                              titleStyle: CustomTextStyles
                                                  .labelLargeBlack,
                                              price: itemData.price.toString(),
                                              total: numberFormat(
                                                  'idr',
                                                  itemData.qty *
                                                      (itemData.price +
                                                          totalAddon)),
                                              priceStyle: CustomTextStyles
                                                  .labelLargeBlack,
                                              labelStyle: CustomTextStyles
                                                  .bodySmallBluegray300,
                                              editLabelStyle: TextStyle(
                                                color:
                                                    theme.colorScheme.primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              padding: EdgeInsets.all(16),
                                              note: itemData.notes ?? '',
                                              lineColor: appTheme.gray200,
                                              secondaryStyle: CustomTextStyles
                                                  .bodySmallGray,
                                              isEdit: isEdit,
                                              onTap: () => onTapEditItem(
                                                  context, itemData, index),
                                            );
                                          },
                                        ),
                                        // ],
                                      ),
                                    ),
                                  if (cart.items.isEmpty) EmptyCart()
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.07,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: BottomNavigationInvoice(
                isSelected: modeView,
                onTapOrderToPay: () {
                  setState(() {
                    modeView = 'orderPay';
                  });
                },
                onTapItem: () {
                  setState(() {
                    modeView = 'item';
                  });
                },
                onTapPay: () {
                  if (cartData.isNotEmpty) {
                    onTapPay(context);
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

  void onCallItemGroup() async {
    // isLoading = true;

    final FrappeFetchDataItemGroup.ItemGroupRequest requestItemGroup =
        FrappeFetchDataItemGroup.ItemGroupRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: '[]',
    );

    try {
      final itemGroupRequset = await FrappeFetchDataItemGroup.requestItemGroup(
              requestQuery: requestItemGroup)
          .timeout(
        Duration(seconds: 30),
      );

      setState(() {
        AppState().dataItemGroup = itemGroupRequset;
        // itemDisplay = itemGroupRequset;
        // isLoading = false;
      });
    } catch (error) {
      isLoading = false;
      if (error is TimeoutException) {
        // Handle timeout error
        // _bottomScreenTimeout(context);
        if (context.mounted) {
          alert.alertError(
              context, 'Gagal mengambil data item group dari server');
        }
      } else {
        if (context.mounted) {
          alert.alertError(context, error.toString());
        }
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
        if (context.mounted) {
          alert.alertError(
              context, 'Gagal mengambil data item price dari server');
        }
      } else {
        if (context.mounted) {
          alert.alertError(context, error.toString());
        }
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
        if (context.mounted) {
          alert.alertError(context, 'Gagal mengambil data item dari server');
        }
      } else {
        if (context.mounted) {
          alert.alertError(context, error.toString());
        }
      }
      return;
    }
  }

  List<dynamic> reformatItem(List<dynamic> item) {
    return item.where((itm) => itm['item_group'] != 'Addon').toList();
  }

  void onSearch(BuildContext context, dynamic value) async {}

  TextEditingController enterGuestNameController = TextEditingController();
  FocusNode inputPhone = FocusNode();

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
          'variant': item.variant,
          'variantId': item.variantId,
          'qty': item.qty,
          'variantPrice': item.variantPrice,
          'totalPrice': item.totalPrice,
          'addonsPrice': item.addonsPrice,
        };

        return Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: AddToCart(
            dataMenu: editItem,
            idxMenu: index,
          ),
        );
      },
    ).then((value) => {});
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

  void addToCartFromOrder(BuildContext context, dynamic order) async {
    setState(() {
      cart.clearCart();
    });
    const Duration(seconds: 1);

    for (int a = 0; a < order['items'].length; a++) {
      InvoiceCartItem newItem = InvoiceCartItem(
        id: order['items'][a]['name'],
        name: order['items'][a]['item'],
        itemName: order['items'][a]['item_name'],
        itemGroup: order['items'][a]['item_group'],
        uom: order['items'][a]['uom'] ?? '',
        description:
            order['items'][a]['description'] ?? order['items'][a]['item_name'],
        qty: order['items'][a]['qty'],
        price: order['items'][a]['price'].floor(),
        notes: order['items'][a]['note'],
        preference: order['items'][a]['preference'] ?? {},
        status: order['items'][a]['docstatus'] == 1 ? true : false,
        cartId: order['name'],
      );

      setState(() {
        cart.addItem(newItem, mode: InvoiceCartMode.add);
      });
    }
    setState(() {
      enterGuestNameController.text = order.namaPemesan;
      typeTransaction = 'dine-in';
      cartData = cart.getAllItemCart();
      isEdit = false;
    });
    // order.forEach((dt) {
    //   print('check, $dt');
    // });
  }

  void onTapPay(BuildContext context) async {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.paymentScreen,
      (route) => false,
    );
  }

  onCallPosCart() async {
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
      final callReqPosCart =
          await FrappeFetchCreateCart.request(requestQuery: request);

      if (callReqPosCart.isNotEmpty) {
        cartSelected = callReqPosCart;
      }
    } catch (error) {
      if (context.mounted) {
        print('error pos cart, $error');
        alert.alertError(context, error.toString());
      }
    }

    if (cartSelected != null) {
      for (InvoiceCartItem itm in cartData) {
        print('cart data, ${itm.qty}');
        dynamic itemReq = {
          'item': itm.name,
          'item_name': itm.itemName,
          'item_group': itm.itemGroup,
          'uom': itm.uom,
          'qty': itm.qty,
          'notes': itm.notes,
          'cartId': cartSelected.name,
        };
        onCallPosOrder(itemReq);
      }
    }
  }

  onCallPosOrder(dynamic paramItem) async {
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
      uom: paramItem['uom'],
      note: paramItem['notes'],
      qty: paramItem['qty'],
    );

    try {
      final reqPosOrder =
          await FrappeFetchCreateOrder.request(requestQuery: request);
    } catch (error) {
      print('error pos order, $error');
      if (context.mounted) {
        alert.alertError(context, error.toString());
      }
    }
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

      if (callRequest.isNotEmpty) {
        setState(() {
          tempPosCart = callRequest;
        });
      }
    } catch (error) {
      print('error call data pos cart, $error');
      if (context.mounted) {
        alert.alertError(context, error.toString());
      }
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

      if (callRequest.isNotEmpty) {
        setState(() {
          tempPosOrder = callRequest;
        });
      }
    } catch (error) {
      print('error call data pos order, $error');
      if (context.mounted) {
        alert.alertError(context, error.toString());
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
}
