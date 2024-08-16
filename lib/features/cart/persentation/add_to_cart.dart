import 'package:flutter/material.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/core/utils/number_ui.dart';
import 'package:kontena_pos/data/menu.dart';
import 'package:kontena_pos/data/menuvarian.dart';
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
  bool isLoading = true;
  List<dynamic> varianDisplay = [];
  List<dynamic> prefDisplay = [];
  List<dynamic> addonDisplay = [];
  dynamic selectedVarian;
  dynamic selectedPref;
  String notes = '';
  List<dynamic> selectedAddon = [];
  int qty = 0;

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
      });
    });
  }

  @override
  void dispose() {
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
                                                        final currentPref =
                                                            prefDisplay[index];

                                                        return Column(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                if (selectedPref ==
                                                                    null) {
                                                                  setState(() {
                                                                    selectedPref =
                                                                        currentPref;
                                                                  });
                                                                } else {
                                                                  if (selectedPref[
                                                                          'id'] ==
                                                                      currentPref[
                                                                          'id']) {
                                                                    setState(
                                                                        () {
                                                                      selectedPref =
                                                                          null;
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      selectedPref =
                                                                          currentPref;
                                                                    });
                                                                  }
                                                                }
                                                              },
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: ((selectedPref != null) &&
                                                                          (selectedPref['id'] ==
                                                                              currentPref[
                                                                                  'id']))
                                                                      ? theme
                                                                          .colorScheme
                                                                          .primary
                                                                      : theme
                                                                          .colorScheme
                                                                          .primaryContainer,
                                                                  border: Border
                                                                      .all(
                                                                    color: ((selectedPref !=
                                                                                null) &&
                                                                            (selectedPref['id'] ==
                                                                                currentPref[
                                                                                    'id']))
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
                                                                        style: ((selectedPref != null) &&
                                                                                (selectedPref['id'] == currentPref['id']))
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
                                                context, addonDisplay)),
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
                                          Text(
                                            (selectedPref != null)
                                                ? selectedPref['name']
                                                : '-',
                                            style: theme.textTheme.bodyMedium,
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
                                                            Text(
                                                              selAddon['qty']
                                                                  .toString(),
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
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                width: 54,
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      color: appTheme.gray200,
                                                      width: 4.0,
                                                    ),
                                                  ),
                                                  color: theme.colorScheme
                                                      .secondaryContainer,
                                                ),
                                                child: Icon(
                                                  Icons.remove,
                                                  color:
                                                      theme.colorScheme.primary,
                                                  size: 16.0,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                // height: 34,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: theme
                                                          .colorScheme.surface),
                                                  color:
                                                      theme.colorScheme.surface,
                                                ),
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(),
                                                  child:
                                                      _buildQtySection(context),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                width: 54,
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    left: BorderSide(
                                                      color: appTheme.gray200,
                                                      width: 4.0,
                                                    ),
                                                  ),
                                                  color: theme.colorScheme
                                                      .secondaryContainer,
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color:
                                                      theme.colorScheme.primary,
                                                  size: 16.0,
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
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            8.0, 8.0, 8.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tambahkan Produk',
                              style: TextStyle(
                                color: theme.colorScheme.primaryContainer,
                              ),
                            ),
                          ],
                        ),
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
  // widget addon
  Widget _buildAddonSection(BuildContext context, List<dynamic> addon) {
    List<TextEditingController> qtyAddonController = [];
    // selectedAddon = [];
    int idx = 0;
    addon.forEach((add) {
      qtyAddonController.add(TextEditingController());
      qtyAddonController[idx].text = '0';
      // add['qty'] = 0;
      // selectedAddon.add(add);
      idx++;
    });

    return Builder(
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: addonDisplay.length,
              itemBuilder: (context, index) {
                if (isLoading) {
                  return Column();
                } else {
                  final currentAddon = addonDisplay[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      border: Border.all(
                        color: theme.colorScheme.surface,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0,
                                  12.0,
                                  12.0,
                                  12.0,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentAddon['nama_menu'],
                                      style: theme.textTheme.labelMedium,
                                    ),
                                    Text(
                                      numberFormat(
                                          'idr', currentAddon['harga']),
                                      style: theme.textTheme.labelMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    qtyAddon(
                                      'minus',
                                      index,
                                      qtyAddonController,
                                      addon,
                                    );
                                  },
                                  child: Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: appTheme.gray200,
                                          width: 2.0,
                                        ),
                                      ),
                                      color:
                                          theme.colorScheme.secondaryContainer,
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      color: theme.colorScheme.primary,
                                      size: 14.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 34,
                                  decoration: BoxDecoration(
                                    // border:
                                    //     Border(
                                    //   top:
                                    //       BorderSide(
                                    //     color: theme.colorScheme.surface,
                                    //   ),
                                    //   bottom:
                                    //       BorderSide(
                                    //     color: theme.colorScheme.surface,
                                    //   ),
                                    // ),
                                    color: theme.colorScheme.surface,
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextFormField(
                                            controller:
                                                qtyAddonController[index],
                                            // focusNode: inputSearchVarian,
                                            maxLines: 1,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 3.h,
                                              vertical: 9.v,
                                            ),

                                            borderDecoration:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0.h),
                                              borderSide: BorderSide(
                                                color:
                                                    theme.colorScheme.surface,
                                                width: 0,
                                              ),
                                            ),
                                            hintText: "Qty",
                                          ),
                                        ]),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    qtyAddon(
                                      'add',
                                      index,
                                      qtyAddonController,
                                      addon,
                                    );
                                  },
                                  child: Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: appTheme.gray200,
                                          width: 2.0,
                                        ),
                                      ),
                                      color:
                                          theme.colorScheme.secondaryContainer,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: theme.colorScheme.primary,
                                      size: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void qtyAddon(
    String type,
    int idx,
    List<TextEditingController> qtyCont,
    List<dynamic> addon,
  ) {
    print('check ${qtyCont[idx].value}');
    print('check ${qtyCont[idx].text}');
    int qtyEditor = int.parse(qtyCont[idx].text);
    print('qty editor, ${qtyEditor}');
    if (type == 'add') {
      qtyEditor += 1;
    } else {
      if (qtyEditor == 0) {
        qtyEditor = 0;
      } else {
        qtyEditor -= 1;
      }
    }
    qty = qtyEditor;
    print('qty, $qty');
    print('index, $idx');
    // setState(() {
    qtyCont[idx].text = qty.toString();
    // });
    // selectedAddon[idx].qty = qty;
  }

  // widget qty
  TextEditingController qtyController = TextEditingController();
  // qtyController.text = qty;
  Widget _buildQtySection(BuildContext context) {
    qtyController.text = qty.toString();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomTextFormField(
        controller: qtyController,
        // focusNode: inputSearchVarian,
        maxLines: 1,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 3.h,
          vertical: 9.v,
        ),

        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.h),
          borderSide: BorderSide(
            color: theme.colorScheme.surface,
            width: 0,
          ),
        ),
        hintText: "Qty",
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
}
