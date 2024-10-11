import 'package:flutter/material.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/widgets/custom_elevated_button.dart';

class SettingApplication extends StatefulWidget {
  SettingApplication({Key? key}) : super(key: key);

  @override
  _SettingApplicationState createState() => _SettingApplicationState();
}

class _SettingApplicationState extends State<SettingApplication> {
  bool canVoid = true;
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
                                                'Pengaturan Aplikasi',
                                                style: TextStyle(
                                                  color: theme
                                                      .colorScheme.secondary,
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
                                                          'Nama POS',
                                                          style: TextStyle(
                                                            color: theme
                                                                .colorScheme
                                                                .secondary,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Nama POS yang terdaftar oleh sistem',
                                                          style: TextStyle(
                                                            color: theme
                                                                .colorScheme
                                                                .onPrimaryContainer,
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
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.00,
                                                                    0.00),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                (false)
                                                                    ? 'Outlet 1'
                                                                    : 'Outlet',
                                                                style:
                                                                    TextStyle(
                                                                  color: theme
                                                                      .colorScheme
                                                                      .secondary,
                                                                ),
                                                              ),
                                                            ),
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
                                                          child: Text(
                                                            (false)
                                                                ? 'Data setting tersimpan'
                                                                : 'Data Setting belum tersimpan',
                                                            style: TextStyle(
                                                              color: theme
                                                                  .colorScheme
                                                                  .secondary,
                                                            ),
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
                                                          'Void',
                                                          style: TextStyle(
                                                            color: theme
                                                                .colorScheme
                                                                .secondary,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Atur transaksi bisa void jika ada customer',
                                                          style: TextStyle(
                                                            color: theme
                                                                .colorScheme
                                                                .onPrimaryContainer,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Switch.adaptive(
                                                                  value:
                                                                      canVoid,
                                                                  onChanged:
                                                                      (newValue) async {
                                                                    setState(() =>
                                                                        canVoid =
                                                                            newValue);
                                                                  },
                                                                  activeColor: theme
                                                                      .colorScheme
                                                                      .primary,
                                                                  activeTrackColor: theme
                                                                      .colorScheme
                                                                      .primary,
                                                                  inactiveTrackColor: theme
                                                                      .colorScheme
                                                                      .onPrimaryContainer,
                                                                  inactiveThumbColor: theme
                                                                      .colorScheme
                                                                      .onPrimaryContainer,
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Text(
                                                                  (false)
                                                                      ? 'Bisa Void'
                                                                      : 'Tidak Bisa Void',
                                                                  style:
                                                                      TextStyle(
                                                                    color: theme
                                                                        .colorScheme
                                                                        .secondary,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
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
                                                          onPressed: () {},
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
}
