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
    return Row(
        children: <Widget>[
          Expanded(
            child: _buildFooterButton(
              text: 'Order',
              onPressed: () {
                // Handle Order button press
              },
            ),
          ),
          Expanded(
            child: _buildFooterButton(
              text: 'Confirm',
              onPressed: () {
                // Handle Confirm button press
              },
            ),
          ),
          Expanded(
            child: _buildFooterButton(
              text: 'Served',
              onPressed: () {
                // Handle Served button press
              },
            ),
          ),
        ],
    
    );
  }

  Widget _buildFooterButton({required String text, required VoidCallback onPressed}) {
    return Container(
      height: 50,
      width: screenWidth * 0.35,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.white, width: 1.0),
        ),
      ),
      alignment: Alignment.center,
      child: MaterialButton(
        color: buttoncolor,
        textColor: Colors.white,
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
