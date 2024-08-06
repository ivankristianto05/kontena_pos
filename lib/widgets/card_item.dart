import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final Widget? image;
  final VoidCallback? onTap;
  final String name;
  final String category;
  final String description;
  final String price;

  CardItem({
    Key? key,
    this.image,
    this.onTap,
    this.name = 'Item Name',
    this.description = 'Item Deskripsi',
    this.category = 'None',
    this.price = 'Rp 10.000',
  }) : super(key: key);

  // Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWideScreen = screenWidth > 800;

    int crossAxisCount = isWideScreen ? 4 : 2;

    return Card(
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.85, // Adjust aspect ratio as needed
            child: Container(
              color: Colors.grey[300],
              child: Center(
                child: Icon(Icons.image, size: 50.0, color: Colors.grey[600]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                AutoSizeText(
                  name.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 10,
                ),
                SizedBox(height: 4.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    price,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
