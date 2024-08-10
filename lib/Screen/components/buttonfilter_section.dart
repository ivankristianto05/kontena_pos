import 'package:flutter/material.dart';
import 'package:kontena_pos/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ButtonFilter extends StatefulWidget {
  final void Function(String type) onFilterSelected;

  const ButtonFilter({
    Key? key,
    required this.onFilterSelected,
  }) : super(key: key);

  @override
  _ButtonFilterState createState() => _ButtonFilterState();
}

class _ButtonFilterState extends State<ButtonFilter> {
  String _selectedFilter = 'All'; // Default selected filter

  void _handleFilterButtonPressed(String type) {
    setState(() {
      _selectedFilter = type;
    });
    widget.onFilterSelected(type);
  }

  @override
  Widget build(BuildContext context) {
    // Calculate button width based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (screenWidth * 0.65 - 145) / 4; // 65% of screen width divided among 4 buttons, minus padding

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildFilterButton('All', buttonWidth),
          SizedBox(width: 8),
          _buildFilterButton('food', buttonWidth),
          SizedBox(width: 8),
          _buildFilterButton('beverage', buttonWidth),
          SizedBox(width: 8),
          _buildFilterButton('breakfast', buttonWidth),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String type, double width) {
    bool isSelected = _selectedFilter == type;
    return Container(
      height: 50,
      width: width,
      child: MaterialButton(
        onPressed: () => _handleFilterButtonPressed(type),
        color: isSelected ? buttonselectedcolor : buttoncolor, // Change color based on selection
        textColor: Colors.white,
        height: 50,
        child: AutoSizeText(
          type,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          maxLines: 1,
          minFontSize: 10,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
