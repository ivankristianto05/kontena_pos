import 'package:flutter/material.dart';
import 'package:kontena_pos/Screen/popup/addons_section.dart';
import 'package:kontena_pos/Screen/popup/noteandpreference_section.dart';
import 'package:kontena_pos/Screen/popup/sumary_section.dart';
import 'package:kontena_pos/Screen/popup/variant_section.dart';
import 'package:kontena_pos/data/menuvarian.dart';
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
  int _variantPrice = 0;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

 void _initializeFields() {
  setState(() {
    _selectedVariant = widget.item.variant;
    _quantity = widget.item.quantity;
    _notes = widget.item.notes;
    _selectedPreference = widget.item.preference;
    _selectedAddons = widget.item.addons;
    _variantPrice = widget.item.variantPrice;

    List<String> variants = MenuVarian
        .where((variant) => variant['id_menu'] == widget.item.idMenu)
        .map((variant) => variant['nama_varian'] as String)
        .toList();

    _selectedVariantIndex = variants.indexOf(_selectedVariant ?? '');
    _selectedPreferenceIndex = _getPreferenceIndex(_selectedPreference);
  });
}





 int _getVariantIndex(String? variant) {
  List<String> variants = _getVariantsBasedOnType();
 return variants.indexOf(variant ?? '');
}

  int _getPreferenceIndex(String preference) {
    List<String> preferences = _getPreferencesBasedOnType();
    return preferences.indexOf(preference);
  }

  List<String> _getVariantsBasedOnType() {
    if (widget.item.type == 'food') {
      return ['Variant 1', 'Variant 2', 'Variant 3'];
    } else if (widget.item.type == 'beverage') {
      return ['Variant A', 'Variant B', 'Variant C'];
    } else if (widget.item.type == 'breakfast') {
      return ['Small', 'Medium', 'Large'];
    }
    return [];
  }

  List<String> _getPreferencesBasedOnType() {
    if (widget.item.type == 'food') {
      return ['original', 'hot', 'very hot', 'no sauce', 'no MSG', 'no salt'];
    } else if (widget.item.type == 'beverage') {
      return ['less sugar', 'less ice'];
    } else if (widget.item.type == 'breakfast') {
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
      type: widget.item.type,
      variantPrice: _variantPrice,
    );
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
                      onVariantSelected: (index, variant, price) {
                        setState(() {
                          _selectedVariantIndex = index;
                          _selectedVariant = variant;
                          _variantPrice = price;
                        });
                      },
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: NotesAndPreferenceSection(
                      type: widget.item.type,
                      selectedPreferenceIndex: _selectedPreferenceIndex,
                      onPreferenceSelected: (index, preference) {
                        setState(() {
                          _selectedPreferenceIndex = index;
                          _selectedPreference = preference;
                        });
                      },
                      onNotesChanged: (notes) {
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
                      type: widget.item.type,
                      selectedAddons: _selectedAddons,
                      onAddonChanged: (addons) {
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
                      price: (_variantPrice != 0) ? _variantPrice : widget.item.price,
                      type: widget.item.type,
                      selectedVariant: _selectedVariant,
                      selectedPreferenceIndex: _selectedPreferenceIndex,
                      selectedAddons: _selectedAddons,
                      notes: _notes,
                      quantity: _quantity,
                      onQuantityChanged: (quantity) {
                        setState(() {
                          _quantity = quantity;
                        });
                      },
                      variantPrice: _variantPrice,
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
