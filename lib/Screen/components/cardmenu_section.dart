import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kontena_pos/data/menu.dart';

class CardMenu extends StatelessWidget {
  const CardMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWideScreen = screenWidth > 800;

    int crossAxisCount = isWideScreen ? 4 : 2;

    return Container(
      width: screenWidth * 0.65,
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: ListMenu.length,
        itemBuilder: (context, index) {
          final menu = ListMenu[index];
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
                      child: Icon(Icons.image,
                          size: 50.0, color: Colors.grey[600]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(menu['type'].toString(),
                          style: TextStyle(fontSize: 12, color: Colors.black)),
                      AutoSizeText(
                        menu['nama_menu'].toString(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 10,
                      ),
                      SizedBox(height: 4.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text('Rp ${menu['harga'].toString()}',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
