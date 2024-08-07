import 'package:flutter/material.dart';
import 'package:kontena_pos/Screen/popup/addons_section.dart';
import 'package:kontena_pos/Screen/popup/noteandpreference_section.dart';
import 'package:kontena_pos/Screen/popup/sumary_section.dart';
import 'package:kontena_pos/Screen/popup/variant_section.dart';
import 'package:kontena_pos/models/cart_item.dart';

class ItemEditDialog extends StatefulWidget {
  final CartItem item;
  final void Function(CartItem editedItem) onEdit;

  ItemEditDialog({
    required this.item,
    required this.onEdit,
  });

  @override
  _ItemEditDialogState createState() => _ItemEditDialogState();
}

class _ItemEditDialogState extends State<ItemEditDialog> {
  int _selectedVariantIndex = -1;
  int _selectedPreferenceIndex = -1;
  String _selectedPreference = '';
  Map<String, bool> _selectedAddons = {};
  String _notes = '';
  String? _selectedVariant;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _initializeFields();
    // Print type when dialog is initialized
    print('Dialog Initialized with type: ${widget.item.idMenu}');
  }

  void _initializeFields() {
    setState(() {
      _selectedVariant = widget.item.variant;
      _quantity = widget.item.quantity;
      _notes = widget.item.notes;
      _selectedPreference = widget.item.preference;
      _selectedAddons = widget.item.addons;

      // Debugging
      print('Initializing fields with type: ${widget.item.idMenu}');

      // Set selected indices based on the existing data
      _selectedVariantIndex = _getVariantIndex(_selectedVariant);
      _selectedPreferenceIndex = _getPreferenceIndex(_selectedPreference);
    });
  }

  int _getVariantIndex(String? variant) {
    // Implement logic to get index of the selected variant
    List<String> variants = _getVariantsBasedOnType();
    return variants.indexOf(variant ?? '');
  }

  int _getPreferenceIndex(String preference) {
    // Implement logic to get index of the selected preference
    List<String> preferences = _getPreferencesBasedOnType();
    return preferences.indexOf(preference);
  }

  List<String> _getVariantsBasedOnType() {
    if (widget.item.idMenu == 'food') {
      return ['Variant 1', 'Variant 2', 'Variant 3']; // Replace with actual variants
    } else if (widget.item.idMenu == 'beverage') {
      return ['Variant A', 'Variant B', 'Variant C']; // Replace with actual variants
    } else if (widget.item.idMenu == 'breakfast') {
      return ['Small', 'Medium', 'Large']; // Replace with actual variants
    }
    return [];
  }

  List<String> _getPreferencesBasedOnType() {
    if (widget.item.idMenu == 'food') {
      return ['original', 'hot', 'very hot', 'no sauce', 'no MSG', 'no salt'];
    } else if (widget.item.idMenu == 'beverage') {
      return ['less sugar', 'less ice'];
    } else if (widget.item.idMenu == 'breakfast') {
      return ['small', 'medium', 'jumbo'];
    }
    return [];
  }

  void _editItem() {
    final editedItem = CartItem(
      idMenu: widget.item.idMenu,
      name: widget.item.name,
      variant: _selectedVariant ?? '',
      quantity: _quantity,
      price: widget.item.price,
      addons: _selectedAddons,
      notes: _notes,
      preference: _selectedPreference,
    );
    // Print type when editing
    print('Editing Item with type: ${widget.item.idMenu}');
    print('Edited Item: $editedItem'); // Debugging
    widget.onEdit(editedItem);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit ${widget.item.name}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: VariantSection(
                      idMenu: widget.item.idMenu,
                      selectedIndex: _selectedVariantIndex,
                      onVariantSelected: (index, variant) {
                        print('Variant Selected: $variant'); // Debugging
                        setState(() {
                          _selectedVariantIndex = index;
                          _selectedVariant = variant;
                        });
                      },
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: NotesAndPreferenceSection(
                      type: widget.item.idMenu,
                      selectedPreferenceIndex: _selectedPreferenceIndex,
                      onPreferenceSelected: (index, preference) {
                        print('Preference Selected: $preference'); // Debugging
                        setState(() {
                          _selectedPreferenceIndex = index;
                          _selectedPreference = preference;
                        });
                      },
                      onNotesChanged: (notes) {
                        print('Notes Changed: $notes'); // Debugging
                        setState(() {
                          _notes = notes;
                        });
                      },
                      initialNotes: widget.item.notes,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: AddonSection(
                      type: widget.item.idMenu,
                      selectedAddons: _selectedAddons,
                      onAddonChanged: (addons) {
                        print('Addons Changed: $addons'); // Debugging
                        setState(() {
                          _selectedAddons = addons;
                        });
                      },
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: SummarySection(
                      name: widget.item.name,
                      price: widget.item.price.toString(),
                      type: widget.item.idMenu,
                      selectedVariant: _selectedVariant,
                      selectedPreferenceIndex: _selectedPreferenceIndex,
                      selectedAddons: _selectedAddons,
                      notes: _notes,
                      quantity: _quantity,
                      onQuantityChanged: (quantity) {
                        print('Quantity Changed: $quantity'); // Debugging
                        setState(() {
                          _quantity = quantity;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              height: 50,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF00ADB5)),
                  ),
                  onPressed: _editItem,
                  child: Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
