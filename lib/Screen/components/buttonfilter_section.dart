import 'package:flutter/material.dart';
import 'package:kontena_pos/constants.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildFilterButton('All'),
          SizedBox(width: 8),
          _buildFilterButton('food'),
          SizedBox(width: 8),
          _buildFilterButton('beverage'),
          SizedBox(width: 8),
          _buildFilterButton('breakfast'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String type) {
    bool isSelected = _selectedFilter == type;
    return Container(
      height: 50,
      width: 130,
      child: MaterialButton(
        onPressed: () => _handleFilterButtonPressed(type),
        color: isSelected ? buttonselectedcolor : buttoncolor, // Change color based on selection
        textColor: Colors.white,
        height: 50,
        child: Text(
          type,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
