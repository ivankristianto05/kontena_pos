import 'package:flutter/material.dart';
import 'package:kontena_pos/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:kontena_pos/core/app_export.dart';

class ButtonFilter extends StatefulWidget {
  final void Function(String type) onFilterSelected;

  const ButtonFilter({
    super.key,
    required this.onFilterSelected,
  });

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
    double buttonWidth = (screenWidth * 0.65 - 145) /
        4; // 65% of screen width divided among 4 buttons, minus padding

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildFilterButton('All', buttonWidth),
          const SizedBox(width: 8),
          _buildFilterButton('food', buttonWidth),
          const SizedBox(width: 8),
          _buildFilterButton('beverage', buttonWidth),
          const SizedBox(width: 8),
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
      decoration: BoxDecoration(
        border: Border.all(
          // right: BorderSide(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surface,
          width: 2.0,
          // ),
          // bottom: BorderSide(
          //   color: theme.colorScheme.surface,
          //   width: 1.0,
          // ),
        ),
      ),
      child: MaterialButton(
        onPressed: () => _handleFilterButtonPressed(type),
        color: isSelected
            ? theme.colorScheme.secondaryContainer
            : theme.colorScheme
                .primaryContainer, // Change color based on selection
        textColor: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.secondary,
        height: 50,
        child: AutoSizeText(
          type,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          maxLines: 1,
          minFontSize: 10,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
