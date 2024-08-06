import 'package:flutter/material.dart';
import 'package:kontena_pos/constants.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final double smallButtonWidth;
  final double buttonWidth;
  final bool isWideScreen;

  const TopBar({
    super.key,
    required this.smallButtonWidth,
    required this.buttonWidth,
    required this.isWideScreen,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: buttoncolor, // Set the background color
      titleSpacing: 0, // Ensure the title starts at the edge
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: smallButtonWidth,
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  height: 45,
                  child: const Icon(Icons.refresh, color: Colors.white),
                  onPressed: () {
                    // Define the action for the refresh button
                  },
                ),
              ),
              Container(
                width: buttonWidth,
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  height: 45,
                  onPressed: () {
                    // Define the action for the Order button
                  },
                  child: const Text(
                    'Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (isWideScreen) ...[
                Container(
                  width: buttonWidth,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: MaterialButton(
                    height: 45,
                    onPressed: () {
                      // Define the action for the Invoice button
                    },
                    child: const Text(
                      'Invoice',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: buttonWidth,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: MaterialButton(
                    height: 45,
                    onPressed: () {
                      // Define the action for the History button
                    },
                    child: const Text(
                      'History',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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
                  height: 45,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
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
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              Container(
                width: smallButtonWidth,
                height: 45,
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    // Define the action for the MaterialButton
                  },
                  child: const Icon(Icons.settings, color: Colors.white),
                ),
              ),
              Container(
                height: 45,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const Row(
                  children: [
                    Text(
                      'Administrator',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
