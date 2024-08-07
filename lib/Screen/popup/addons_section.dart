import 'package:flutter/material.dart';

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
    List<String> addons = [];
    if (widget.type == 'food') {
      addons = ['Extra Cheese', 'Extra Sauce', 'Extra Spice'];
    } else if (widget.type == 'beverage') {
      addons = [
        'Coconut Jelly',
        'Whipped Cream',
        'Soy Milk',
        'Boba',
        'Chocolate',
        'Oreo'
      ];
    } else if (widget.type == 'breakfast') {
      addons = ['Extra Egg', 'Bacon', 'Sausage'];
    }

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
                children: List.generate(addons.length, (index) {
                  final addon = addons[index];
                  return Column(
                    children: [
                      CheckboxListTile(
                        title: Text(addon),
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
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
