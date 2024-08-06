import 'package:flutter/material.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/features/products/persentation/product_filter.dart';
import 'package:kontena_pos/widgets/dropdown_delete.dart';
import 'package:kontena_pos/widgets/no_cart.dart';
import 'package:kontena_pos/widgets/searchbar.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/data/menu.dart';
import 'package:kontena_pos/features/products/persentation/product_grid.dart';
import 'package:kontena_pos/widgets/card_item.dart';
import 'package:kontena_pos/widgets/top_bar.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isWideScreen = screenWidth > 800;

    double searchbarWidth = screenWidth * 0.65;
    double inputGuestNameWidth = screenWidth * 0.25;
    double smallButtonWidth = screenWidth * 0.05;
    double buttonWidth = screenWidth * 0.15;

    int crossAxisCount = isWideScreen ? 6 : 2;
    return Scaffold(
      appBar: TopBar(
        smallButtonWidth: smallButtonWidth,
        buttonWidth: buttonWidth,
        isWideScreen: isWideScreen,
      ),
      body: Container(
        color: appTheme.gray200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Searchbar
                SizedBox(
                  width: searchbarWidth,
                  child: Searchbar(
                    screenWidth: screenWidth,
                  ),
                ),
                Container(
                  // decoration: const BoxDecoration(
                  //   border: Border(
                  //     bottom: BorderSide(
                  //       color: Colors.grey,
                  //       width: 1.0,
                  //     ),
                  //   ),
                  // ),
                  width: screenWidth - searchbarWidth,
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                        width: inputGuestNameWidth,
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Input Guest Name',
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      Container(
                        width: smallButtonWidth,
                        color: Colors.white,
                        child: MaterialButton(
                          height: 45,
                          minWidth: 0,
                          onPressed: () {
                            // Handle the action for the search button
                          },
                          child: const Icon(
                            Icons.search_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: smallButtonWidth,
                        child: MaterialButton(
                          height: 45,
                          minWidth: 0,
                          onPressed: () {
                            // Handle the action for the person button
                          },
                          child: const Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                // Button Filter
                SizedBox(
                  width: searchbarWidth,
                  child: const Row(
                    children: [
                      ProductFilter(),
                    ],
                  ),
                ),
                // Dropdown and Delete Button
                const DropdownDelete()
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  // Menu Cards
                  Expanded(
                    flex: 2,
                    child: ProductGrid(
                      items: ListMenu,
                    ),
                  ),
                  // Item Cart
                  // ItemCart(screenWidth: screenWidth),
                  if (AppState.cartItems.isNotEmpty)
                    Container()
                  else
                    EmptyCart(
                      screenWidth: screenWidth,
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
