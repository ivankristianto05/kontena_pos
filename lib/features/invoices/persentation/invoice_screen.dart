import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kontena_pos/Screen/components/Menu/buttonfilter_section.dart';
// import 'package:kontena_pos/Screen/components/itemcart_section.dart';
import 'package:kontena_pos/Screen/components/searchbar_section.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/app_export.dart';
import 'package:kontena_pos/data/menu.dart';
import 'package:kontena_pos/features/cart/persentation/add_to_cart.dart';
import 'package:kontena_pos/features/cart/persentation/cart_list_item.dart';
import 'package:kontena_pos/features/invoices/persentation/bottom_navigation.dart';
import 'package:kontena_pos/features/products/persentation/product_grid.dart';
import 'package:kontena_pos/widgets/card_item.dart';
import 'package:kontena_pos/widgets/custom_text_form_field.dart';
import 'package:kontena_pos/widgets/empty_cart.dart';
import 'package:kontena_pos/widgets/top_bar.dart';
import 'package:kontena_pos/widgets/type_transaction.dart';
import 'package:provider/provider.dart';
// import 'package:kontena_pos/models/cart_item.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:kontena_pos/core/functions/cart.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // late List<ItemCart> cartItem;
  Cart cart = Cart();
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
    // cartData = cart.getAllItemCart();
    cartData = cart.getAllItemCart();

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        // item = AppState().item;
        item = ListMenu;
        isLoading = false;

        // print(itemDisplay);
        itemDisplay = getItem();
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
    // print('filtered, ${filteredItems}');
    return filteredItems;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double smallButtonWidth = screenWidth * 0.05;
    double buttonWidth = screenWidth * 0.15;
    double dataContentWidth = MediaQuery.sizeOf(context).width * 0.25;
    context.watch<AppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              // height: 40.0,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.surface,
                    width: 1.0,
                  ),
                ),
              ),
              child: TopBar(
                smallButtonWidth: smallButtonWidth,
                buttonWidth: buttonWidth,
                // isWideScreen: true,
              ),
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
                            Searchbar(
                              screenWidth: MediaQuery.sizeOf(context).width,
                              onSearchChanged: (val) => {filterSearch = val},
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8.0, 65.0, 8.0, 8.0),
                              child: ButtonFilter(
                                onFilterSelected: (String type) {},
                              ),
                            ),
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
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          child: Column(
                                            children: [
                                              MasonryGridView.count(
                                                crossAxisCount: 5,
                                                mainAxisSpacing: 6,
                                                crossAxisSpacing: 6,
                                                shrinkWrap: true,
                                                itemCount: itemDisplay.length,
                                                itemBuilder: (context, index) {
                                                  final currentItem =
                                                      itemDisplay[index];
                                                  return ProductGrid(
                                                    name: currentItem[
                                                        'nama_menu'],
                                                    category:
                                                        currentItem['type'],
                                                    price: currentItem['harga']
                                                        .toString(),
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
                                              // Text('testing'),
                                            ],
                                          ),
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
                                  color: theme.colorScheme.surface,
                                  width: 0,
                                ),
                              ),
                              hintText: "Input guest name",
                            ),
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.25,
                            // height: 60.0,
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
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: theme
                                                .colorScheme.primaryContainer,
                                            border: Border(
                                              bottom: BorderSide(
                                                color:
                                                    theme.colorScheme.surface,
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
                                                (AppState().typeTransaction ==
                                                        '')
                                                    ? Text(
                                                        'Pilih Jenis Transaksi',
                                                        style: theme.textTheme
                                                            .labelMedium,
                                                      )
                                                    : Text(
                                                        AppState()
                                                            .typeTransaction
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          color: theme
                                                              .colorScheme
                                                              .secondary,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color:
                                                      theme.colorScheme.outline,
                                                  size: 24.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: dataContentWidth,
                              // height: double.infinity,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (cartData.isNotEmpty) CardListItem(),
                                  if (cartData.isEmpty) EmptyCart()
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
              child: BottomNavigationInvoice(),
            ),
          ],
        ),
      ),
    );
  }

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
          child: AddToCart(
            dataMenu: item,
            isNew: true,
          ),
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
          child: TypeTransaction(),
        );
      },
    ).then((value) => {});
  }
}
