import 'package:flutter/material.dart';
import 'package:pos_kontena/Screen/components/appbar_section.dart';
import 'package:pos_kontena/Screen/components/buttonfilter_section.dart';
import 'package:pos_kontena/Screen/components/cardmenu_section.dart';
import 'package:pos_kontena/Screen/components/searchbar_section.dart';
import 'package:pos_kontena/constants.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWideScreen = screenWidth > 800;

    // Define widths based on the screen width
    double buttonWidth = screenWidth * 0.15; // 15% of the screen width
    double smallButtonWidth = screenWidth * 0.05; // 5% of the screen width
    double bottomBarWidth = screenWidth * 0.65; // 65% of the screen width

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
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Searchbar(screenWidth: screenWidth),
            ),
            // Buttons
            ButtonFilter(),
            // Menu cards
            cardmenu(), // Adjust this if necessary
          ],
        ),
      ),
      bottomNavigationBar: Container(
  width: MediaQuery.of(context).size.width * 0.65,
  color: Colors.blue,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      IconButton(
        icon: Icon(Icons.home, color: Colors.white),
        onPressed: () {
          // Handle home button press
        },
      ),
      IconButton(
        icon: Icon(Icons.search, color: Colors.white),
        onPressed: () {
          // Handle search button press
        },
      ),
      IconButton(
        icon: Icon(Icons.notifications, color: Colors.white),
        onPressed: () {
          // Handle notifications button press
        },
      ),
      IconButton(
        icon: Icon(Icons.account_circle, color: Colors.white),
        onPressed: () {
          // Handle profile button press
        },
      ),
    ],
  ),
),

    );
  }
}
