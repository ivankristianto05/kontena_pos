import 'package:flutter/material.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/widgets/custom_elevated_button.dart';
import 'package:kontena_pos/core/api/get_printer.dart' as callGetPrinter;

class SettingDevices extends StatefulWidget {
  SettingDevices({Key? key}) : super(key: key);

  @override
  _SettingDevicesState createState() => _SettingDevicesState();
}

class _SettingDevicesState extends State<SettingDevices> {
  bool canVoid = true;
  String selectedTipePrinter = 'USB';
  List<String> options = ['USB', 'Bluetooth'];
  List<dynamic> listPrinter = [];
  String selectedPrinter = '';
  // ApiCallResponse? testPrintResult;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    // if (AppState().configPrinter != '') {
    //   setState(() {
    //     selectedPrinter = AppState().configPrinter;
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    onGetPrinter(context);

    if (AppState().configPrinter != null) {
      setState(() {
        selectedPrinter = AppState().configPrinter['selectedPrinter'];
        selectedTipePrinter = AppState().configPrinter['tipeConnection'];
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  // decoration: BoxDecoration(
                  //   color: theme.colorScheme.primaryContainer,
                  // ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primaryContainer,
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     blurRadius: 5.0,
                                  //     color: Color(0x44111417),
                                  //     offset: Offset(0.0, 2.0),
                                  //   )
                                  // ],
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 12.0, 12.0, 12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 12.0),
                                              child: Text(
                                                'Pengaturan Devices',
                                                style: TextStyle(
                                                  color: theme
                                                      .colorScheme.secondary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              thickness: 2.0,
                                              color: theme.colorScheme.outline,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 6.0, 0.0, 12.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Tipe Koneksi Printer',
                                                          style: TextStyle(
                                                            color: theme
                                                                .colorScheme
                                                                .secondary,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      6.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 45.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: theme
                                                                  .colorScheme
                                                                  .primaryContainer,
                                                              border:
                                                                  Border.all(
                                                                color: theme
                                                                    .colorScheme
                                                                    .outline,
                                                                width: 2.0,
                                                              ),
                                                            ),
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    DropdownButton<
                                                                        String>(
                                                                  isExpanded:
                                                                      true,
                                                                  hint: Text(
                                                                      "Select an Option"),
                                                                  value:
                                                                      selectedTipePrinter,
                                                                  items:
                                                                      <String>[
                                                                    'USB',
                                                                    'Bluetooth',
                                                                  ].map((String
                                                                          value) {
                                                                    return DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          value,
                                                                      child:
                                                                          Text(
                                                                        value,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                  onChanged:
                                                                      (String?
                                                                          newValue) {
                                                                    setState(
                                                                        () {
                                                                      selectedTipePrinter =
                                                                          newValue!;
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        // Padding(
                                                        //   padding:
                                                        //       EdgeInsetsDirectional
                                                        //           .fromSTEB(
                                                        //               0.0,
                                                        //               6.0,
                                                        //               0.0,
                                                        //               0.0),
                                                        //   child: Text(
                                                        //     (false)
                                                        //         ? 'Data setting tersimpan'
                                                        //         : 'Data Setting belum tersimpan',
                                                        //     style: TextStyle(
                                                        //       color: theme
                                                        //           .colorScheme
                                                        //           .secondary,
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 6.0, 0.0, 12.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Daftar Printer',
                                                          style: TextStyle(
                                                            color: theme
                                                                .colorScheme
                                                                .secondary,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      6.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: 280.0,
                                                                height: 45.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: theme
                                                                      .colorScheme
                                                                      .primaryContainer,
                                                                  border: Border
                                                                      .all(
                                                                    color: theme
                                                                        .colorScheme
                                                                        .outline,
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                child:
                                                                    DropdownButtonHideUnderline(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: DropdownButton<
                                                                        String>(
                                                                      isExpanded:
                                                                          true,
                                                                      hint: Text(
                                                                          "Select an Option"),
                                                                      value: listPrinter.isNotEmpty &&
                                                                              listPrinter.any((printer) => printer['name'] == selectedPrinter)
                                                                          ? selectedPrinter
                                                                          : null,
                                                                      items: listPrinter.map<
                                                                          DropdownMenuItem<
                                                                              String>>((dynamic
                                                                          dt) {
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              dt['name'],
                                                                          child:
                                                                              Text(
                                                                            dt['name'],
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.normal),
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                      onChanged:
                                                                          (String?
                                                                              newValue) {
                                                                        setState(
                                                                            () {
                                                                          selectedPrinter =
                                                                              newValue!;
                                                                        });
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    CustomElevatedButton(
                                                                  text:
                                                                      "Get Printer",
                                                                  width: 120.0,
                                                                  height: 42.0,
                                                                  buttonTextStyle: TextStyle(
                                                                      color: theme
                                                                          .colorScheme
                                                                          .primaryContainer),
                                                                  buttonStyle:
                                                                      CustomButtonStyles
                                                                          .primaryButton,
                                                                  onPressed:
                                                                      () async {
                                                                    await onGetPrinter(
                                                                        context);
                                                                  },
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
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 24.0, 0.0, 6.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CustomElevatedButton(
                                                          text: "Save",
                                                          buttonTextStyle: TextStyle(
                                                              color: theme
                                                                  .colorScheme
                                                                  .primaryContainer),
                                                          buttonStyle:
                                                              CustomButtonStyles
                                                                  .primaryButton,
                                                          onPressed: () {
                                                            onTapSaveConfigPrinter(
                                                                context);
                                                          },
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
        ],
      ),
    );
  }

  onGetPrinter(BuildContext context) async {
    String url = 'getPrinter';
    String ipAddress = '127.0.0.1';
    final callGetPrinter.getPrinter dataPrinter =
        callGetPrinter.getPrinter(url: url, ipAddress: ipAddress);

    final resultPrinter =
        await callGetPrinter.requestGetPrinter(requestQuery: dataPrinter);

    if (resultPrinter.containsKey('printer')) {
      setState(() {
        AppState().listPrinter = resultPrinter['printer'];
        listPrinter = resultPrinter['printer'];
      });
    }
  }

  onTapSaveConfigPrinter(BuildContext context) async {
    setState(() {
      AppState().configPrinter = {
        'selectedPrinter': selectedPrinter,
        'tipeConnection': selectedTipePrinter,
      };
    });
    print('check data, ${AppState().configPrinter}');
  }
}
