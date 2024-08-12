import 'package:flutter/material.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/widgets/custom_text_form_field.dart';

class AddToCart extends StatefulWidget {
  AddToCart({
    Key? key,
    this.dataMenu,
  }) : super(key: key);

  final dynamic dataMenu;

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: MediaQuery.sizeOf(context).height * 0.8,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: Text(
                            'Item Varian 1',
                            style: theme.textTheme.labelMedium,
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            Navigator.of(context).pop(false);
                            // context.pushNamed('HomePage');
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 16.0, 16.0, 16.0),
                                child: Icon(
                                  Icons.close_rounded,
                                  color: theme.colorScheme.onBackground,
                                  size: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    thickness: 1.0,
                    color: theme.colorScheme.surface,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            width: 100.0,
                            height: double.infinity,
                            // decoration: BoxDecoration(
                            //   color: theme.colorScheme,
                            // ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 24.0, 8.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Varian:',
                                            style: theme.textTheme.labelMedium),
                                        const SizedBox(height: 4.0),
                                        Container(
                                          decoration: const BoxDecoration(),
                                          child: _buildSearchVarianSection(
                                              context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 1.0,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 100.0,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 24.0, 8.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Note:',
                                          style: theme.textTheme.labelMedium,
                                        ),
                                        const SizedBox(height: 4.0),
                                        Container(
                                          decoration: const BoxDecoration(),
                                          child: _buildNotesSection(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 8.0, 0.0, 16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 8.0, 8.0),
                                          child: Text(
                                            'Preference:',
                                            style: theme.textTheme.labelMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 1.0,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 100.0,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 24.0, 16.0, 16.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Addon:',
                                      style: theme.textTheme.labelMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 100.0,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 24.0, 0.0, 4.0),
                                  child: Text(
                                    'Summary:',
                                    style: theme.textTheme.labelMedium,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 0.0, 0.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 16.0, 0.0),
                                            child: Text(
                                              'Item Menu 1',
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(
                                            'Varian:',
                                            style: theme.textTheme.labelMedium,
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(
                                            'Addon:',
                                            style: theme.textTheme.labelMedium,
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(
                                            'Preference:',
                                            style: theme.textTheme.labelMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // widget search varian
  TextEditingController searchVarianController = TextEditingController();
  FocusNode inputSearchVarian = FocusNode();
  Widget _buildSearchVarianSection(BuildContext context) {
    // searchVarianController.text = 'test';
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // const Padding(
      //   padding: EdgeInsets.only(left: 1),
      //   child: Text(
      //     "No Hp / Email",
      //     style: TextStyle(
      //       fontSize: 16,
      //     ),
      //   ),
      // ),
      // const SizedBox(height: 6),
      CustomTextFormField(
        controller: searchVarianController,
        focusNode: inputSearchVarian,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 3.h,
          vertical: 9.v,
        ),
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.h),
          borderSide: BorderSide(
            color: theme.colorScheme.background,
            width: 2,
          ),
        ),
        hintText: "Search Varian",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'No Varian';
          }
          return null;
        },
        onTapOutside: (value) {
          inputSearchVarian.unfocus();
        },
      ),
    ]);
  }

  // widget list varian
  // widget notes
  TextEditingController notesController = TextEditingController();
  Widget _buildNotesSection(BuildContext context) {
    // return TextField(
    //   controller: notesController,
    //   decoration: InputDecoration(
    //     hintText: "Input notes",
    //     hintStyle: TextStyle(color: appTheme.gray500, fontSize: 11),
    //     border: const OutlineInputBorder(),
    //   ),
    //   maxLines: 2,
    //   onChanged: (value) {
    //     setState(() {
    //       notesController.text = value;
    //     });
    //   },
    // );
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // const Padding(
      //   padding: EdgeInsets.only(left: 1),
      //   child: Text(
      //     "No Hp / Email",
      //     style: TextStyle(
      //       fontSize: 16,
      //     ),
      //   ),
      // ),
      // const SizedBox(height: 6),
      CustomTextFormField(
        controller: notesController,
        // focusNode: inputSearchVarian,
        maxLines: 2,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 3.h,
          vertical: 9.v,
        ),
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.h),
          borderSide: BorderSide(
            color: theme.colorScheme.background,
            width: 2,
          ),
        ),
        hintText: "Input notes",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'No Varian';
          }
          return null;
        },
        onTapOutside: (value) {
          // inputSearchVarian.unfocus();
        },
      ),
    ]);
  }
  // widget preference
  // widget addon
}
