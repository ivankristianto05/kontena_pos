import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GuestInputWithButton extends StatelessWidget {
  const GuestInputWithButton({
    super.key,
    required this.searchbarWidth,
    required TextEditingController guestNameController,
    required this.smallButtonWidth,
  }) : _guestNameController = guestNameController;

  final double searchbarWidth;
  final TextEditingController _guestNameController;
  final double smallButtonWidth;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 55, // Ensuring the height is consistent
              child: Stack(
                children: [
                  TextField(
                    controller: _guestNameController,
                    decoration: InputDecoration(
                      hintText: 'Input Guest Name',
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 18,horizontal: 8),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Visibility(
                      visible: _guestNameController.text.isNotEmpty,
                      child: IconButton(
                        icon: FaIcon(FontAwesomeIcons.circleXmark),
                        onPressed: () {
                          _guestNameController.clear();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: smallButtonWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                left: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
            child: MaterialButton(
              height: 55,
              minWidth: 0,
              onPressed: () {
                // Handle the action for the search button
              },
              child: Icon(Icons.search_outlined, color: Colors.black),
            ),
          ),
          Container(
            color: Colors.white,
            width: smallButtonWidth,
            child: MaterialButton(
              height: 55,
              minWidth: 0,
              onPressed: () {
                // Handle the action for the person button
              },
              child: FaIcon(FontAwesomeIcons.userPlus, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
