import 'package:flutter/material.dart';
import 'package:pos_kontena/constants.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    var buttoncolor2 = buttoncolor;
    return Container(
      height: 50,
      width: screenWidth * 0.35,
      child: MaterialButton(
        color: buttoncolor2,
        textColor: Colors.white,
        onPressed: () {
          // Handle the action for the order button
        },
        child: Text("Order"),
      ),
    );
  }
}
