import 'package:flutter/material.dart';
import 'package:kontena_pos/constants.dart';

class ConfirmButton extends StatefulWidget {
  final double screenWidth;
  final bool isEnabled; // Add this

  ConfirmButton({
    super.key,
    required this.screenWidth,
    required this.isEnabled, // Add this
  });

  @override
  _ConfirmButtonState createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  @override
  Widget build(BuildContext context) {
    var buttoncolor2 = widget.isEnabled ? buttoncolor : Colors.grey;

    return Container(
      height: 50,
      width: widget.screenWidth * 0.35,
      child: MaterialButton(
        color: buttoncolor2,
        textColor: Colors.white,
        onPressed: widget.isEnabled
            ? () {
                print("Confirm Pressed");
              }
            : null, // Disable button when not enabled
        child: Center(
          child: Text(
            "Confirm",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
