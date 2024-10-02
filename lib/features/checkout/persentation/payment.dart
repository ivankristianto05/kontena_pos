import 'package:flutter/material.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/widgets/top_bar.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic paymentService = {
    'Dine in',
    'Take Away',
    'Gojek',
    'Grab',
    'Shopee',
  };
  double payment = 0.0;
  bool paymentStatus = false;
  String paymentMethod = 'Cash';
  double bill = 0.0;
  bool loading = false;

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
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 45.0,
              decoration: BoxDecoration(color: theme.colorScheme.secondary),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pembayaran',
                      style: theme.textTheme.labelMedium,
                    ),
                    if (!paymentStatus)
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          // setState(() {
                          //   FFAppState().ActivePage = 'Menu';
                          // });
                          // context.pop();
                          onTapClose(context);
                        },
                        child: Icon(
                          Icons.close_rounded,
                          color: theme.colorScheme.primaryContainer,
                          size: 24.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
