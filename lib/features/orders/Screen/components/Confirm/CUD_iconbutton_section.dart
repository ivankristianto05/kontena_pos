import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kontena_pos/features/orders/Screen/popup/confirm_input.dart';
import 'package:kontena_pos/constants.dart';

class CUDIconButton extends StatefulWidget {
  const CUDIconButton({super.key});

  @override
  _CUDIconButtonState createState() => _CUDIconButtonState();
}

class _CUDIconButtonState extends State<CUDIconButton> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        children: [
          // PLUS icon button
          Container(
            width: screenWidth * 0.05,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
            child: MaterialButton(
              height: 50,
              padding: EdgeInsets.zero,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmInput(); // Panggil widget ConfirmInputMenu di sini
                  },
                );
              },
              child: FaIcon(FontAwesomeIcons.plus, color: Colors.grey),
            ),
          ),
          // Change icon button
          Container(
            width: screenWidth * 0.05,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
            child: MaterialButton(
              height: 50,
              padding: EdgeInsets.zero,
              onPressed: () {
                // Clear all items from the cart
                setState(() {});
              },
              child: FaIcon(FontAwesomeIcons.rightLeft,
                  color: Colors.cyan, size: 18),
            ),
          ),
          // Delete icon button
          Container(
            width: screenWidth * 0.05,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(),
            ),
            child: MaterialButton(
              height: 50,
              padding: EdgeInsets.zero,
              onPressed: () {
                // Clear all items from the cart
                setState(() {});
              },
              child: Icon(Icons.delete, color: redcolor),
            ),
          ),
        ],
      ),
    );
  }
}
