import 'package:flutter/material.dart';
import 'package:kontena_pos/constants.dart';

class BuildAppbar extends StatelessWidget implements PreferredSizeWidget {
  const BuildAppbar({
    super.key,
    required this.smallButtonWidth,
    required this.buttonWidth,
    required this.isWideScreen,
  });

  final double smallButtonWidth;
  final double buttonWidth;
  final bool isWideScreen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: buttoncolor, // Set the background color
      titleSpacing: 0, // Ensure the title starts at the edge
      toolbarHeight: 50, // Set the height of the AppBar
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: smallButtonWidth,
                height: 50, // Set height of Container
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  height: 50, // Set height of MaterialButton
                  minWidth: 0,
                  child: Icon(Icons.refresh, color: Colors.white),
                  onPressed: () {
                    // Define the action for the refresh button
                  },
                ),
              ),
              Container(
                width: buttonWidth,
                height: 50, // Set height of Container
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  height: 50, // Set height of MaterialButton
                  minWidth: 0,
                  onPressed: () {
                    // Define the action for the Order button
                  },
                  child: const Text(
                    'Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (isWideScreen) ...[
                Container(
                  width: buttonWidth,
                  height: 50, // Set height of Container
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: MaterialButton(
                    height: 50, // Set height of MaterialButton
                    minWidth: 0,
                    onPressed: () {
                      // Define the action for the Invoice button
                    },
                    child: const Text(
                      'Invoice',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: buttonWidth,
                  height: 50, // Set height of Container
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: MaterialButton(
                    height: 50, // Set height of MaterialButton
                    minWidth: 0,
                    onPressed: () {
                      // Define the action for the History button
                    },
                    child: const Text(
                      'History',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          Row(
            children: [
              if (isWideScreen)
                Container(
                  width: buttonWidth,
                  height: 50, // Set height of Container
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Shokudo Restaurant',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              Container(
                width: smallButtonWidth,
                height: 50, // Set height of Container
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  height: 50, // Set height of MaterialButton
                  minWidth: 0,
                  onPressed: () {
                    // Define the action for the MaterialButton
                  },
                  child: const Icon(Icons.settings, color: Colors.white),
                ),
              ),
              Container(
                height: 50, // Set height of Container
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: const [
                    Text(
                      'Agil Mahardika',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 8), // Space between text and icon
                    Icon(Icons.person, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40); // Set preferred size of AppBar
}
