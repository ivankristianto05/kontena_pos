import 'package:flutter/material.dart';
import 'package:pos_kontena/constants.dart';

class NotesAndPreferenceSection extends StatelessWidget {
  final String type;
  final int selectedPreferenceIndex;
  final Function(int, String) onPreferenceSelected;
  final Function(String) onNotesChanged;

  NotesAndPreferenceSection({
    required this.type,
    required this.selectedPreferenceIndex,
    required this.onPreferenceSelected,
    required this.onNotesChanged,
  });

  @override
  Widget build(BuildContext context) {
    List<String> preferences = [];
    if (type == 'food') {
      preferences = [
        'original',
        'hot',
        'very hot',
        'no sauce',
        'no MSG',
        'no salt'
      ];
    } else if (type == 'beverage') {
      preferences = ['less sugar', 'less ice'];
    } else if (type == 'breakfast') {
      preferences = ['small', 'medium', 'jumbo'];
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Notes:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          TextField(
            onChanged: (value) {
              onNotesChanged(value);
            },
            decoration: InputDecoration(
              hintText: 'Input Here',
            ),
          ),
          SizedBox(height: 8.0),
          Text('Preference:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(preferences.length, (index) {
                  final preference = preferences[index];
                  final isSelected = selectedPreferenceIndex == index;
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          onPreferenceSelected(index, preference);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? buttonselectedcolor : Colors.white,
                            border: Border.all(
                                color: isSelected ? buttonselectedcolor : Colors.grey),
                          ),
                          child: ListTile(
                            title: Text(
                              preference,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected ? Colors.white : Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0), // Add spacing between ListTiles
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
