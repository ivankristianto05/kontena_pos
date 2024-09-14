import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For accessing AppState
import 'package:kontena_pos/constants.dart';
import 'package:kontena_pos/app_state.dart'; // Import the AppState

class ConfirmButton extends StatefulWidget {
  final double screenWidth;

  ConfirmButton({
    super.key,
    required this.screenWidth,
  });

  @override
  _ConfirmButtonState createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final orderId = appState.currentOrderId;

    // Enable button only if the current order ID is fully checked
    bool isEnabled = appState.isOrderFullyChecked(orderId);
    var buttonColor = isEnabled ? buttoncolor : Colors.grey;

    return Container(
      height: 50,
      width: widget.screenWidth * 0.35,
      child: MaterialButton(
        color: buttonColor,
        textColor: Colors.white,
        onPressed: isEnabled
            ? () {
                if (orderId.isNotEmpty) {
                  appState.confirmOrderStatus(orderId);
                  print("Order $orderId confirmed");
                }
              }
            : null,
        child: Center(
          child: Text(
            'Confirm',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
