import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/api/frappe_thunder_pos/company.dart'
    as frappeFetchDataCompany;
import 'package:kontena_pos/core/api/frappe_thunder_pos/pos_profile.dart'
    as frappeFetchDataPOSProfile;
import 'package:kontena_pos/data/organisation.dart';
import 'package:kontena_pos/widgets/custom_elevated_button.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/widgets/custom_text_form_field.dart';
import 'package:kontena_pos/core/app_export.dart';
import 'package:kontena_pos/core/animation/fade.dart';
import 'package:kontena_pos/core/utils/alert.dart' as alert;

class SelectOrganisationScreen extends StatefulWidget {
  const SelectOrganisationScreen({Key? key}) : super(key: key);

  @override
  _SelectOrganisationScreenState createState() =>
      _SelectOrganisationScreenState();
}

class _SelectOrganisationScreenState extends State<SelectOrganisationScreen> {
  // late LoginScreen _model;
  final unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String? Function(BuildContext, String?)? userFieldControllerValidator;
  List<dynamic> companyDisplay = [];
  List<dynamic> posProfileDisplay = [];
  bool isCompany = true;

  @override
  void initState() {
    super.initState();
    // setState(() {
    isCompany = true;
    callCompany();
    callPOSProfile();
    // companyDisplay = AppState().dataCompany;
    // posProfileDisplay = AppState().dataPOSProfile;
    // });
  }

  @override
  void dispose() {
    // _model.dispose();
    super.dispose();
    isCompany = true;
  }

  @override
  Widget build(BuildContext context) {
    // context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.colorScheme.primaryContainer,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 60.0, 0.0, 60.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              30.0, 30.0, 30.0, 80.0),
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 0.0, 40.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 250,
                                          height: 51,
                                          child: MaterialButton(
                                            onPressed: () {
                                              // Define the action for the MaterialButton
                                              onLogOut(context);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.person,
                                                      color: theme.colorScheme
                                                          .secondary,
                                                    ),
                                                    const SizedBox(
                                                        width:
                                                            8), // Space between text and icon
                                                    Text(
                                                      AppState()
                                                          .configUser['name'],
                                                      style: TextStyle(
                                                        color: theme.colorScheme
                                                            .secondary,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons.logout,
                                                  color: theme
                                                      .colorScheme.secondary,
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (isCompany)
                                    Text(
                                      'Select Organisation',
                                      style: theme.textTheme.titleLarge,
                                    ),
                                  if (!isCompany)
                                    Text(
                                      'Select POS',
                                      style: theme.textTheme.titleLarge,
                                    ),
                                  SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        if (isCompany)
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        8.0, 40.0, 8.0, 0.0),
                                                child: Align(
                                                  child: SizedBox(
                                                    width: MediaQuery.sizeOf(
                                                            context)
                                                        .width,
                                                    child: Column(
                                                      children: [
                                                        MasonryGridView.count(
                                                          crossAxisCount: 4,
                                                          mainAxisSpacing: 6,
                                                          crossAxisSpacing: 6,
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              companyDisplay
                                                                  .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final currentItem =
                                                                companyDisplay[
                                                                    index];
                                                            String filename =
                                                                currentItem[
                                                                        'name']
                                                                    .toString()
                                                                    .toLowerCase()
                                                                    .replaceAll(
                                                                        ' ',
                                                                        '_');
                                                            // final String img =
                                                            //     currentItem['img'];
                                                            return Card(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4), // if you need this
                                                                side:
                                                                    BorderSide(
                                                                  color: theme
                                                                      .colorScheme
                                                                      .outline,
                                                                  width: 1,
                                                                ),
                                                              ),
                                                              elevation: 0,
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap: () {
                                                                  onTapCompany(
                                                                      context,
                                                                      currentItem);
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                    24.0,
                                                                    24.0,
                                                                    24.0,
                                                                    24.0,
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        'assets/images/$filename.png',
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        width:
                                                                            130.0,
                                                                        height:
                                                                            130.0,
                                                                        errorBuilder: (BuildContext context,
                                                                            Object
                                                                                exception,
                                                                            StackTrace?
                                                                                stackTrace) {
                                                                          // Tampilkan gambar default jika file tidak ada
                                                                          return Image
                                                                              .asset(
                                                                            'assets/images/image_not_found.png',
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            width:
                                                                                130.0,
                                                                            height:
                                                                                130.0,
                                                                          );
                                                                        },
                                                                      ),
                                                                      Text(
                                                                        currentItem['name']
                                                                            .toString()
                                                                            .toUpperCase(),
                                                                        style:
                                                                            TextStyle(
                                                                          color: theme
                                                                              .colorScheme
                                                                              .secondary,
                                                                        ),
                                                                      ),
                                                                      // AutoSizeText(
                                                                      //   currentItem[
                                                                      //       'name'],
                                                                      //   style:
                                                                      //       TextStyle(
                                                                      //     color: theme
                                                                      //         .colorScheme
                                                                      //         .secondary,
                                                                      //   ),
                                                                      //   maxLines:
                                                                      //       1,
                                                                      //   overflow:
                                                                      //       TextOverflow.ellipsis,
                                                                      //   minFontSize:
                                                                      //       10,
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (!isCompany)
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        8.0, 40.0, 8.0, 0.0),
                                                child: Align(
                                                  child: SizedBox(
                                                    width: MediaQuery.sizeOf(
                                                            context)
                                                        .width,
                                                    child: Column(
                                                      children: [
                                                        MasonryGridView.count(
                                                          crossAxisCount: 4,
                                                          mainAxisSpacing: 6,
                                                          crossAxisSpacing: 6,
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              posProfileDisplay
                                                                  .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final currentItem =
                                                                posProfileDisplay[
                                                                    index];
                                                            String filename =
                                                                currentItem[
                                                                        'name']
                                                                    .toString()
                                                                    .toLowerCase()
                                                                    .replaceAll(
                                                                        ' ',
                                                                        '_');
                                                            // final String img =
                                                            //     currentItem['img'];
                                                            return Card(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4), // if you need this
                                                                side:
                                                                    BorderSide(
                                                                  color: theme
                                                                      .colorScheme
                                                                      .outline,
                                                                  width: 1,
                                                                ),
                                                              ),
                                                              elevation: 0,
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap: () {
                                                                  onTapPOSProfile(
                                                                      context,
                                                                      currentItem);
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                    24.0,
                                                                    24.0,
                                                                    24.0,
                                                                    24.0,
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .store_outlined,
                                                                        color: theme
                                                                            .colorScheme
                                                                            .secondary,
                                                                        size:
                                                                            68.0,
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              12.0),
                                                                      AutoSizeText(
                                                                        currentItem[
                                                                            'name'],
                                                                        style:
                                                                            TextStyle(
                                                                          color: theme
                                                                              .colorScheme
                                                                              .secondary,
                                                                        ),
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        minFontSize:
                                                                            10,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<dynamic> reformatPOSProfile(
    List<dynamic> posProfile,
    dynamic configCompany,
  ) {
    // print('check, ${[posProfile]}')
    return posProfile
        .where((posp) => posp['company'] == configCompany['name'])
        .toList();
  }

  void onTapCompany(BuildContext context, dynamic itemSelected) async {
    setState(() {
      AppState().configCompany = itemSelected;
      posProfileDisplay = reformatPOSProfile(
        AppState().dataPOSProfile,
        itemSelected,
      );
      isCompany = false;
    });
    // Navigator.of(context).pushNamedAndRemoveUntil(
    //   AppRoutes.invoiceScreen,
    //   (route) => false,
    // );
    // if (enterPhoneController.text != '' && enterPasswordController.text != '') {
    // } else {
    //   alert.alertError(context, 'Data Belum Lengkap!');
    // }
  }

  void onTapPOSProfile(BuildContext context, dynamic itemSelected) async {
    final frappeFetchDataPOSProfile.POSProfileRequest reqPosProfileDetail =
        frappeFetchDataPOSProfile.POSProfileRequest(
            cookie: AppState().setCookie, id: itemSelected['name']);
    try {
      final reqPosProfile = await frappeFetchDataPOSProfile.requestDetail(
          requestQuery: reqPosProfileDetail);

      if (reqPosProfile.isNotEmpty) {
        setState(() {
          AppState().configPOSProfile = reqPosProfile;
        });
      }

      print('check detail, $reqPosProfile');

      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.invoiceScreen,
          (route) => false,
        );
      }
    } catch (error) {
      // isLoading = false;
      if (error is TimeoutException) {
        // Handle timeout error
        // _bottomScreenTimeout(context);
      } else {
        if (context.mounted) {
          alert.alertError(context, error.toString());
        }
      }
      return;
    }
  }

  void callCompany() async {
    final frappeFetchDataCompany.CompanyRequest requestCompany =
        frappeFetchDataCompany.CompanyRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: '[]',
      limit: 100,
    );

    try {
      // Add a timeout of 30 seconds to the profile request
      final callRequest = await frappeFetchDataCompany.requestCompany(
        requestQuery: requestCompany,
      );
      print('check, ${callRequest}');

      setState(() {
        AppState().dataCompany = callRequest;
        companyDisplay = callRequest;
      });
      // AppState().userDetail = profileResult;
    } catch (error) {
      // isLoading = false;
      if (error is TimeoutException) {
        // Handle timeout error
        // _bottomScreenTimeout(context);
      } else {
        print(error);
      }
      return;
    }
  }

  void callPOSProfile() async {
    final frappeFetchDataPOSProfile.POSProfileRequest requestCompany =
        frappeFetchDataPOSProfile.POSProfileRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: '[]',
      limit: 100,
    );

    try {
      // Add a timeout of 30 seconds to the profile request
      final callRequest = await frappeFetchDataPOSProfile.request(
        requestQuery: requestCompany,
      );

      setState(() {
        AppState().dataPOSProfile = callRequest;
        posProfileDisplay = callRequest;
      });
      // AppState().userDetail = profileResult;
    } catch (error) {
      // isLoading = false;
      if (error is TimeoutException) {
        // Handle timeout error
        // _bottomScreenTimeout(context);
      } else {
        print(error);
      }
      return;
    }
  }

  onLogOut(BuildContext context) async {
    // await myMe.removeStoredUser();
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.loginScreen,
      (route) => false,
    );
  }
}
