import 'package:flutter/material.dart';

class DropdownDeleteSection extends StatefulWidget {
  const DropdownDeleteSection({super.key});

  @override
  _DropdownDeleteSectionState createState() => _DropdownDeleteSectionState();
}

class _DropdownDeleteSectionState extends State<DropdownDeleteSection> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double smallButtonWidth = screenWidth * 0.05;
    double searchbarWidth = screenWidth * 0.65;

    return Container(
      width: screenWidth - searchbarWidth,
      height: 50,
      alignment: Alignment.topRight,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              height: 50,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text("Select an Option"),
                  value: selectedValue,
                  items: <String>[
                    'Option 1',
                    'Option 2',
                    'Option 3',
                    'Option 4'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  },
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            width: smallButtonWidth,
            height: 50,
            child: MaterialButton(
              minWidth: 0,
              height: 50,
              onPressed: () {
                // Handle the action for the delete button
              },
              child: Icon(Icons.delete, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
