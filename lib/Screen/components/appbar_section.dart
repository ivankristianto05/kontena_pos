import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:kontena_pos/constants.dart';

class BuildAppbar extends StatelessWidget implements PreferredSizeWidget {
  const BuildAppbar({
    super.key,
    required this.smallButtonWidth,
    required this.buttonWidth,
  });

  final double smallButtonWidth;
  final double buttonWidth;

  @override
  Widget build(BuildContext context) {
    // Get screen width and orientation
    double screenWidth = MediaQuery.of(context).size.width;
    Orientation orientation = MediaQuery.of(context).orientation;

    // Adjust button widths
    double adjustedSmallButtonWidth = screenWidth * 0.08;
    double adjustedButtonWidth = (screenWidth * 0.65 - 100) / 4;

    return AppBar(
      automaticallyImplyLeading: false, // Menghilangkan tombol "Back"
      backgroundColor: buttoncolor,
      titleSpacing: 0,
      toolbarHeight: 50,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: adjustedSmallButtonWidth,
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  height: 50,
                  minWidth: 0,
                  child: Icon(Icons.refresh, color: Colors.white),
                  onPressed: () {
                    // Action for refresh button
                  },
                ),
              ),
              Container(
                width: adjustedButtonWidth,
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  height: 50,
                  minWidth: 0,
                  onPressed: () {
                    // Action for Order button
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
              Container(
                width: adjustedButtonWidth,
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  height: 50,
                  minWidth: 0,
                  onPressed: () {
                    // Action for Invoice button
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
                width: adjustedButtonWidth,
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  height: 50,
                  minWidth: 0,
                  onPressed: () {
                    // Action for History button
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
          ),
          Row(
            children: [
              Container(
                width: adjustedButtonWidth,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    'Shokudo Restaurant',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: orientation == Orientation.portrait ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                width: adjustedSmallButtonWidth,
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  height: 50,
                  minWidth: 0,
                  onPressed: () {
                    // Action for settings button
                  },
                  child: const Icon(Icons.settings, color: Colors.white),
                ),
              ),
              Container(
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: const [
                    Text(
                      'Agil Mahardika',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 8),
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
  Size get preferredSize => Size.fromHeight(50); // Adjust preferred size of AppBar if needed
}
