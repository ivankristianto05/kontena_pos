import 'dart:async';
import 'package:flutter/material.dart';

void alertError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.redAccent, // You can customize the color here
    ),
  );
}

void alertSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor:
          const Color(0xFF4A9D4D), // You can customize the color here
    ),
  );
}

void alertModalFailed(BuildContext context, String message) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    builder: (context) {
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pop(); // Close the bottom sheet after 3 seconds
      });

      return Container(
        width: MediaQuery.of(context).size.width, // Set width to screen width
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(color: Color.fromARGB(255, 248, 31, 1)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    },
  );
}
