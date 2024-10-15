import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/constants.dart';
// import 'package:kontena_pos/Screen/components/Menu/buttonfilter_section.dart';
// import 'package:kontena_pos/Screen/components/Menu/guestinputwithbutton_section.dart';
// import 'package:kontena_pos/Screen/components/Menu/dropdown_delete_section.dart';
// import 'package:kontena_pos/Screen/components/Menu/itemcart_section.dart';
// import 'package:kontena_pos/Screen/components/itemcart_section.dart';
// import 'package:kontena_pos/Screen/components/searchbar_section.dart';
import 'package:kontena_pos/core/app_export.dart';
import 'package:kontena_pos/core/functions/cart.dart';
import 'package:kontena_pos/core/theme/custom_text_style.dart';
import 'package:kontena_pos/core/utils/number_ui.dart';
import 'package:kontena_pos/data/menu.dart';
import 'package:kontena_pos/features/cart/persentation/add_to_cart.dart';
import 'package:kontena_pos/features/cart/persentation/cart_list_item.dart';
import 'package:kontena_pos/features/invoices/persentation/action_button.dart';
import 'package:kontena_pos/features/invoices/persentation/bottom_navigation.dart';
import 'package:kontena_pos/features/products/persentation/product_grid.dart';
import 'package:kontena_pos/models/cartitem.dart';
import 'package:kontena_pos/widgets/custom_dialog.dart';
import 'package:kontena_pos/widgets/custom_text_form_field.dart';
import 'package:kontena_pos/widgets/empty_cart.dart';
import 'package:kontena_pos/widgets/filter_bar.dart';
import 'package:kontena_pos/widgets/list_cart.dart';
import 'package:kontena_pos/widgets/searchbar.dart';
import 'package:kontena_pos/widgets/top_bar.dart';
import 'package:kontena_pos/widgets/type_transaction.dart';
// import 'package:kontena_pos/models/cart_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // late List<ItemCart> cartItem;
  Cart cart = Cart(AppState());
  late Map cartRecapData;
  late List<CartItem> cartData;
  late List<Map<String, dynamic>> cartDataItem = [
    {
      'id': 'test',
      'name': 'Item 1',
      'qty': 3,
    }
  ];
  String filterSearch = '';
  bool isSearchActive = false;
  bool isLoading = true;
  String selectedGroup = '';
  List<dynamic> item = [];
  List<dynamic> itemDisplay = [];
  String searchItemQuery = '';
  String modeView = 'item';
  List<dynamic> orderList = [];
  String typeTransaction = '';
  int totalAddon = 0;
  int totalAddonCheckout = 0;
  bool isEdit = true;

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
  void initState() {
    super.initState();
    cartData = cart.getAllItemCart();
    print('check cart data, $cartData');
    // cartData = cart.getAllItemCart();

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        // item = AppState().item;
        item = ListMenu;
        isLoading = false;

        // print(itemDisplay);
        itemDisplay = getItem();
        orderList = AppState().confirmedOrders;
      });
    });
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
    print('filtered, ${cartData}');
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
                            // Searchbar(
                            //   screenWidth: MediaQuery.sizeOf(context).width,
                            //   onSearchChanged: (val) => {filterSearch = val},
                            // ),
                            Column(
                              children: [
                                Searchbar(
                                  onCompleted: () {},
                                ),
                              ],
                            ),
                            Container(),
                            // Padding(
                            //   padding: const EdgeInsetsDirectional.fromSTEB(
                            //       8.0, 65.0, 8.0, 8.0),
                            //   // child: ButtonFilter(
                            //   //   onFilterSelected: (String type) {},
                            //   // ),
                            //   child: Container(),
                            // ),
                            if (modeView == 'item')
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8.0, 50.0, 8.0, 8.0),
                                child: FilterBar(
                                  onFilterSelected: (String type) {},
                                ),
                              ),
                            if (modeView == 'item')
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8.0, 120.0, 8.0, 0.0),
                                child: Align(
                                  alignment:
                                      const AlignmentDirectional(0.00, 0.00),
                                  child: SingleChildScrollView(
                                    child: (isLoading == false &&
                                            itemDisplay.isEmpty)
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: Skeletonizer(
                                              enabled: isLoading,
                                              child: const ProductGrid(),
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
                                                          'nama_menu'],
                                                      category:
                                                          currentItem['type'],
                                                      price:
                                                          currentItem['harga']
                                                              .toString(),
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
                                                          index,
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
                                          itemCount: orderList.length,
                                          itemBuilder: (context, index) {
                                            final currentOrderId =
                                                AppState().currentConfirmOrderId;
                                            final order = orderList[index];
                                            final isSelected =
                                                order.idOrder == currentOrderId;
                                            return InkWell(
                                              onTap: () {
                                                AppState().setCurrentConfirmOrderId(order
                                                    .idOrder); // Update the currentOrderId in AppState
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
                                                                'Table ${order.table.toString()}',
                                                                style: theme
                                                                    .textTheme
                                                                    .titleMedium,
                                                              ),
                                                              Text(
                                                                typeTransaction
                                                                    .toString()
                                                                    .toUpperCase(),
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                order
                                                                    .namaPemesan
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
                                                                  AppState()
                                                                      .formatDateTime(
                                                                          order
                                                                              .time)
                                                                      .toString(),
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
                                                                  itemCount: order
                                                                      .items
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          i) {
                                                                    final cartItem =
                                                                        order.items[
                                                                            i];
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
                                                                            "${cartItem.qty}",
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
                                                                                  "${cartItem.name} - ${cartItem.variant ?? ''}",
                                                                                  style: theme.textTheme.titleMedium,
                                                                                  maxLines: 2, // Allows up to 2 lines
                                                                                  minFontSize: 10,
                                                                                  maxFontSize: 14,
                                                                                  overflow: TextOverflow.ellipsis, // Ellipsis if it exceeds 2 lines
                                                                                ),
                                                                                if ((cartItem.preference != null) && (cartItem.preference.values != null)) const SizedBox(height: 4),
                                                                                AutoSizeText(
                                                                                  "Preference: ${cartItem.preference.values.join(', ')}",
                                                                                  style: theme.textTheme.labelSmall,
                                                                                  maxLines: 1,
                                                                                  minFontSize: 10,
                                                                                  maxFontSize: 12,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                                if (cartItem.addons != null && cartItem.addons!.isNotEmpty) const SizedBox(height: 4),
                                                                                AutoSizeText(
                                                                                  "+ ${cartItem.addons!.keys.join(', ')}",
                                                                                  style: theme.textTheme.labelSmall,
                                                                                  maxLines: 1,
                                                                                  minFontSize: 10,
                                                                                  maxFontSize: 12,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                                if ((cartItem.notes != null) && (cartItem.notes != '')) const SizedBox(height: 4),
                                                                                AutoSizeText(
                                                                                  "Notes: ${cartItem.notes}",
                                                                                  style: theme.textTheme.labelSmall,
                                                                                  maxLines: 2,
                                                                                  minFontSize: 10,
                                                                                  maxFontSize: 12,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                              ],
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
                            height: MediaQuery.sizeOf(context).height * 0.06,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                            ),
                            child: CustomTextFormField(
                              controller: enterGuestNameController,
                              // focusNode: inputSearchVarian,
                              maxLines: 1,
                              // contentPadding: EdgeInsets.symmetric(
                              //   horizontal: 3.h,
                              //   vertical: 9.v,
                              // ),

                              borderDecoration: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.h),
                                borderSide: BorderSide(
                                  color: theme.colorScheme.outline,
                                  width: 0,
                                ),
                              ),
                              hintText: "Input guest name",
                            ),
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.25,
                            height: 60.0,
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
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.06,
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
                                                      print('yes confirm');
                                                      setState(() {
                                                        AppState().resetCart();
                                                        cartData = [];
                                                        modeView = 'item';
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
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.06,
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
                                  if (cart.items.isNotEmpty)
                                    SingleChildScrollView(
                                      primary: true,
                                      child: Container(
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

                                            if (itemData.pref != null) {
                                              int i = 1;
                                              itemData.pref?.forEach((element) {
                                                preference +=
                                                    "${element['type']}: ${element['name']}";
                                                if (i < itemData.pref!.length) {
                                                  preference += ", ";
                                                }
                                                i++;
                                              });
                                            }

                                            return Container(
                                              child: ListCart(
                                                title:
                                                    "${itemData.name} (${itemData.qty})",
                                                subtitle: itemData.name,
                                                // addon: addon2,
                                                // addons: addons,
                                                qty: itemData.qty.toString(),
                                                catatan: preference,
                                                titleStyle: CustomTextStyles
                                                    .labelLargeBlack,
                                                price:
                                                    itemData.price.toString(),
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
                                                note: itemData.notes,
                                                lineColor: appTheme.gray200,
                                                secondaryStyle: CustomTextStyles
                                                    .bodySmallGray,
                                                isEdit: isEdit,
                                                onTap: () => onTapOpenItem(
                                                    context, itemData, index),
                                              ),
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

  void onSearch(BuildContext context, dynamic value) async {}

  TextEditingController enterGuestNameController = TextEditingController();
  FocusNode inputPhone = FocusNode();

  void onTapOpenItem(BuildContext context, dynamic item, int? index) async {
    print('check data item ${item}');
    print('check data index ${index}');
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
          child: AddToCart(dataMenu: item),
        );
      },
    ).then((value) => {print('check value, $value')});
  }

  void onTapTypeTransaction(BuildContext context) async {
    showModalBottomSheet(
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
          child: TypeTransaction(
            selected: typeTransaction,
          ),
        );
      },
    ).then((value) => {print('check value, $value')});
  }

  void addToCartFromOrder(BuildContext context, dynamic order) async {
    print('order, ${order.idOrder}');
    print('nama pesanan, ${order.namaPemesan}');
    print('nama pesanan, ${order.items}');
    print('nama pesanan, ${order.items.length}');
    print('nama pesanan, ${order.items[0].name}');
    print('nama pesanan, ${order.items[0].qty}');
    print('nama pesanan, ${order.items[0].price}');
    print('nama pesanan, ${order.items[0].notes}');
    print('nama pesanan, ${order.items[0].preference}');
    // print('nama pesanan, ${order.items.toMap()}');
    print('nama pesanan, ${cart.getAllItemCart()}');
    setState(() {
      cart.clearAllItems();
      // AppState().resetCart();
    });
    const Duration(seconds: 1);

    for (int a = 0; a < order.items.length; a++) {
      CartItem newItem = CartItem(
        id: order.items[a].id,
        name: order.items[a].name,
        qty: order.items[a].qty,
        price: order.items[a].price,
        notes: order.items[a].notes,
        preference: order.items[a].preference,
      );

      setState(() {
        cart.addItem(newItem, mode: CartMode.add);
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
}
