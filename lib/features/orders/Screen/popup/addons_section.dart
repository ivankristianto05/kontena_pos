import 'package:flutter/material.dart';
import 'package:kontena_pos/data/addons_preference.dart';

class AddonSection extends StatefulWidget {
  final String type;
  final Map<String, bool> selectedAddons;
  final Function(Map<String, bool>) onAddonChanged;

  AddonSection({
    required this.type,
    required this.selectedAddons,
    required this.onAddonChanged,
  });

  @override
  _AddonSectionState createState() => _AddonSectionState();
}

class _AddonSectionState extends State<AddonSection> {
  late Map<String, bool> _selectedAddons;

  @override
  void initState() {
    super.initState();
    _selectedAddons = Map.from(widget.selectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    // Gunakan data dari addons_data.dart
    Map<String, double> addons = addonsByType[widget.type] ?? {};

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Addon:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: addons.entries.map((entry) {
                  final addon = entry.key;
                  final price = entry.value;
                  return Column(
                    children: [
                      CheckboxListTile(
                        title: Text('$addon - \$${price.toStringAsFixed(2)}'),
                        value: _selectedAddons[addon] ?? false,
                        onChanged: (bool? value) {
                          setState(() {
                            _selectedAddons[addon] = value ?? false;
                            widget.onAddonChanged(_selectedAddons);
                          });
                        },
                      ),
                      SizedBox(height: 8.0), // Add spacing between Checkboxes
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
