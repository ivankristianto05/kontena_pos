import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/config_app.dart';
// import 'package:kontena_pos/core/plugins/bluetooth_print_model.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/widgets/custom_elevated_button.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
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

  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'no device connect';
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

    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));

    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      print('******************* cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'connect success';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'disconnect success';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
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
                SizedBox(
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
                                            if (selectedTipePrinter !=
                                                'Bluetooth')
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 6.0, 0.0, 12.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: theme
                                                                          .colorScheme
                                                                          .outline,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      DropdownButtonHideUnderline(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
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
                                                                              style: TextStyle(fontWeight: FontWeight.normal),
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
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      CustomElevatedButton(
                                                                    text:
                                                                        "Get Printer",
                                                                    width:
                                                                        120.0,
                                                                    height:
                                                                        42.0,
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
                                            if (selectedTipePrinter ==
                                                'Bluetooth')
                                              SingleChildScrollView(
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      10),
                                                          child: Text(tips),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(),
                                                    StreamBuilder<
                                                        List<BluetoothDevice>>(
                                                      stream: bluetoothPrint
                                                          .scanResults,
                                                      initialData: [],
                                                      builder: (c, snapshot) =>
                                                          Column(
                                                        children: snapshot.data!
                                                            .map(
                                                                (d) => ListTile(
                                                                      title: Text(
                                                                          d.name ??
                                                                              ''),
                                                                      subtitle: Text(
                                                                          d.address ??
                                                                              ''),
                                                                      onTap:
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          _device =
                                                                              d;
                                                                        });
                                                                      },
                                                                      trailing: _device != null &&
                                                                              _device!.address == d.address
                                                                          ? Icon(
                                                                              Icons.check,
                                                                              color: Colors.green,
                                                                            )
                                                                          : null,
                                                                    ))
                                                            .toList(),
                                                      ),
                                                    ),
                                                    Divider(),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20, 5, 20, 10),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              OutlinedButton(
                                                                child: Text(
                                                                    'connect'),
                                                                onPressed:
                                                                    _connected
                                                                        ? null
                                                                        : () async {
                                                                            if (_device != null &&
                                                                                _device!.address != null) {
                                                                              setState(() {
                                                                                tips = 'connecting...';
                                                                              });
                                                                              await bluetoothPrint.connect(_device!);
                                                                            } else {
                                                                              setState(() {
                                                                                tips = 'please select device';
                                                                              });
                                                                              print('please select device');
                                                                            }
                                                                          },
                                                              ),
                                                              SizedBox(
                                                                  width: 10.0),
                                                              OutlinedButton(
                                                                child: Text(
                                                                    'disconnect'),
                                                                onPressed:
                                                                    _connected
                                                                        ? () async {
                                                                            setState(() {
                                                                              tips = 'disconnecting...';
                                                                            });
                                                                            await bluetoothPrint.disconnect();
                                                                          }
                                                                        : null,
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(),
                                                          OutlinedButton(
                                                            child: Text(
                                                                'print receipt(esc)'),
                                                            onPressed:
                                                                _connected
                                                                    ? () async {
                                                                        Map<String,
                                                                                dynamic>
                                                                            config =
                                                                            Map();

                                                                        List<LineText>
                                                                            list =
                                                                            [];

                                                                        list.add(LineText(
                                                                            type: LineText
                                                                                .TYPE_TEXT,
                                                                            content:
                                                                                '**********************************************',
                                                                            weight:
                                                                                1,
                                                                            align:
                                                                                LineText.ALIGN_CENTER,
                                                                            linefeed: 1));
                                                                        list.add(LineText(
                                                                            type: LineText
                                                                                .TYPE_TEXT,
                                                                            content:
                                                                                '打印单据头',
                                                                            weight:
                                                                                1,
                                                                            align: LineText
                                                                                .ALIGN_CENTER,
                                                                            fontZoom:
                                                                                2,
                                                                            linefeed:
                                                                                1));
                                                                        list.add(LineText(
                                                                            linefeed:
                                                                                1));

                                                                        list.add(LineText(
                                                                            type: LineText
                                                                                .TYPE_TEXT,
                                                                            content:
                                                                                '----------------------明细---------------------',
                                                                            weight:
                                                                                1,
                                                                            align:
                                                                                LineText.ALIGN_CENTER,
                                                                            linefeed: 1));
                                                                        list.add(LineText(
                                                                            type: LineText
                                                                                .TYPE_TEXT,
                                                                            content:
                                                                                '物资名称规格型号',
                                                                            weight:
                                                                                1,
                                                                            align:
                                                                                LineText.ALIGN_LEFT,
                                                                            x: 0,
                                                                            relativeX: 0,
                                                                            linefeed: 0));
                                                                        list.add(LineText(
                                                                            type: LineText
                                                                                .TYPE_TEXT,
                                                                            content:
                                                                                '单位',
                                                                            weight:
                                                                                1,
                                                                            align:
                                                                                LineText.ALIGN_LEFT,
                                                                            x: 350,
                                                                            relativeX: 0,
                                                                            linefeed: 0));
                                                                        list.add(LineText(
                                                                            type: LineText
                                                                                .TYPE_TEXT,
                                                                            content:
                                                                                '数量',
                                                                            weight:
                                                                                1,
                                                                            align:
                                                                                LineText.ALIGN_LEFT,
                                                                            x: 500,
                                                                            relativeX: 0,
                                                                            linefeed: 1));

                                                                        list.add(LineText(
                                                                            type: LineText
                                                                                .TYPE_TEXT,
                                                                            content:
                                                                                '混凝土C30',
                                                                            align:
                                                                                LineText.ALIGN_LEFT,
                                                                            x: 0,
                                                                            relativeX: 0,
                                                                            linefeed: 0));
                                                                        list.add(LineText(
                                                                            type: LineText
                                                                                .TYPE_TEXT,
                                                                            content:
                                                                                '吨',
                                                                            align:
                                                                                LineText.ALIGN_LEFT,
                                                                            x: 350,
                                                                            relativeX: 0,
                                                                            linefeed: 0));
                                                                        list.add(LineText(
                                                                            type: LineText
                                                                                .TYPE_TEXT,
                                                                            content:
                                                                                '12.0',
                                                                            align:
                                                                                LineText.ALIGN_LEFT,
                                                                            x: 500,
                                                                            relativeX: 0,
                                                                            linefeed: 1));

                                                                        list.add(LineText(
                                                                            type: LineText
                                                                                .TYPE_TEXT,
                                                                            content:
                                                                                '**********************************************',
                                                                            weight:
                                                                                1,
                                                                            align:
                                                                                LineText.ALIGN_CENTER,
                                                                            linefeed: 1));
                                                                        list.add(LineText(
                                                                            linefeed:
                                                                                1));

                                                                        // ByteData
                                                                        //     data =
                                                                        //     await rootBundle.load("assets/images/bluetooth_print.png");
                                                                        // List<int>
                                                                        //     imageBytes =
                                                                        //     data.buffer.asUint8List(data.offsetInBytes,
                                                                        //         data.lengthInBytes);
                                                                        // String
                                                                        //     base64Image =
                                                                        //     base64Encode(imageBytes);
                                                                        // list.add(LineText(type: LineText.TYPE_IMAGE, content: base64Image, align: LineText.ALIGN_CENTER, linefeed: 1));

                                                                        await bluetoothPrint.printReceipt(
                                                                            config,
                                                                            list);
                                                                      }
                                                                    : null,
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
                                                          text: "Check",
                                                          buttonTextStyle: TextStyle(
                                                              color: theme
                                                                  .colorScheme
                                                                  .primaryContainer),
                                                          buttonStyle:
                                                              CustomButtonStyles
                                                                  .primaryButton,
                                                          onPressed: () {
                                                            bluetoothPrint.startScan(
                                                                timeout:
                                                                    Duration(
                                                                        seconds:
                                                                            4));
                                                          },
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
                                                          text: "Print",
                                                          buttonTextStyle: TextStyle(
                                                              color: theme
                                                                  .colorScheme
                                                                  .primaryContainer),
                                                          buttonStyle:
                                                              CustomButtonStyles
                                                                  .primaryButton,
                                                          onPressed: () {
                                                            bluetoothPrint.startScan(
                                                                timeout:
                                                                    Duration(
                                                                        seconds:
                                                                            4));
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
    dynamic configPrinter = ConfigApp().generateConfig(
      AppState().configPrinter,
    );
    ConfigApp().writeConfig(configPrinter);
    print('check data, ${AppState().configPrinter}');
  }
}
