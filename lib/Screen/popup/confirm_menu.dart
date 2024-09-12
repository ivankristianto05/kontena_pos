import 'package:flutter/material.dart';

class ConfirmInputMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final popupWidth = screenWidth * 0.9; // Width of the pop-up

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05, // Padding inset for popup width
        vertical: screenHeight * 0.05,  // Padding inset for popup height
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: popupWidth, // 90% of the screen width
        height: screenHeight * 0.9, // 90% of the screen height
        child: Column(
          children: [
            // AppBar with two buttons
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () {},
                    height: screenHeight * 0.1, // 20% of popup height (0.9 * 0.2)
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Text('Menu', style: TextStyle(color: Colors.white)),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {},
                    height: screenHeight * 0.1, // 20% of popup height (0.9 * 0.2)
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Text('Detail', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Menu',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),

            // Filter Buttons Centered with Equal Spacing
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Wrap(
                  spacing: popupWidth * 0.005, // Spacing between buttons
                  children: [
                    _buildFilterButton('All', isSelected: true),
                    _buildFilterButton('Food'),
                    _buildFilterButton('Beverage'),
                    _buildFilterButton('Breakfast'),
                    _buildFilterButton('Other'),
                  ],
                ),
              ),
            ),

            // Scrollable Menu Cards
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(12, (index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('Food'),
                              Text('Ayam Goreng Laos'),
                              Text('Rp 45.000'),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),

            // Buttons Batal dan Simpan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    height: screenHeight * 0.08, // Example height for smaller buttons
                    color: Colors.grey,
                    child: Text('Batal', style: TextStyle(color: Colors.white)),
                  ),
                  MaterialButton(
                    onPressed: () {
                      // Action on Save
                    },
                    height: screenHeight * 0.08, // Example height for smaller buttons
                    color: Colors.blue,
                    child: Text('Simpan', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label, {bool isSelected = false}) {
    return MaterialButton(
      onPressed: () {},
      color: isSelected ? Colors.blue : Colors.black,
      textColor: Colors.white,
      child: Text(label),
    );
  }
}
