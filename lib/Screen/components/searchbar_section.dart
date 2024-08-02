import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.65,
      color: Colors.white,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Menu',
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
        ),
      ),
    );
  }
}