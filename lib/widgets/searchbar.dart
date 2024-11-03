import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';

class Searchbar extends StatefulWidget {
  void Function(String)? onChanged;
  Function(String)? onCompleted;

  Searchbar({
    super.key,
    this.onChanged,
    this.onCompleted,
  });

  @override
  _SearchbarState createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  // final double screenWidth;
  TextEditingController enterSearch = TextEditingController();
  // late TextEditingController enterSearch;

  @override
  void initState() {
    super.initState();
    // enterSearch = TextEditingController();
    // enterSearch.text = 'test';
  }

  @override
  void dispose() {
    enterSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.0,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        border: Border(
          right: BorderSide(
            color: theme.colorScheme.surface,
            width: 1.0,
          ),
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Menu',
          hintStyle: TextStyle(
            color: theme.colorScheme.onPrimaryContainer,
            fontSize: 14.0,
          ),
          // filled: true,
          // fillColor: Colors.white,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12.0),
          // isDense: true,
          suffixIcon: enterSearch.text.isNotEmpty
              ? InkWell(
                  onTap: () async {
                    enterSearch.clear();
                    setState(() {
                      enterSearch.text = '';
                    });
                  },
                  child: Icon(
                    Icons.clear,
                    color: theme.colorScheme.outline,
                    size: 24.0,
                  ),
                )
              : null,
        ),
        onChanged: (value) {
          EasyDebounce.debounce(
            '_model.enterSearch',
            Duration(milliseconds: 300),
            () {
              setState((){
                enterSearch.text = value;
              });
              widget.onChanged!(enterSearch.text);
            }
          );
        },
        onEditingComplete: onCompletedChange,
      ),
      // child: CustomTextFormField(
      //   controller: enterSearch,
      //   maxLines: 1,
      //   borderDecoration: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(0.h),
      //     borderSide: BorderSide(
      //       color: theme.colorScheme.surface,
      //       width: 0,
      //     ),
      //   ),
      //   hintText: "Enter a search",
      //   textStyle: const TextStyle(
      //     fontSize: 14.0,
      //   ),
      //   hintStyle: const TextStyle(
      //     fontSize: 14.0,
      //   ),
      //   onEditingComplete: () {
      //     // print('check value, $value');
      //     setState(() {
      //       // enterSearch.text = value;
      //     });
      //   },
      //   suffix: enterSearch.text != ''
      //       ? InkWell(
      //           onTap: () async {
      //             enterSearch.clear();
      //             // setState(() {
      //             //   FFAppState().searchProduk = '';
      //             // });
      //           },
      //           child: Icon(
      //             Icons.clear,
      //             color: theme.colorScheme.outline,
      //             size: 24.0,
      //           ),
      //         )
      //       : null,
      // ),
    );
  }

  onCompletedChange() {
    // onCompleted(enterSearch.text);
  }
}
