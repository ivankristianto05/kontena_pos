import 'package:flutter/material.dart';

class ListCart extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final String title;
  final TextStyle titleStyle;
  final String addon;
  final String note;
  final TextStyle
      secondaryStyle; // Merged parameter for noteStyle and addonStyle
  final String editLabel;
  final TextStyle editLabelStyle;
  final String price;
  final TextStyle priceStyle;
  final EdgeInsets padding;
  final Color lineColor;
  final TextStyle labelStyle;
  final VoidCallback? onTap; // Added onTap parameter
  final String catatan;

  ListCart({
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.title = "1 X Hot Chocolate Large",
    this.titleStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    this.addon = "",
    this.note = "Less Ice, Less Sugar",
    this.secondaryStyle =
        const TextStyle(fontSize: 14, color: Colors.grey), // Merged parameter
    this.editLabel = "",
    this.editLabelStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
    this.price = "IDR 120.000",
    this.priceStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    this.padding = const EdgeInsets.all(8.0),
    this.lineColor = Colors.black, // Default line color is black
    this.labelStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.onTap,
    this.catatan = "",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Expanded(
                  flex: 2, // Title takes up 2/3 of the space
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: titleStyle),
                      SizedBox(height: 6),
                      if (addon.isNotEmpty) ...[
                        Text("Addon:", style: labelStyle),
                        SizedBox(height: 2),
                        Text(addon, style: secondaryStyle),
                      ],
                      if (note.isNotEmpty) ...[
                        Text("Preferensi:", style: labelStyle),
                        SizedBox(height: 2),
                        Text(note, style: secondaryStyle),
                        SizedBox(height: 16),
                      ],
                      if (catatan.isNotEmpty) ...[
                        Text("Catatan:", style: labelStyle),
                        SizedBox(height: 2),
                        Text(catatan, style: secondaryStyle),
                      ],
                      SizedBox(height: 4),
                      Text("Edit", style: editLabelStyle),
                    ],
                  ),
                ),
                SizedBox(width: 16), // Add spacing between title and price
                Container(
                  width: 120, // Fixed width for the price section
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(price, style: priceStyle),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1.0,
            color: lineColor,
            margin: const EdgeInsets.symmetric(
                horizontal: 16.0), // Adjust margin as needed
          ),
        ],
      ),
    );
  }
}
