import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    super.key,
    bool? isInitialize,
  }) : isInitialize = isInitialize ?? false;

  final bool isInitialize;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? _barcode;

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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.colorScheme.primaryContainer,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 45.0,
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Setting POS',
                          style: TextStyle(
                            color: theme.colorScheme.secondary,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            onTapClose(context);
                          },
                          child: Icon(
                            Icons.close_rounded,
                            color: theme.colorScheme.secondary,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                BarcodeKeyboardListener(
                  bufferDuration: Duration(milliseconds: 200),
                  onBarcodeScanned: (barcode) {
                    // if (!visible) return;
                    // print(barcode);
                    // setState(() {
                    //   _barcode = barcode;
                    // });
                  },
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  onTapClose(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.invoiceScreen,
      (route) => false,
    );
  }
}
