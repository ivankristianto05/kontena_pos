import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/models/list_to_confirm.dart';
import 'package:provider/provider.dart';

class GuestNameTextFieldButton extends StatefulWidget {
  final double screenWidth;
  final TextEditingController guestNameController;
  final double smallButtonWidth;

  const GuestNameTextFieldButton({
    Key? key,
    required this.screenWidth,
    required this.guestNameController,
    required this.smallButtonWidth,
  }) : super(key: key);

  @override
  _GuestNameTextFieldButtonState createState() => _GuestNameTextFieldButtonState();
}

class _GuestNameTextFieldButtonState extends State<GuestNameTextFieldButton> {
  @override
  void initState() {
    super.initState();
    _updateGuestName();
    // Listen for changes in AppState to update guest name
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppState>().addListener(_updateGuestName);
    });
  }

  @override
  void dispose() {
    context.read<AppState>().removeListener(_updateGuestName);
    super.dispose();
  }

  void _updateGuestName() {
    final appState = context.read<AppState>();
    final currentOrderId = appState.currentOrderId;

    // Find the order with the currentOrderId
    final order = appState.confirmedOrders
        .firstWhere((order) => order.idOrder == currentOrderId, orElse: () => ListToConfirm(idOrder: '', namaPemesan: '', table: '', items: []));
    
    // Update the TextEditingController with the guest name from the order
    widget.guestNameController.text = order.namaPemesan;
  }

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
                  // TextField untuk nama pemesan
                  TextField(
                    controller: widget.guestNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Guest Name',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   width: widget.smallButtonWidth,
          //   height: 55,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     border: Border(
          //       right: BorderSide(
          //         color: Colors.grey,
          //         width: 1.0,
          //       ),
          //     ),
          //   ),
          //   child: MaterialButton(
          //     height: 55,
          //     padding: EdgeInsets.zero,
          //     onPressed: () {
          //       // Handle search action here
          //     },
          //     child: Center(
          //       child: FaIcon(
          //         FontAwesomeIcons.magnifyingGlass,
          //         size: 16,
          //       ),
          //     ),
          //   ),
          // ),
          // Container(
          //   width: widget.smallButtonWidth,
          //   height: 55,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //   ),
          //   child: MaterialButton(
          //     height: 55,
          //     padding: EdgeInsets.zero,
          //     onPressed: () {
          //       // Handle action for person button
          //     },
          //     child: Center(
          //       child: FaIcon(
          //         FontAwesomeIcons.userPlus,
          //         size: 16,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}