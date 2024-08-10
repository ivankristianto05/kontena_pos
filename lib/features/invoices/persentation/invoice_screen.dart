import 'package:flutter/material.dart';
import 'package:kontena_pos/Screen/components/buttonfilter_section.dart';
import 'package:kontena_pos/Screen/components/dropdown_delete_section.dart';
import 'package:kontena_pos/Screen/components/guestinputwithbutton_section.dart';
import 'package:kontena_pos/Screen/components/itemcart_section.dart';
import 'package:kontena_pos/Screen/components/searchbar_section.dart';
import 'package:kontena_pos/core/app_export.dart';
import 'package:kontena_pos/data/menu.dart';
import 'package:kontena_pos/features/cart/persentation/add_to_cart.dart';
import 'package:kontena_pos/features/cart/persentation/cart_list_item.dart';
import 'package:kontena_pos/features/invoices/persentation/bottom_navigation.dart';
import 'package:kontena_pos/features/products/persentation/product_grid.dart';
import 'package:kontena_pos/widgets/custom_text_form_field.dart';
import 'package:kontena_pos/widgets/empty_cart.dart';
import 'package:kontena_pos/widgets/top_bar.dart';
// import 'package:kontena_pos/models/cart_item.dart';
import 'package:kontena_pos/core/functions/cart.dart';
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double searchbarWidth = screenWidth * 0.65;
    double smallButtonWidth = screenWidth * 0.05;
    double buttonWidth = screenWidth * 0.15;

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
                isWideScreen: true,
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
                              onSearchChanged: (p0) => {},
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
                                child: ProductGrid(
                                  items: ListMenu,
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      enableDrag: false,
                                      backgroundColor: Color(0x8A000000),
                                      barrierColor: Color(0x00000000),
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: AddToCart(),
                                        );
                                      },
                                    ).then((value) => (value) {
                                          print('value, ${value}');
                                        });
                                    print('yest');
                                  },
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
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            height: MediaQuery.sizeOf(context).height * 0.06,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                            ),
                            child: GuestInputWithButton(
                              // width: screenWidth * 0.3,
                              guestNameController: enterGuestNameController,
                              smallButtonWidth: smallButtonWidth,
                              screenWidth: 10,
                            ),
                          ),
                          // Container(
                          //   child: EmptyCart(
                          //     screenWidth:
                          //         MediaQuery.sizeOf(context).width * 0.35,
                          //   ),
                          // )
                          DropdownDeleteSection(),
                          Expanded(
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.3,
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
                child: BottomNavigationInvoice()),
          ],
        ),
      ),
    );
  }

  TextEditingController enterGuestNameController = TextEditingController();
  FocusNode inputPhone = FocusNode();
}
