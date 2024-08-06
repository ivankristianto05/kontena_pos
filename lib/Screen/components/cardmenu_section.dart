import 'package:flutter/material.dart';
import 'package:pos_kontena/Screen/popup/itemdialog_section.dart';
import 'package:pos_kontena/data/menu.dart';

class CardMenu extends StatelessWidget {
  final void Function(String name, String price, String idMenu, String type) onMenuTap;

  const CardMenu({Key? key, required this.onMenuTap}) : super(key: key);

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
          return GestureDetector(
            onTap: () {
              onMenuTap(
                menu['nama_menu'].toString(),
                menu['harga'].toString(),
                menu['id_menu'].toString(),
                menu['type'].toString(),
              );
            },
            child: Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 2.03,
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
                        Text(menu['type'].toString(), style: TextStyle(fontSize: 12, color: Colors.black)),
                        Text(
                          menu['nama_menu'].toString(),
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.0),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text('Rp ${menu['harga'].toString()}', style: TextStyle(fontSize: 14, color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
