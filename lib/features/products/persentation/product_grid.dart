import 'package:flutter/material.dart';
import 'package:kontena_pos/widgets/card_item.dart';

class ProductGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final VoidCallback? onTap;
  const ProductGrid({
    Key? key,
    required this.items,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWideScreen = screenWidth > 800;

    int crossAxisCount = isWideScreen ? 5 : 2;
    return SizedBox(
      width: screenWidth * 0.7,
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final menu = items[index];
          return InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onTap,
            child: CardItem(
              name: menu['nama_menu'].toString(),
              price: menu['harga'].toString(),
              category: menu['type'].toString(),
            ),
          );
        },
      ),
    );
  }
}
