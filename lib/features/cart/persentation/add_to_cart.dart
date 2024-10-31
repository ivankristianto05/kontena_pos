import 'package:flutter/material.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/functions/invoice.dart';
import 'package:kontena_pos/core/functions/order_new.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/core/utils/number_ui.dart';
import 'package:kontena_pos/data/menu.dart';
import 'package:kontena_pos/widgets/custom_elevated_button.dart';
import 'package:kontena_pos/widgets/custom_text_form_field.dart';
// import 'package:kontena_pos/core/functions/cart.dart';

class AddToCart extends StatefulWidget {
  AddToCart({
    Key? key,
    this.dataMenu,
    this.idxMenu,
    this.order = false,
  }) : super(key: key);

  final dynamic dataMenu;
  final int? idxMenu;
  bool order;

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
  InvoiceCart invoiceCart = InvoiceCart();
  OrderCart orderCart = OrderCart();

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();
    initAddon();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        // item = AppState().item;
        // item = ListMenu;
        isLoading = false;

        // print(itemDisplay);
        // varianDisplay = getVarian();
        // prefDisplay = itemPreference;
        // addonDisplay = geAddon();
        // qtyAddonController = List.generate(
        //   addonDisplay.length,
        //   (_) => TextEditingController(text: '0'),
        // );
        if (widget.idxMenu == null) {
          qtyController.text = '1';
        }
      });
    });

    setReinitData();
  }

  @override
  void dispose() {
    // for (var controller in qtyAddonController) {
    //   controller.dispose();
    // }
    for (var add in addonDisplay) {
      for (var addItem in add['items']) {
        addItem['editor'].dispose();
      }
    }
    super.dispose();
  }

  initAddon() {
    // print('check data, ${widget.dataMenu}');
    List<dynamic> itemAddon = AppState().dataItemAddon.where((addon) {
      return addon['item_group'] == widget.dataMenu['item_group'];
    }).toList();
    setState(() {
      addonDisplay = itemAddon;
    });
    for (var addon in addonDisplay) {
      addon['items'] = addon['items'].map((item) {
        TextEditingController editor = TextEditingController(text: '0');
        return {
          ...item,
          'editor': editor,
        };
      }).toList();
    }
    // print('check addon, ${itemAddon}');
    // print('check addon, ${addonDisplay}');
  }

  // List<dynamic> getVarian() {
  //   List<dynamic> filteredVarians = MenuVarian.where(
  //       (varian) => varian['id_menu'] == widget.dataMenu['id_menu']).toList();
  //   return filteredVarians;
  // }

  // List<dynamic> geAddon() {
  //   List<dynamic> filteredAddon =
  //       ListMenu.where((addon) => addon['type'] == 'addon').toList();
  //   // print('test addon, ${filteredAddon}');
  //   return filteredAddon;
  // }

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
                            widget.dataMenu['item_name'],
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
                                        const SizedBox(height: 4.0),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 12.0, 0.0, 16.0),
                                          child: Builder(
                                            builder: (context) {
                                              // final variant =
                                              //     varianDisplay.toList();
                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (varianDisplay.isNotEmpty)
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
                                                                    setState(
                                                                        () {
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
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
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
                                                                            .primaryContainer,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: ((selectedVarian != null) && (selectedVarian['id_varian'] == varianDisplay[index]['id_varian']))
                                                                          ? theme
                                                                              .colorScheme
                                                                              .primary
                                                                          : theme
                                                                              .colorScheme
                                                                              .surface,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                      12.0,
                                                                      12.0,
                                                                      12.0,
                                                                      12.0,
                                                                    ),
                                                                    child:
                                                                        Column(
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
                                                                          style: ((selectedVarian != null) && (selectedVarian['id_varian'] == varianDisplay[index]['id_varian']))
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
                                                  if (varianDisplay.isEmpty)
                                                    Container(
                                                      width: double.infinity,
                                                      height: 30.0,
                                                      decoration: BoxDecoration(
                                                          color: theme
                                                              .colorScheme
                                                              .surface),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(8.0,
                                                                4.0, 8.0, 4.0),
                                                        child: Text(
                                                          'No Varian',
                                                          style: TextStyle(
                                                              color: theme
                                                                  .colorScheme
                                                                  .onPrimaryContainer),
                                                        ),
                                                      ),
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
                                                  if (prefDisplay.isNotEmpty)
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
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: (selectedPref.contains(currentPref) ==
                                                                            true)
                                                                        ? theme
                                                                            .colorScheme
                                                                            .primary
                                                                        : theme
                                                                            .colorScheme
                                                                            .primaryContainer,
                                                                    border:
                                                                        Border
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
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                      12.0,
                                                                      12.0,
                                                                      12.0,
                                                                      12.0,
                                                                    ),
                                                                    child:
                                                                        Column(
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
                                                                          style: (selectedPref.contains(currentPref) == true)
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
                                                  if (prefDisplay.isEmpty)
                                                    Container(
                                                      width: double.infinity,
                                                      height: 30.0,
                                                      decoration: BoxDecoration(
                                                          color: theme
                                                              .colorScheme
                                                              .surface),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(8.0,
                                                                4.0, 8.0, 4.0),
                                                        child: Text(
                                                          'No Preference',
                                                          style: TextStyle(
                                                              color: theme
                                                                  .colorScheme
                                                                  .onPrimaryContainer),
                                                        ),
                                                      ),
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
                                              context,
                                              addonDisplay,
                                            )),
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
                                              widget.dataMenu['item_name'],
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
                                                                  "${selAddon['qty']}x ",
                                                                ),
                                                                Text(
                                                                  selAddon[
                                                                      'item_name'],
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
                  if (widget.idxMenu == null)
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
                          buttonTextStyle: TextStyle(
                            color: theme.colorScheme.primaryContainer,
                          ),
                          buttonStyle: CustomButtonStyles.primary,
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
                  if (widget.idxMenu != null)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 8.0, 8.0, 8.0),
                              child: Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                child: CustomElevatedButton(
                                  text: "Update to Cart",
                                  buttonTextStyle: TextStyle(
                                    color: theme.colorScheme.primaryContainer,
                                  ),
                                  buttonStyle: CustomButtonStyles.primary,
                                  onPressed: () {
                                    updateCart(
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
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 8.0, 8.0, 8.0),
                              child: Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                child: CustomElevatedButton(
                                  text: "Add Item To Cart",
                                  buttonTextStyle: TextStyle(
                                    color: theme.colorScheme.primaryContainer,
                                  ),
                                  buttonStyle: CustomButtonStyles.primary,
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

  int checkIndexSameField(List<dynamic> data, String field, String value) {
    return data.indexWhere((item) => item[field] == value);
  }

  // widget addon
  void qtyChangeAddon(String type, int indexParent, int index) {
    int qty =
        int.parse(addonDisplay[indexParent]['items'][index]['editor'].text);
    qty = type == 'add' ? qty + 1 : qty - 1;
    qty = qty.clamp(
        0, 99); // Prevent negative quantities and set a reasonable upper limit
    setState(() {
      addonDisplay[indexParent]['items'][index]['editor'].text = qty.toString();
    });

    addonDisplay[indexParent]['items'][index]['qty'] = qty;
    checkSelectedAddon(indexParent, index, qty);
  }

  void checkSelectedAddon(int indexParent, int index, int qty) {
    if (checkSameField(selectedAddon, 'indexAddon', '$indexParent-$index') ==
        null) {
      dynamic tmp = addonDisplay[indexParent]['items'][index];
      tmp['qty'] = qty;
      tmp['indexAddon'] = '$indexParent-$index';
      selectedAddon.add(tmp);
    } else {
      int findIndex = checkIndexSameField(
          selectedAddon, 'indexAddon', '$indexParent-$index');
      setState(() {
        selectedAddon[findIndex]['qty'] = qty;
      });

      print('fin dienx, ${findIndex}');
      print('qty, $qty');

      if (qty == 0) {
        setState(() {
          selectedAddon.removeAt(findIndex);
        });
      }

      print('check selection, ${selectedAddon}');
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
                final currentAddonItem = currentAddon['items'];
                // TextEditingController controller =
                //     TextEditingController(text: currentAddon['item_name']);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentAddon['name'],
                      style: theme.textTheme.labelSmall,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 4.0,
                        top: 4.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          border: Border.all(
                            color: theme.colorScheme.surface,
                          ),
                        ),
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: currentAddonItem.length,
                              itemBuilder: (context, index2) {
                                final addonItem = currentAddonItem[index2];
                                return Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              addonItem['item_name'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                            Text(
                                              numberFormat(
                                                  'idr', addonItem['rate']),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    _buildQuantityControl(
                                        context, index, index2),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuantityControl(
      BuildContext context, int indexParent, int index) {
    // print('addon display, ${addonDisplay[indexParent]}');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildQuantityButton(
            context,
            Icons.remove,
            () => qtyChangeAddon('minus', indexParent, index),
          ),
          Container(
            width: 40,
            color: theme.colorScheme.surface,
            child: CustomTextFormField(
              controller: addonDisplay[indexParent]['items'][index]['editor'],
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
            () => qtyChangeAddon('add', indexParent, index),
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
          border: Border.all(
            width: 0.0,
            color: Colors.transparent,
          ),
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
            context,
            Icons.remove,
            () => qtyChange('minus'),
            36.0,
          ),
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
            context,
            Icons.add,
            () => qtyChange('add'),
            36.0,
          ),
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

    String id = item['name'];

    if (note != '') {
      var notes = note.toLowerCase();
      id += "-n${notes.hashCode}";
    }

    // invoice
    if (widget.order == false) {
      print('ivnoce');
      InvoiceCartItem newItem = InvoiceCartItem(
        id: id,
        name: item['name'],
        itemName: item['item_name'],
        notes: note,
        preference: {},
        price: item['standard_rate'].floor(),
        qty: qty,
        uom: item['stock_uom'],
        description: item['item_name'],
        // addon: addon,
        itemGroup: item['item_group'],
        docstatus: 0,
        addon: selectedAddon,
        totalAddon: (totalAddon()),
      );

      setState(() {
        invoiceCart.addItem(newItem, mode: InvoiceCartMode.add);
      });
    } else {
      print('order');
      OrderCartItem newItem = OrderCartItem(
        id: id,
        name: item['name'],
        itemName: item['item_name'],
        // variant: null,
        // variantId: null,
        uom: item['stock_uom'],
        description: item['item_name'],
        qty: qty,
        price: item['standard_rate'].floor(),
        // variantPrice: item['standard_rate'].floor(),
        // addonsPrice:
        // item['standard_rate'].floor(), // Masukkan harga total addons
        // addons: null,
        notes: note,
        preference: {},
        itemGroup: item['item_group'],
        status: false,
        docstatus: 0,
        addon: selectedAddon,
        totalAddon: (totalAddon()),
        // type: item['item_group'],
      );

      // final cart = Provider.of<Cart>(context, listen: false);
      orderCart.addItem(newItem, mode: OrderCartMode.add);
    }

    Navigator.pop(context);
    // Navigator.of(context).pushNamed(AppRoutes.invoiceScreen);
  }

  void updateCart(
    BuildContext context,
    dynamic item,
    dynamic varian,
    List<dynamic> addon,
    String note,
    int qty,
  ) {
    print('check item, ${item}');
    // print('check varian, $varian');
    // print('check addon, $addon');
    // print('check qty, $qty');

    String id = item['name'];

    if (note != '') {
      var notes = note.toLowerCase();
      id += "-n${notes.hashCode}";
    }

    // invoice
    if (widget.order == false) {
      print('ivnoce');
      InvoiceCartItem newItem = InvoiceCartItem(
        id: id,
        name: item['name'],
        itemName: item['item_name'],
        notes: note,
        preference: {},
        price: item['price'],
        qty: qty,
        uom: item['stock_uom'],
        description: item['item_name'],
        // addon: addon,
        itemGroup: item['item_group'],
        docstatus: item['docstatus'],
        addon: selectedAddon,
        totalAddon: totalAddon(),
      );

      setState(() {
        invoiceCart.addItem(newItem, mode: InvoiceCartMode.update);
      });
    } else {
      print('order');
      OrderCartItem itemNew = orderCart.getItemByIndex(widget.idxMenu!);
      print('id, ${itemNew.id}');
      OrderCartItem newItem = OrderCartItem(
        id: itemNew.id,
        name: itemNew.name,
        itemName: itemNew.itemName,
        itemGroup: itemNew.itemGroup,
        uom: itemNew.uom,
        description: itemNew.description,
        qty: qty,
        price: itemNew.price,
        notes: itemNew.notes,
        preference: itemNew.preference,
        status: false,
        docstatus: itemNew.docstatus,
        addon: selectedAddon,
        totalAddon: totalAddon(),

        // id: id,
        // name: item['name'],
        // itemName: item['item_name'],
        // // variant: null,
        // // variantId: null,
        // uom: item['uom'],
        // description: item['item_name'],
        // qty: qty,
        // price: item['price'],
        // // variantPrice: item['standard_rate'].floor(),
        // // addonsPrice:
        // // item['standard_rate'].floor(), // Masukkan harga total addons
        // // addons: null,
        // notes: note,
        // preference: {},
        // itemGroup: item['item_group'],
        // status: false,
        // type: item['item_group'],
      );

      // final cart = Provider.of<Cart>(context, listen: false);
      setState(() {
        orderCart.addItem(newItem, mode: OrderCartMode.update);
      });
    }

    Navigator.pop(context);
    // Navigator.of(context).pushNamed(AppRoutes.invoiceScreen);
  }

  setReinitData() {
    if (widget.idxMenu != null) {
      setState(() {
        notesController.text = widget.dataMenu['notes'];
        qtyController.text = widget.dataMenu['qty'].toString();
        qty = widget.dataMenu['qty'];
      });
    }
  }

  int totalAddon() {
    int tmp = 0;
    for (var itm in selectedAddon) {
      int iQty = itm['qty'].floor() ?? 0;
      int iRate = itm['rate'].floor() ?? 0;
      tmp += iQty * iRate;
    }
    return tmp;
  }
}
