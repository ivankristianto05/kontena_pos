import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/widgets/custom_text_form_field.dart';

class Searchbar extends StatefulWidget {
  final double screenWidth;
  final void Function(String) onSearchChanged;

  const Searchbar({
    Key? key,
    required this.screenWidth,
    required this.onSearchChanged,
  }) : super(key: key);

  @override
  _SearchbarState createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      widget.onSearchChanged(
          _searchController.text); // Notify parent on search change
      setState(() {}); // Update the UI when the text changes
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth, // Set the width using screenWidth parameter
      height: 50,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   border: Border(
      //     right: BorderSide(
      //       color: Colors.grey,
      //       width: 1.0,
      //     ),
      //   ),
      // ),
      child: Stack(
        children: [
          CustomTextFormField(
            controller: _searchController,
            // focusNode: inputSearchVarian,
            maxLines: 1,
            // contentPadding: EdgeInsets.symmetric(
            //   horizontal: 3.h,
            //   vertical: 9.v,
            // ),

            borderDecoration: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.h),
              borderSide: BorderSide(
                color: theme.colorScheme.surface,
                width: 0,
              ),
            ),
            hintText: "Input guest name",
            hintStyle: theme.textTheme.labelMedium,
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Visibility(
              visible: _searchController.text.isNotEmpty,
              child: IconButton(
                icon: FaIcon(FontAwesomeIcons.circleXmark),
                onPressed: () {
                  _searchController.clear();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
