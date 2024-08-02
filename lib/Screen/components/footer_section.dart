import 'package:flutter/material.dart';
import 'package:pos_kontena/constants.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.65,
      color: buttoncolor,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildFooterButton(
            text: 'Order',
            onPressed: () {
              // Handle Order button press
            },
          ),
          _buildFooterButton(
            text: 'Confirm',
            onPressed: () {
              // Handle Confirm button press
            },
          ),
          _buildFooterButton(
            text: 'Served',
            onPressed: () {
              // Handle Served button press
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButton({required String text, required VoidCallback onPressed}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.white, width: 1.0),
          ),
        ),
        alignment: Alignment.center,
        child: MaterialButton(
          height: 50, // Set height to match AppBar buttons
          minWidth: 0, // Prevent stretching
          onPressed: onPressed,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20, // Ensure font size matches AppBar
                fontWeight: FontWeight.bold, // Ensure font weight matches AppBar
              ),
            ),
          ),
        ),
      ),
    );
  }
}
