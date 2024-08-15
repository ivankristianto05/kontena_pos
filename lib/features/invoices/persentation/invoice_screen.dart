import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kontena_pos/Screen/components/buttonfilter_section.dart';
import 'package:kontena_pos/Screen/components/dropdown_delete_section.dart';
import 'package:kontena_pos/Screen/components/guestinputwithbutton_section.dart';
import 'package:kontena_pos/Screen/components/itemcart_section.dart';
import 'package:kontena_pos/Screen/components/searchbar_section.dart';
import 'package:kontena_pos/Screen/popup/itemdialog_section.dart';
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
// import 'package:kontena_pos/models/cart_item.dart';
import 'package:kontena_pos/core/functions/cart.dart';
import 'package:skeletonizer/skeletonizer.dart';
// import 'package:kontena_pos/core/functions/cart.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<ItemCart> cartItem;
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

  //  final String id;
  // final String name;
  // String? variant;
  // int qty;
  // final int price;
  // late int totalPrice;
  // Map<String, Map<String, dynamic>>? addons;
  // final String notes;
  // final Map<String, String> preference;
  // String? type;

  @override
  void initState() {
    super.initState();
    cartData = cart.getAllItemCart();

    Future.delayed(const Duration(milliseconds: 300), () {
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
    // double searchbarWidth = screenWidth * 0.65;
    double smallButtonWidth = screenWidth * 0.05;
    double buttonWidth = screenWidth * 0.15;
    double dataContentWidth = MediaQuery.sizeOf(context).width * 0.25;
    // bool isWideScreen = screenWidth > 800;
    // int crossAxisCount = isWideScreen ? 5 : 2;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 45.0,
              decoration: BoxDecoration(
                color: theme.colorScheme.onBackground,
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
                                  8.0, 55.0, 8.0, 0.0),
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
                                // child: ProductGrid(
                                //   items: ListMenu,
                                //   onTap: () async {
                                //     await showModalBottomSheet(
                                //       isScrollControlled: true,
                                //       enableDrag: false,
                                //       backgroundColor: Color(0x8A000000),
                                //       barrierColor: Color(0x00000000),
                                //       context: context,
                                //       builder: (context) {
                                //         return Padding(
                                //           padding:
                                //               MediaQuery.viewInsetsOf(context),
                                //           child: AddToCart(),
                                //         );
                                //       },
                                //     ).then((value) => (value) {
                                //           print('value, ${value}');
                                //         });
                                //   },
                                // ),
                                child: SingleChildScrollView(
                                  child: (isLoading == false &&
                                          itemDisplay.isEmpty)
                                      ?
                                      //       : Column(
                                      //           children: [
                                      //             GridView.builder(
                                      //               gridDelegate:
                                      //                   SliverGridDelegateWithFixedCrossAxisCount(
                                      //                 crossAxisCount: crossAxisCount,
                                      //                 crossAxisSpacing: 8.0,
                                      //                 mainAxisSpacing: 8.0,
                                      //               ),
                                      //               itemCount: itemDisplay.length,
                                      //               itemBuilder: ((context, index) {
                                      //                 print(
                                      //                     'item display --, ${itemDisplay.length}');
                                      //                 if (isLoading) {
                                      //                   print('item 1');
                                      //                   return Skeletonizer(
                                      //                     enabled: isLoading,
                                      //                     child: const ProductGrid(),
                                      //                   );
                                      //                 } else {
                                      //                   print('item 2');
                                      //                   Map<String, dynamic>
                                      //                       currentItem =
                                      //                       itemDisplay[index];
                                      //                   print(
                                      //                       'current item, ${currentItem}');
                                      //                   String itemDescription =
                                      //                       "${currentItem["description"]}";

                                      //                   return ProductGrid(
                                      //                       name: currentItem[
                                      //                           'nama_menu']);
                                      //                 }
                                      //               }),
                                      //             ),
                                      //           ],
                                      //         ),
                                      Container(
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
                                                // mainAxisSpacing: 4,
                                                // crossAxisSpacing: 4,
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
                            child: GuestInputWithButton(
                              // width: screenWidth * 0.3,
                              guestNameController: enterGuestNameController,
                              smallButtonWidth: smallButtonWidth,
                              searchbarWidth: 10,
                            ),
                          ),
                          SizedBox(
                            width: dataContentWidth,
                            child: const DropdownDeleteSection(),
                          ),
                          Expanded(
                            child: Container(
                              width: dataContentWidth,
                              height: 300.0,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (cartData.isNotEmpty)
                                    CardListItem(
                                      cartData: cartData,
                                    ),
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
              height: 60.0,
              decoration: BoxDecoration(
                color: theme.colorScheme.onBackground,
              ),
              child: BottomNavigationInvoice(
                dataContentWidth: dataContentWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController enterGuestNameController = TextEditingController();
  FocusNode inputPhone = FocusNode();

  void onTapOpenItem(BuildContext context, dynamic item) async {
    print('check item, $item');
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
          child: AddToCart(dataMenu: item),
        );
      },
    ).then((value) => {});
  }
}
