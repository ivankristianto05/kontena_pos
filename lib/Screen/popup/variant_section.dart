import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pos_kontena/constants.dart';
import 'package:pos_kontena/data/menuvarian.dart';

class VariantSection extends StatelessWidget {
  final String idMenu;
  final int selectedIndex;
  final Function(int, String) onVariantSelected;

  VariantSection({
    required this.idMenu,
    required this.selectedIndex,
    required this.onVariantSelected,
  });

  @override
  Widget build(BuildContext context) {
    final variants = MenuVarian.where((variant) => variant['id_menu'] == idMenu).toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Variant:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search',
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(variants.length, (index) {
                  final variant = variants[index];
                  final isSelected = selectedIndex == index;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        onVariantSelected(index, variant['nama_varian']);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? buttonselectedcolor : Colors.white,
                          border: Border.all(
                              color: isSelected ? buttonselectedcolor : Colors.grey),
                        ),
                        child: ListTile(
                          title: AutoSizeText(
                            variant['nama_varian'],
                            style: TextStyle(
                                fontSize: 14,
                                color: isSelected ? Colors.white : Colors.black),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: AutoSizeText(
                            "Rp ${variant['harga']}",
                            style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? Colors.white : Colors.black),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
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