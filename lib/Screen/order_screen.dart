import 'package:flutter/material.dart';
import 'package:pos_kontena/Screen/components/appbar_section.dart';
import 'package:pos_kontena/Screen/components/buttonfilter_section.dart';
import 'package:pos_kontena/Screen/components/cardmenu_section.dart';
import 'package:pos_kontena/Screen/components/footer_section.dart';
import 'package:pos_kontena/Screen/components/searchbar_section.dart';
import 'package:pos_kontena/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:pos_kontena/data/menu.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWideScreen = screenWidth > 800;

    // Define widths based on the screen width
    double buttonWidth = screenWidth * 0.15; // 15% of the screen width
    double smallButtonWidth = screenWidth * 0.05; // 5% of the screen width

    return Scaffold(
      appBar: BuildAppbar(
        smallButtonWidth: smallButtonWidth,
        buttonWidth: buttonWidth,
        isWideScreen: isWideScreen,
      ),
      body: Container(
        color: itembackgroundcolor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Integrate Searchbar component
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  width: screenWidth * 0.65,
                  child: Searchbar(screenWidth: screenWidth),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Input Guest Name',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            width: smallButtonWidth,
                            child: MaterialButton(
                              height: 55,
                              minWidth: 0,
                              onPressed: () {
                                // Handle the action for the search button
                              },
                              child: Icon(Icons.search_outlined, color: Colors.black),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            width: smallButtonWidth,
                            child: MaterialButton(
                              height: 55,
                              minWidth: 0,
                              onPressed: () {
                                // Handle the action for the person button
                              },
                              child: Icon(Icons.person, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Container(
                            width: screenWidth * 0.30,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text("Select an Option"),
                              value: selectedValue,
                              items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue;
                                });
                              },
                            ),
                          ),
                      
                    ],
                  ),
                ),
              ],
            ),
            // Buttons
            ButtonFilter(),
            // Expanded widget for CardMenu to fill remaining space
            CardMenu(),
            // Footer
            Footer(screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }
}
