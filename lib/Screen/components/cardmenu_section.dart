import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pos_kontena/data/menu.dart';

class cardmenu extends StatelessWidget {
  const cardmenu({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWideScreen = screenWidth > 800;

    return Expanded(
              child: Container(
                width: screenWidth*0.65, // Set the width to 65% of the screen width
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isWideScreen ? 4 : 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: ListMenu.length, // Use the length of ListMenu
                  itemBuilder: (context, index) {
                    final menu = ListMenu[index]; // Get the current menu item
                    return Card(
                      elevation: 2.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize
                            .min, // Allow the card to adjust its height
                        children: [
                          Container(
                            height: 73, // Fixed image height
                            width: double.infinity,
                            color:
                                Colors.grey[300], // Placeholder for the image
                            child: Center(
                              child: Icon(Icons.image,
                                  size: 50.0, color: Colors.grey[600]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(menu['type'].toString(),
                                    style: TextStyle(fontSize: 12)),
                                AutoSizeText(
                                  menu['nama_menu'].toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  minFontSize: 10,
                                ),
                                SizedBox(height: 4.0),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text('Rp ${menu['harga'].toString()}',
                                      style: TextStyle(fontSize: 14)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
}
}