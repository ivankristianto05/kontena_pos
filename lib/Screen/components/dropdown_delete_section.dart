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
    double smallButtonWidth = 60.0;
    double searchbarWidth = screenWidth * 0.7;

    return Container(
      width: screenWidth - searchbarWidth,
      height: 50,
      alignment: Alignment.topRight,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  top: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              height: 50,
              child: DropdownButtonHideUnderline(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text("Select an Option"),
                    value: selectedValue,
                    items: <String>[
                      'Dine in',
                      'Take away',
                      'Gojek',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
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
          ),
          Container(
            width: 60,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  top: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  )),
            ),
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
