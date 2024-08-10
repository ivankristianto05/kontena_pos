import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GuestInputWithButton extends StatefulWidget {
  final double screenWidth;
  final TextEditingController guestNameController;
  final double smallButtonWidth;

  const GuestInputWithButton({
    Key? key,
    required this.screenWidth,
    required this.guestNameController,
    required this.smallButtonWidth,
  }) : super(key: key);

  @override
  _GuestInputWithButtonState createState() => _GuestInputWithButtonState();
}

class _GuestInputWithButtonState extends State<GuestInputWithButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth * 0.35,
      height: 55,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  TextField(
                    controller: widget.guestNameController,
                    decoration: InputDecoration(
                      hintText: 'Input Guest Name',
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Visibility(
                      visible: widget.guestNameController.text.isNotEmpty,
                      child: IconButton(
                        icon: FaIcon(FontAwesomeIcons.circleXmark),
                        onPressed: () {
                          widget.guestNameController.clear();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: widget.smallButtonWidth,
            height: 55,
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
              height: 55,
              padding: EdgeInsets.zero,
              onPressed: () {
                // Handle the action for the search button
              },
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 16,
                ),
              ),
            ),
          ),
          Container(
            width: widget.smallButtonWidth,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: MaterialButton(
              height: 55,
              padding: EdgeInsets.zero,
              onPressed: () {
                // Handle the action for the person button
              },
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.userPlus,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
