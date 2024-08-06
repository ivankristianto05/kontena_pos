import 'package:flutter/material.dart';
import 'package:pos_kontena/Screen/popup/addons_section.dart';
import 'package:pos_kontena/Screen/popup/noteandpreference_section.dart';
import 'package:pos_kontena/Screen/popup/sumary_section.dart';
import 'package:pos_kontena/Screen/popup/variant_section.dart';
import 'package:pos_kontena/models/cart_item.dart';

class ItemDetailsDialog extends StatefulWidget {
  final String name;
  final String price;
  final String idMenu;
  final String type;
  final void Function(CartItem item) onAddToCart;

  ItemDetailsDialog({
    required this.name,
    required this.price,
    required this.idMenu,
    required this.type,
    required this.onAddToCart,
  });

  @override
  _ItemDetailsDialogState createState() => _ItemDetailsDialogState();
}

class _ItemDetailsDialogState extends State<ItemDetailsDialog> {
  int _selectedVariantIndex = -1;
  int _selectedPreferenceIndex = -1;
  String _selectedPreference = '';
  Map<String, bool> _selectedAddons = {};
  String _notes = '';
  String? _selectedVariant;
  int _quantity = 1;

  void _addItemToCart() {
    final cartItem = CartItem(
      idMenu: widget.idMenu,
      name: widget.name,
      variant: _selectedVariant ?? '',
      quantity: _quantity,
      price: double.tryParse(widget.price) ?? 0.0,
      addons: _selectedAddons,
      notes: _notes,
      preference: _selectedPreference,
    );
    widget.onAddToCart(cartItem);
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
                    widget.name,
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
                      idMenu: widget.idMenu,
                      selectedIndex: _selectedVariantIndex,
                      onVariantSelected: (index, variant) {
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
                      type: widget.type,
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
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: AddonSection(
                      type: widget.type,
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
                      name: widget.name,
                      price: widget.price,
                      type: widget.type,
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
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF00ADB5)),
                  ),
                  onPressed: _addItemToCart,
                  child: Text(
                    'Add to Cart',
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
