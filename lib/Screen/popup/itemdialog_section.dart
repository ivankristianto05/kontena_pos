import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package
import 'package:kontena_pos/Screen/popup/addons_section.dart';
import 'package:kontena_pos/Screen/popup/noteandpreference_section.dart';
import 'package:kontena_pos/Screen/popup/sumary_section.dart';
import 'package:kontena_pos/Screen/popup/variant_section.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:kontena_pos/app_state.dart';
import '../../core/functions/cart.dart'; // Import AppState

class ItemDetailsDialog extends StatefulWidget {
  final String name;
  final int price;
  final String idMenu;
  final String type;

  ItemDetailsDialog({
    required this.name,
    required this.price,
    required this.idMenu,
    required this.type,
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
  int _variantPrice = 0;

  // Create a NumberFormat instance for Indonesian locale
  final NumberFormat currencyFormat = NumberFormat('#,###', 'id_ID');

  void _addItemToCart() {
  final cartItem = CartItem(
    id: widget.idMenu,
    name: widget.name,
    variant: _selectedVariant ?? '',
    qty: _quantity,
    price: widget.price,
    variantPrice: _variantPrice, // Masukkan harga varian jika ada
    addons: _selectedAddons.map((key, value) => MapEntry(key, {'selected': value})),
    notes: _notes,
    preference: {
      'preference': _selectedPreference,
      // Add other preferences if any
    },
    type: widget.type,
  );
  // Access AppState and Cart to add item to cart
  final appState = Provider.of<AppState>(context, listen: false);
  appState.addItemToCart(cartItem);

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
                      price: _variantPrice != 0
                          ? _variantPrice
                          : widget.price, // Send price as int
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
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF00ADB5)),
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
