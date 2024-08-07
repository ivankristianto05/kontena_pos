import 'package:flutter/material.dart';
import 'package:kontena_pos/constants.dart';
import 'package:kontena_pos/data/menuvarian.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ItemDetailsDialog extends StatefulWidget {
  final String name;
  final String price;
  final String idMenu;

  ItemDetailsDialog({
    required this.name,
    required this.price,
    required this.idMenu,
  });

  @override
  _ItemDetailsDialogState createState() => _ItemDetailsDialogState();
}

class _ItemDetailsDialogState extends State<ItemDetailsDialog> {
  int _selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    print(
        "Food Type: ${widget.name}"); // Print the food type when the dialog opens
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
            // Title bar with menu name and close icon
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
                  Expanded(
                    flex: 2,
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              right:
                                  BorderSide(color: Colors.grey, width: 0.3)),
                        ),
                        child: _buildVariantSection(widget.idMenu)),
                  ),
                  Expanded(
                    flex: 2,
                    child: _buildNotesAndPreferenceSection(),
                  ),
                  Expanded(
                    flex: 2,
                    child: _buildAddonSection(),
                  ),
                  Expanded(
                    flex: 2,
                    child: _buildSummarySection(widget.name, widget.price),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add to Cart action
                  },
                  child: Text('Add to Cart'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVariantSection(String idMenu) {
    final variants =
        MenuVarian.where((variant) => variant['id_menu'] == idMenu).toList();
    return Padding(
      padding: const EdgeInsets.all(2.0),
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
            child: ListView.builder(
              itemCount: variants.length,
              itemBuilder: (context, index) {
                final variant = variants[index];
                final isSelected = _selectedIndex == index;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? buttonselectedcolor : Colors.white,
                        border: Border.all(
                            color: isSelected
                                ? buttonselectedcolor
                                : Colors.black),
                      ),
                      child: ListTile(
                        title: AutoSizeText(
                          variant['nama_varian'],
                          style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? Colors.white : Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: AutoSizeText(
                          "Rp ${variant['harga']}",
                          style: TextStyle(
                              fontSize: 13,
                              color: isSelected ? Colors.white : Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesAndPreferenceSection() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Notes:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          TextField(
            decoration: InputDecoration(
              hintText: 'Input Here',
            ),
          ),
          SizedBox(height: 8.0),
          Text('Preference:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          // Add your preference options here
          Container(
            child: Column(
              children: [
                CustomListTile(
                  title: "Extra Ice",
                  onTap: () {
                    // Handle preference selection
                  },
                ),
                CustomListTile(
                  title: "Half Ice",
                  onTap: () {
                    // Handle preference selection
                  },
                ),
                CustomListTile(
                  title: "Normal Ice",
                  onTap: () {
                    // Handle preference selection
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddonSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Addon:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          // Add your addon options here
          Container(
            child: Column(
              children: [
                ListTile(
                  title: Text("Extra Espresso 1 Shot"),
                  subtitle: Text("Rp 5.000"),
                  trailing: Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      // Handle addon selection
                    },
                  ),
                ),
                ListTile(
                  title: Text("Extra Espresso 1 Shot"),
                  subtitle: Text("Rp 5.000"),
                  trailing: Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      // Handle addon selection
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(String name, String price) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Summary:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Name: $name'),
          Text('Price: Rp $price'),
          // Add more summary details here
          Spacer(),
          Text('Qty',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  // Decrease quantity
                },
              ),
              Text('1'), // This should be dynamic
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // Increase quantity
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomListTile({required this.title, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
                fontSize: 16,
                color: Colors.black), // Customize this style as needed
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
