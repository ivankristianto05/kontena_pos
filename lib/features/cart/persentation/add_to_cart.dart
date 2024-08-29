import 'package:flutter/material.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/core/utils/number_ui.dart';
import 'package:kontena_pos/data/menu.dart';
import 'package:kontena_pos/data/menuvarian.dart';
import 'package:kontena_pos/widgets/custom_elevated_button.dart';
import 'package:kontena_pos/widgets/custom_text_form_field.dart';
import 'package:kontena_pos/core/functions/cart.dart';

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
  bool isLoading = true;
  List<dynamic> varianDisplay = [];
  List<dynamic> prefDisplay = [];
  List<dynamic> addonDisplay = [];
  dynamic selectedVarian;
  List<dynamic> selectedPref = [];
  String notes = '';
  List<dynamic> selectedAddon = [];
  int qty = 0;
  late List<TextEditingController> qtyAddonController;
  Cart cart = Cart();

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        // item = AppState().item;
        // item = ListMenu;
        isLoading = false;

        // print(itemDisplay);
        varianDisplay = getVarian();
        prefDisplay = itemPreference;
        addonDisplay = geAddon();
        qtyAddonController = List.generate(
          addonDisplay.length,
          (_) => TextEditingController(text: '0'),
        );
        qtyController.text = '1';
      });
    });
  }

  @override
  void dispose() {
    for (var controller in qtyAddonController) {
      controller.dispose();
    }
    super.dispose();
  }

  List<dynamic> getVarian() {
    List<dynamic> filteredVarians = MenuVarian.where(
        (varian) => varian['id_menu'] == widget.dataMenu['id_menu']).toList();
    return filteredVarians;
  }

  List<dynamic> geAddon() {
    List<dynamic> filteredAddon =
        ListMenu.where((addon) => addon['type'] == 'addon').toList();
    // print('test addon, ${filteredAddon}');
    return filteredAddon;
  }

  @override
  Widget build(BuildContext context) {
    // print('varian display, $varianDisplay');
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
                            widget.dataMenu['nama_menu'],
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
                          child: SizedBox(
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
                                            16.0, 24.0, 16.0, 0.0),
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
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 8.0, 0.0, 16.0),
                                          child: Builder(
                                            builder: (context) {
                                              // final variant =
                                              //     varianDisplay.toList();
                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ListView.builder(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        varianDisplay.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      if (isLoading) {
                                                      } else {
                                                        final currentVarian =
                                                            varianDisplay[
                                                                index];

                                                        return Column(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                if (selectedVarian ==
                                                                    null) {
                                                                  setState(() {
                                                                    selectedVarian =
                                                                        currentVarian;
                                                                  });
                                                                } else {
                                                                  if (selectedVarian[
                                                                          'id_varian'] ==
                                                                      currentVarian[
                                                                          'id_varian']) {
                                                                    setState(
                                                                        () {
                                                                      selectedVarian =
                                                                          null;
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      selectedVarian =
                                                                          currentVarian;
                                                                    });
                                                                  }
                                                                }
                                                              },
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: ((selectedVarian != null) &&
                                                                          (selectedVarian['id_varian'] ==
                                                                              varianDisplay[index][
                                                                                  'id_varian']))
                                                                      ? theme
                                                                          .colorScheme
                                                                          .primary
                                                                      : theme
                                                                          .colorScheme
                                                                          .primaryContainer,
                                                                  border: Border
                                                                      .all(
                                                                    color: ((selectedVarian !=
                                                                                null) &&
                                                                            (selectedVarian['id_varian'] ==
                                                                                varianDisplay[index][
                                                                                    'id_varian']))
                                                                        ? theme
                                                                            .colorScheme
                                                                            .primary
                                                                        : theme
                                                                            .colorScheme
                                                                            .surface,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                    12.0,
                                                                    12.0,
                                                                    12.0,
                                                                    12.0,
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        currentVarian[
                                                                            'nama_varian'],
                                                                        style: ((selectedVarian != null) &&
                                                                                (selectedVarian['id_varian'] == varianDisplay[index]['id_varian']))
                                                                            ? TextStyle(color: theme.colorScheme.background)
                                                                            : theme.textTheme.labelMedium,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            )
                                                          ],
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
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
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 24.0, 16.0, 0.0),
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
                                            16.0, 8.0, 16.0, 16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 0.0, 8.0),
                                          child: Text(
                                            'Preference:',
                                            style: theme.textTheme.labelMedium,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 8.0, 0.0, 8.0),
                                          child: Builder(
                                            builder: (context) {
                                              String prefGroup = '';
                                              int idxPref = 0;
                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ListView.builder(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        prefDisplay.length,
                                                    itemBuilder:
                                                        (context, prefIndex) {
                                                      if (isLoading) {
                                                      } else {
                                                        final currentPref =
                                                            prefDisplay[
                                                                prefIndex];

                                                        if (prefGroup !=
                                                            currentPref[
                                                                'type']) {
                                                          prefGroup =
                                                              currentPref[
                                                                  'type'];
                                                          idxPref = 0;
                                                        } else {
                                                          idxPref++;
                                                        }

                                                        return Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            if (idxPref == 0)
                                                              Text(
                                                                prefGroup,
                                                                style: theme
                                                                    .textTheme
                                                                    .labelSmall,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                            InkWell(
                                                              onTap: () {
                                                                selctedPref(
                                                                  context,
                                                                  prefIndex,
                                                                  currentPref,
                                                                );
                                                              },
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: (selectedPref.contains(
                                                                              currentPref) ==
                                                                          true)
                                                                      ? theme
                                                                          .colorScheme
                                                                          .primary
                                                                      : theme
                                                                          .colorScheme
                                                                          .primaryContainer,
                                                                  border: Border
                                                                      .all(
                                                                    color: (selectedPref.contains(currentPref) ==
                                                                            true)
                                                                        ? theme
                                                                            .colorScheme
                                                                            .primary
                                                                        : theme
                                                                            .colorScheme
                                                                            .surface,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                    12.0,
                                                                    12.0,
                                                                    12.0,
                                                                    12.0,
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        currentPref[
                                                                            'name'],
                                                                        style: (selectedPref.contains(currentPref) ==
                                                                                true)
                                                                            ? TextStyle(color: theme.colorScheme.background)
                                                                            : theme.textTheme.labelMedium,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            )
                                                          ],
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
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
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 24.0, 16.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Addon:',
                                            style: theme.textTheme.labelMedium),
                                        const SizedBox(height: 4.0),
                                        Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 8.0, 0.0, 16.0),
                                            child: _buildAddonSection(
                                                context, addonDisplay,)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 100.0,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                color: theme.colorScheme.background),
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
                                              widget.dataMenu['nama_menu'],
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            'Varian:',
                                            style: theme.textTheme.labelMedium,
                                          ),
                                          Text(
                                            (selectedVarian != null)
                                                ? selectedVarian['nama_varian']
                                                : '-',
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            'Preference:',
                                            style: theme.textTheme.labelMedium,
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 8.0, 0.0, 8.0),
                                            child: Builder(
                                              builder: (context) {
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ListView.builder(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          selectedPref.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final selPref =
                                                            selectedPref[index];

                                                        return Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "${selPref['name'].toString()}",
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            'Notes:',
                                            style: theme.textTheme.labelMedium,
                                          ),
                                          Text(
                                            notes,
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            'Addon:',
                                            style: theme.textTheme.labelMedium,
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 8.0, 0.0, 8.0),
                                            child: Builder(
                                              builder: (context) {
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ListView.builder(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          selectedAddon.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final selAddon =
                                                            selectedAddon[
                                                                index];
                                                        return Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "${selAddon['qty'].toString()}x ",
                                                                ),
                                                                Text(
                                                                  selAddon[
                                                                      'nama_menu'],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(
                                        height: 1.0,
                                        thickness: 1.0,
                                        color: theme.colorScheme.surface,
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 16.0, 0.0, 16.0),
                                        child: Text(
                                          'QTY',
                                          style: TextStyle(
                                            color: appTheme.gray500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            _buildQtySection(context),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 16.0, 16.0, 16.0),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      child: CustomElevatedButton(
                        text: "Add Item To Cart",
                        onPressed: () {
                          addToCart(
                            context,
                            widget.dataMenu,
                            selectedVarian,
                            selectedAddon,
                            notesController.text,
                            int.parse(qtyController.text),
                          );
                        },
                      ),
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        onEditingComplete: () {
          setState(() {
            notes = notesController.text;
          });
        },
        onTapOutside: (value) {
          // inputSearchVarian.unfocus();
          setState(() {
            notes = notesController.text;
          });
        },
      ),
    ]);
  }

  // widget preference
  void selctedPref(BuildContext context, int index, dynamic data) {
    dynamic tmp = data['type'];
    dynamic sameData = checkSameField(selectedPref, 'type', data['type']);
    if (selectedPref.contains(data) == false) {
      if (sameData != null) {
        setState(() {
          selectedPref.remove(sameData);
        });
      }
      setState(() {
        selectedPref.add(data);
      });
    } else {
      setState(() {
        selectedPref.remove(data);
      });
    }
  }

  dynamic checkSameField(List<dynamic> data, String field, String value) {
    dynamic tmp;
    for (var element in data) {
      if (element[field] == value) {
        tmp = element;
      }
    }
  
    return tmp;
  }

  // widget addon
  void qtyChangeAddon(String type, int index) {
    int qty = int.parse(qtyAddonController[index].text);
    qty = type == 'add' ? qty + 1 : qty - 1;
    qty = qty.clamp(
        0, 99); // Prevent negative quantities and set a reasonable upper limit
    setState(() {
      qtyAddonController[index].text = qty.toString();
    });

    addonDisplay[index]['qty'] = qty;
    checkSelectedAddon(index, qty);
  }

  void checkSelectedAddon(int index, int qty) {
    if (selectedAddon.elementAtOrNull(index) == null) {
      dynamic tmp = addonDisplay[index];
      tmp['qty'] = qty;
      selectedAddon.add(tmp);
    } else {
      setState(() {
        selectedAddon[index]['qty'] = qty;
      });
    }
  }

  Widget _buildAddonSection(BuildContext context, List<dynamic> addon) {
    return Builder(
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: addon.length,
              itemBuilder: (context, index) {
                final currentAddon = addon[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      border: Border.all(
                        color: theme.colorScheme.surface,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentAddon['nama_menu'],
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                Text(
                                  numberFormat('idr', currentAddon['harga']),
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        _buildQuantityControl(context, index),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuantityControl(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildQuantityButton(
            context,
            Icons.remove,
            () => qtyChangeAddon('minus', index),
          ),
          Container(
            width: 40,
            color: theme.colorScheme.surface,
            child: CustomTextFormField(
              controller: qtyAddonController[index],
              maxLines: 1,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 3.h,
                vertical: 13.v,
              ),
              borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: theme.colorScheme.surface,
                  width: 1,
                ),
              ),
              hintText: "Qty",
            ),
          ),
          _buildQuantityButton(
            context,
            Icons.add,
            () => qtyChangeAddon('add', index),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(
      BuildContext context, IconData icon, VoidCallback onTap,
      [double? size]) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size ?? 34,
        height: size ?? 34,
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryContainer,
          border: Border.all(width: 0.0, color: Colors.transparent,),
        ),
        child: Icon(
          icon,
          color: theme.colorScheme.primary,
          size: 14.0,
        ),
      ),
    );
  }

  // widget qty
  TextEditingController qtyController = TextEditingController();
  // qtyController.text = '1';
  void qtyChange(String type) {
    int qty = int.parse(qtyController.text);
    qty = type == 'add' ? qty + 1 : qty - 1;
    qty = qty.clamp(
        0, 99); // Prevent negative quantities and set a reasonable upper limit
    setState(() {
      qtyController.text = qty.toString();
    });
  }

  Widget _buildQtySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildQuantityButton(
              context, Icons.remove, () => qtyChange('minus'), 36.0,),
          // Expanded(
          Container(
            // height: 50.0,
            width: MediaQuery.sizeOf(context).width * 0.08,
            // constraints: BoxConstraints(minWidth: 40),
            color: theme.colorScheme.surface,
            child: CustomTextFormField(
              controller: qtyController,
              maxLines: 1,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 3.h,
                vertical: 13.v,
              ),
              borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: theme.colorScheme.surface,
                  width: 1,
                ),
              ),
              hintText: "Qty",
              textAlign: TextAlign.center,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          _buildQuantityButton(
              context, Icons.add, () => qtyChange('add'), 36.0,),
        ],
      ),
    );
  }

  void addToCart(
    BuildContext context,
    dynamic item,
    dynamic varian,
    List<dynamic> addon,
    String note,
    int qty,
  ) {
    // print('check item, $item');
    // print('check varian, $varian');
    // print('check addon, $addon');
    // print('check qty, $qty');

    String id = item['nama_menu'];

    if (note != '') {
      var notes = note.toLowerCase();
      id += "-n${notes.hashCode}";
    }

    CartItem newItem = CartItem(
      id: id,
      name: item['nama_menu'],
      itemName: item['nama_menu'],
      notes: note,
      preference: {},
      pref: selectedPref,
      price: varian['harga_varian'].toInt(),
      qty: qty,
      addon: addon,
    );

    setState(() {
      cart.addItem(newItem, mode: CartMode.add);
    });

    Navigator.pop(context);
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.invoiceScreen,
      (route) => false,
    );
  }
}
