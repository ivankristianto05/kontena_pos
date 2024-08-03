import 'package:flutter/material.dart';

class ItemCart extends StatelessWidget {
  const ItemCart({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.35,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'No Item Cart',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
