import 'dart:io';

// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/config_app.dart';
import 'package:kontena_pos/core/utils/print_bluetooth.dart';
// import 'package:kontena_pos/core/plugins/bluetooth_print_model.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/widgets/custom_elevated_button.dart';
// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:kontena_pos/core/api/get_printer.dart' as callGetPrinter;
// import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

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

  // BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  // List<BluetoothDevice> _devices = [];
  // BluetoothDevice? _device;
  bool _connected = false;

  // -----------
  // print bluetooth thermal plugin
  String _msg = '';
  String _info = '';
  List<BluetoothInfo> items = [];
  List<String> _options = ["permission bluetooth granted", "bluetooth enabled", "connection status", "update info"];
  bool _progress = false;
  String _msgprogress = "";
  BluetoothInfo? selected;

  String optionprinttype = "80 mm";
  List<String> optionsSize = ["58 mm", "80 mm"];


  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    // if (AppState().configPrinter != '') {
    //   setState(() {
    //     selectedPrinter = AppState().configPrinter;
    //   });
    // }
    // printerManager.scanResults.listen((devices) async {
    //   // print('UI: Devices found ${devices.length}');
    //   setState(() {
    //     _devices = devices;
    //   });
    // });
  }

  @override
  void initState() {
    super.initState();
    // onGetPrinter(context);
    // initPlatformState();
    platformState();

    if (AppState().configPrinter != null) {
      setState(() {
        selectedTipePrinter = AppState().configPrinter['tipeConnection'];
        selectedPrinter = AppState().configPrinter['selectedPrinter'];

        if (selectedTipePrinter == 'Bluetooth') {

        }
      });
    }

    // WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Future<void> initPlatformState() async {
  //   print('init platform state');
  //   bool? isConnected = await bluetooth.isConnected;
  //   List<BluetoothDevice> devices = [];
  //   try {
  //     devices = await bluetooth.getBondedDevices();
  //   } on PlatformException {}

  //   bluetooth.onStateChanged().listen((state) {
  //     switch (state) {
  //       case BlueThermalPrinter.CONNECTED:
  //         setState(() {
  //           _connected = true;
  //           print("bluetooth device state: connected");
  //         });
  //         break;
  //       case BlueThermalPrinter.DISCONNECTED:
  //         setState(() {
  //           _connected = false;
  //           print("bluetooth device state: disconnected");
  //         });
  //         break;
  //       case BlueThermalPrinter.DISCONNECT_REQUESTED:
  //         setState(() {
  //           _connected = false;
  //           print("bluetooth device state: disconnect requested");
  //         });
  //         break;
  //       case BlueThermalPrinter.STATE_TURNING_OFF:
  //         setState(() {
  //           _connected = false;
  //           print("bluetooth device state: bluetooth turning off");
  //         });
  //         break;
  //       case BlueThermalPrinter.STATE_OFF:
  //         setState(() {
  //           _connected = false;
  //           print("bluetooth device state: bluetooth off");
  //         });
  //         break;
  //       case BlueThermalPrinter.STATE_ON:
  //         setState(() {
  //           _connected = false;
  //           print("bluetooth device state: bluetooth on");
  //         });
  //         break;
  //       case BlueThermalPrinter.STATE_TURNING_ON:
  //         setState(() {
  //           _connected = false;
  //           print("bluetooth device state: bluetooth turning on");
  //         });
  //         break;
  //       case BlueThermalPrinter.ERROR:
  //         setState(() {
  //           _connected = false;
  //           print("bluetooth device state: error");
  //         });
  //         break;
  //       default:
  //         print(state);
  //         break;
  //     }
  //   });

  //   if (!mounted) return;
  //   setState(() {
  //     _devices = devices;
  //   });

  //   if (isConnected == true) {
  //     setState(() {
  //       _connected = true;
  //     });
  //   }
  // }

  // List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
  //   List<DropdownMenuItem<BluetoothDevice>> items = [];
  //   if (_devices.isEmpty) {
  //     items.add(DropdownMenuItem(
  //       child: Text('NONE'),
  //     ));
  //   } else {
  //     _devices.forEach((device) {
  //       items.add(DropdownMenuItem(
  //         child: Text(device.name ?? ""),
  //         value: device,
  //       ));
  //     });
  //   }
  //   return items;
  // }

  void _connect() {
  //   // print('connect');
  //   // print(_device);
  //   // print('---');
  //   if (_device != null) {
  //     // print(1);
  //     bluetooth.isConnected.then((isConnected) {
  //       // print(2);
  //       if (isConnected != true) {
  //         // print(3);
  //         bluetooth.connect(_device!).catchError((error) {
  //           setState(() => _connected = false);
  //           // print('false');
  //         });
  //         // print('true');
  //         setState(() => _connected = true);
  //       }
  //       print('check ${_connected}');
  //     });
  //   } else {
  //     show('No device selected.');
  //   }
  }

  // Future show(
  //   String message, {
  //   Duration duration = const Duration(seconds: 3),
  // }) async {
  //   await new Future.delayed(new Duration(milliseconds: 100));
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     new SnackBar(
  //       content: new Text(
  //         message,
  //         style: new TextStyle(
  //           color: Colors.white,
  //         ),
  //       ),
  //       duration: duration,
  //     ),
  //   );
  // }

  void _disconnect() {
  //   bluetooth.disconnect();
  //   setState(() => _connected = false);
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
                                                                // Container(
                                                                //   width: 280.0,
                                                                //   height: 45.0,
                                                                //   decoration:
                                                                //       BoxDecoration(
                                                                //     color: theme
                                                                //         .colorScheme
                                                                //         .primaryContainer,
                                                                //     border:
                                                                //         Border
                                                                //             .all(
                                                                //       color: theme
                                                                //           .colorScheme
                                                                //           .outline,
                                                                //       width:
                                                                //           2.0,
                                                                //     ),
                                                                //   ),
                                                                //   child:
                                                                //       DropdownButtonHideUnderline(
                                                                //     child:
                                                                //         Padding(
                                                                //       padding: const EdgeInsets
                                                                //           .all(
                                                                //           8.0),
                                                                //       child:
                                                                //           DropdownButton(
                                                                //         items:
                                                                //             _getDeviceItems(),
                                                                //         onChanged: (BluetoothDevice?
                                                                //                 value) =>
                                                                //             setState(() =>
                                                                //                 _device = value),
                                                                //         value:
                                                                //             _device,
                                                                //       ),
                                                                //     ),
                                                                //   ),
                                                                // ),
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
                                                                      print(
                                                                          'button');
                                                                      onGetPrinter(
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
                                                                      child:
                                                                          DropdownButton(
                                                                        items:
                                                                            items.map((dv) {
                                                                              return DropdownMenuItem<BluetoothInfo>(
                                                                                value: dv,
                                                                                child: Text('${dv.name} - ${dv.macAdress}'),
                                                                              );
                                                                            }).toList(),
                                                                        value: selected,
                                                                        onChanged: (BluetoothInfo? dvc) {
                                                                          // String mac = items[]
                                                                          setState((){
                                                                            selected = dvc;
                                                                            connect(dvc!.macAdress);
                                                                          });

                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if (_connected ==
                                                                    false)
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
                                                                          "Connect",
                                                                      width:
                                                                          120.0,
                                                                      height:
                                                                          42.0,
                                                                      buttonTextStyle: TextStyle(
                                                                          color: theme
                                                                              .colorScheme
                                                                              .primary),
                                                                      buttonStyle:
                                                                          CustomButtonStyles
                                                                              .outlinePrimary,
                                                                      onPressed:
                                                                          () async {
                                                                        // await onConnectPrinterBluetooth(
                                                                        //     context);
                                                                        connect(selected!.macAdress);
                                                                      },
                                                                    ),
                                                                  ),
                                                                // if (_connected)
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
                                                                          "Disconnect",
                                                                      width:
                                                                          120.0,
                                                                      height:
                                                                          42.0,
                                                                      buttonTextStyle: TextStyle(
                                                                          color: theme
                                                                              .colorScheme
                                                                              .secondary),
                                                                      buttonStyle:
                                                                          CustomButtonStyles
                                                                              .outlineSecondary,
                                                                      onPressed:
                                                                          () async {
                                                                        // await onDisconnectPrinterBluetooth(
                                                                        //     context);
                                                                        disconnect();
                                                                      },
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        12.0,
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
                                                                            .primary),
                                                                    buttonStyle:
                                                                        CustomButtonStyles
                                                                            .outlinePrimary,
                                                                    onPressed:
                                                                        () async {
                                                                      // await initPlatformState();
                                                                      print('yes');
                                                                      // getPermission();
                                                                      getBluetoots();
                                                                    },
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
                                                                        "Test Print",
                                                                    width:
                                                                        120.0,
                                                                    height:
                                                                        42.0,
                                                                    buttonTextStyle: TextStyle(
                                                                        color: theme
                                                                            .colorScheme
                                                                            .primary),
                                                                    buttonStyle:
                                                                        CustomButtonStyles
                                                                            .outlinePrimary,
                                                                    onPressed:
                                                                        () async {
                                                                      // await onTestPrintBluetooth(
                                                                      //     context);
                                                                      printTest();
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

  onGetPrinterBluetooth(BuildContext context) async {
    // setState(() {
    //   _progress = true;
    //   _msjprogress = "Wait";
    //   items = [];
    // });
    // final List<BluetoothInfo> listResult =
    //     await PrintBluetoothThermal.pairedBluetooths;

    // /*await Future.forEach(listResult, (BluetoothInfo bluetooth) {
    //   String name = bluetooth.name;
    //   String mac = bluetooth.macAdress;
    // });*/

    // setState(() {
    //   _progress = false;
    // });

    // if (listResult.length == 0) {
    //   _msj =
    //       "There are no bluetoohs linked, go to settings and link the printer";
    // } else {
    //   _msj = "Touch an item in the list to connect";
    // }

    // setState(() {
    //   items = listResult;
    // });
  }

  onConnectPrinterBluetooth(BuildContext context, String mac) async {
    // setState(() {
    //   _progress = true;
    //   _msjprogress = "Connecting...";
    //   connected = false;
    // });
    // final bool result =
    //     // await PrintBluetoothThermal.connect(macPrinterAddress: mac);
    //     // print("state conected $result");
    // if (result) connected = true;
    // setState(() {
    //   _progress = false;
    // });
  }

  onDisconnectPrinterBluetooth(BuildContext context) async {
    // final bool status = await PrintBluetoothThermal.disconnect;
    // setState(() {
    //   connected = false;
    // });
    // print("status disconnect $status");
  }

  onTestPrintBluetooth(BuildContext context) async {
    // printerManager.stopScan();
    // bluetooth.isConnected.then((isConnected) {
    //   if (isConnected == true) {
    //     bluetooth.printNewLine();
    //     bluetooth.printLeftRight(
    //       "No",
    //       "123",
    //       Size.medium.val,
    //     );
    //     bluetooth.printLeftRight(
    //       "Kasir",
    //       "abc",
    //       Size.medium.val,
    //     );
    //     bluetooth.printLeftRight(
    //       "Menu",
    //       "",
    //       Size.medium.val,
    //     );
    //     bluetooth.printLeftRight(
    //       "1x IDR 10.000",
    //       "IDR 10.000",
    //       Size.medium.val,
    //     );
    //   }
    // });
  }

  onTapSaveConfigPrinter(BuildContext context) async {
    setState(() {
      if (selectedTipePrinter == 'USB') {
        AppState().configPrinter = {
          'tipeConnection': selectedTipePrinter,
          'selectedPrinter': selectedPrinter,
          'selectedMacAddPrinter': null,
          // 'printer': null,
        };
      } else {
        AppState().configPrinter = {  
          'tipeConnection': selectedTipePrinter,
          'selectedPrinter': selected!.name,
          'selectedMacAddPrinter': selected!.macAdress,
          // 'printer': null,
        };
        AppState().selectedPrinter = selected;
      }
      // AppState().sele
      // AppState().selectPrinter(_device!);
      // Contoh logika koneksi perangkat Bluetooth di sini
      // bool isConnected = await connectToDevice(newDevice);
      // AppState().setConnectionStatus(_connected);
      // AppState().selectedPrinter = _device;
    });
    dynamic configPrinter = ConfigApp().generateConfig(
      AppState().configPrinter,
    );
    ConfigApp().writeConfig(configPrinter);
    print('check data, ${AppState().configPrinter}');
  }

  getPermission() async {
    bool status = await PrintBluetoothThermal.isPermissionBluetoothGranted;
    setState(() {
      _info = "permission bluetooth granted: $status";
    });
  }

  Future<void> platformState() async {
    String platformVersion;
    // int porcentbatery = 0;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await PrintBluetoothThermal.platformVersion;
      // print("patformversion: $platformVersion");
      // porcentbatery = await PrintBluetoothThermal.batteryLevel;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    print("bluetooth enabled: $result");
    if (result) {
      _msg = "Bluetooth enabled, please search and connect";
    } else {
      _msg = "Bluetooth not enabled";
    }

    setState(() {
      _info = platformVersion;
    });
  }

  Future<void> getBluetoots() async {
    setState(() {
      _progress = true;
      _msgprogress = "Wait";
      items = [];
    });
    final List<BluetoothInfo> listResult = await PrintBluetoothThermal.pairedBluetooths;

    /*await Future.forEach(listResult, (BluetoothInfo bluetooth) {
      String name = bluetooth.name;
      String mac = bluetooth.macAdress;
    });*/

    setState(() {
      _progress = false;
    });

    if (listResult.length == 0) {
      _msg = "There are no bluetoohs linked, go to settings and link the printer";
    } else {
      _msg = "Touch an item in the list to connect";
    }

    setState(() {
      items = listResult;
    });
  }

  Future<void> connect(String mac) async {
    setState(() {
      _progress = true;
      _msgprogress = "Connecting...";
      _connected = false;
    });
    final bool result = await PrintBluetoothThermal.connect(macPrinterAddress: mac);
    print("state conected $result");
    if (result) _connected = true;
    setState(() {
      _progress = false;
    });
  }

  Future<void> disconnect() async {
    final bool status = await PrintBluetoothThermal.disconnect;
    setState(() {
      _connected = false;
    });
    print("status disconnect $status");
  }

  Future<void> printTest() async {
    /*if (kDebugMode) {
      bool result = await PrintBluetoothThermalWindows.writeBytes(bytes: "Hello \n".codeUnits);
      return;
    }*/

    // print('check, ${selected.}')

    bool connectionStatus = await PrintBluetoothThermal.connectionStatus;
    //print("connection status: $conexionStatus");
    if (connectionStatus) {
      bool result = false;
      if (Platform.isWindows) {
        // List<int> ticket = await testWindows();
        // result = await PrintBluetoothThermalWindows.writeBytes(bytes: ticket);
      } else {
        List<int> ticket = await testTicket();
        result = await PrintBluetoothThermal.writeBytes(ticket);
      }
      print("print test result:  $result");
    } else {
      print("print test conexionStatus: $connectionStatus");
      setState(() {
        disconnect();
      });
      //throw Exception("Not device connected");
    }
  }

  Future<List<int>> testTicket() async {
    List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(optionprinttype == "58 mm" ? PaperSize.mm58 : PaperSize.mm80, profile);
    //bytes += generator.setGlobalFont(PosFontType.fontA);
    bytes += generator.reset();

    // final ByteData data = await rootBundle.load('assets/mylogo.jpg');
    // final Uint8List bytesImg = data.buffer.asUint8List();
    // img.Image? image = img.decodeImage(bytesImg);

    bytes += generator.text('Bold text', styles: PosStyles(bold: true));
    bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
    bytes += generator.text('Underlined text', styles: PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left', styles: PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center', styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right', styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    bytes += generator.row([
      PosColumn(
        text: 'col5',
        width: 6,
        styles: PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: 'col7',
        width: 6,
        styles: PosStyles(align: PosAlign.right, underline: true),
      ),
    ]);

    return bytes;
  }
}
