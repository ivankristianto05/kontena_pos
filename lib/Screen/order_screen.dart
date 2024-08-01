import 'package:flutter/material.dart';
import 'package:pos_kontena/constants.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttoncolor, // Set the background color
        titleSpacing: 0, // Ensure the title starts at the edge
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                  child: MaterialButton(
                    minWidth: 60,
                    height: 65,
                    child: Icon(Icons.refresh, color: Colors.white),
                    onPressed: () {
                      // Define the action for the refresh button
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: MaterialButton(
                    minWidth: 230,
                    height: 65,
                    onPressed: () {
                      // Define the action for the Order button
                    },
                    child: Text(
                      'Order',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: MaterialButton(
                    minWidth: 230,
                    height: 65,
                    onPressed: () {
                      // Define the action for the Invoice button
                    },
                    child: Text(
                      'Invoice',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: MaterialButton(
                    minWidth: 230,
                    height: 65,
                    onPressed: () {
                      // Define the action for the History button
                    },
                    child: Text(
                      'History',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 65,
                  alignment: Alignment.center, // Align text in the center vertically
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Shokudo Restaurant',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                DropdownButton<String>(
                  dropdownColor: Colors.purple,
                  value: 'Agi Mahardika',
                  icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                  underline: SizedBox(), // Removes the underline
                  items: <String>['Agi Mahardika', 'Profile', 'Logout']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Define the action when selecting an item
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Order Page Content'),
      ),
    );
  }
}
