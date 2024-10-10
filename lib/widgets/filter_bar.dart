import 'package:flutter/material.dart';
import 'package:kontena_pos/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:kontena_pos/core/app_export.dart';
import 'package:kontena_pos/widgets/custom_elevated_button.dart';

class FilterBar extends StatefulWidget {
  final void Function(String type) onFilterSelected;

  const FilterBar({
    Key? key,
    required this.onFilterSelected,
  }) : super(key: key);

  @override
  _FilterBarState createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
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
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
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
    return SizedBox(
      height: 50,
      width: width,
      child: CustomElevatedButton(
        text: type,
        buttonTextStyle: isSelected
            ? TextStyle(color: theme.colorScheme.primaryContainer)
            : TextStyle(color: theme.colorScheme.secondary),
        buttonStyle: isSelected
            ? CustomButtonStyles.primary
            : CustomButtonStyles.outlineSecondary,
        onPressed: () => _handleFilterButtonPressed(type),
      ),
    );
  }
}
