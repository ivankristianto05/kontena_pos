import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add this for accessing AppState
import 'package:kontena_pos/constants.dart';
import 'package:kontena_pos/app_state.dart'; // Import the AppState

class ConfirmButton extends StatefulWidget {
  final double screenWidth;
  final bool isEnabled;

  ConfirmButton({
    super.key,
    required this.screenWidth,
    required this.isEnabled,
  });

  @override
  _ConfirmButtonState createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final orderId = appState.currentOrderId;
    var buttoncolor2 = widget.isEnabled && appState.isOrderFullyChecked(orderId) ? buttoncolor : Colors.grey;

    return Container(
      height: 50,
      width: widget.screenWidth * 0.35,
      child: MaterialButton(
        color: buttoncolor2,
        textColor: Colors.white,
        onPressed: buttoncolor2 == buttoncolor
            ? () {
                if (orderId.isNotEmpty) {
                  appState.confirmOrderStatus(orderId);
                  print("Order $orderId confirmed");
                }
              }
            : null,
        child: Center(
          child: Text('Confirm',style: TextStyle(fontSize: 18),),
        ),
      ),
    );
  }
}
