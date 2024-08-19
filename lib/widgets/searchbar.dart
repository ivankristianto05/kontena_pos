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
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search Menu',
          // filled: true,
          // fillColor: Colors.white,
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }
}
