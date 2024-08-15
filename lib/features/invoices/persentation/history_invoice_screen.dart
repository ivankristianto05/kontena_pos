import 'package:flutter/material.dart';
import 'package:kontena_pos/core/app_export.dart';
import 'package:kontena_pos/widgets/top_bar.dart';
// import 'package:kontena_pos/core/functions/cart.dart';

class HistoryInvoiceScreen extends StatefulWidget {
  const HistoryInvoiceScreen({Key? key}) : super(key: key);

  @override
  _HistoryInvoiceScreenState createState() => _HistoryInvoiceScreenState();
}

class _HistoryInvoiceScreenState extends State<HistoryInvoiceScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
    double screenWidth = MediaQuery.of(context).size.width;
    double searchbarWidth = screenWidth * 0.65;
    double smallButtonWidth = screenWidth * 0.05;
    double buttonWidth = screenWidth * 0.15;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 45.0,
              decoration: BoxDecoration(
                color: theme.colorScheme.onBackground,
              ),
              child: TopBar(
                smallButtonWidth: smallButtonWidth,
                buttonWidth: buttonWidth,
                // isWideScreen: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
