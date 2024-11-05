import 'package:flutter/material.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/core/utils/number_ui.dart';
import 'package:kontena_pos/widgets/custom_elevated_button.dart';

class SessionClosing extends StatefulWidget {
  SessionClosing({
    Key? key,
    required this.dataSession,
  }) : super(key: key);

  final List<dynamic> dataSession;

  @override
  _SessionClosingState createState() => _SessionClosingState();
}

class _SessionClosingState extends State<SessionClosing> {
  List<dynamic> invoiceSession = [];
  List<dynamic> paymentSession = [];

  double totalAmountInvoice = 0;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    // reinitSession();
  }

  @override
  void initState() {
    super.initState();
    reinitSession();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.6,
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
                              'Detail Session Cashier',
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              Navigator.of(context).pop();
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
                      color: theme.colorScheme.outline,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              width: double.infinity,
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
                                          Text(
                                            'List Invoices:',
                                            style: TextStyle(
                                              color:
                                                  theme.colorScheme.secondary,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Container(
                                            decoration: const BoxDecoration(),
                                            child: Container(),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 12.0, 0.0, 16.0),
                                            child: Builder(
                                              builder: (context) {
                                                final invoiceDisplay =
                                                    invoiceSession;
                                                // setState(() {
                                                totalAmountInvoice = 0;

                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (invoiceDisplay
                                                        .isNotEmpty)
                                                      ListView.builder(
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            invoiceDisplay
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final currentInvoice =
                                                              invoiceDisplay[
                                                                  index];
                                                          totalAmountInvoice +=
                                                              currentInvoice[
                                                                  'paid_amount'];
                                                          return Column(
                                                            children: [
                                                              SizedBox(
                                                                width: double
                                                                    .infinity,
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
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            currentInvoice['name'],
                                                                            style:
                                                                                TextStyle(
                                                                              color: theme.colorScheme.secondary,
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            currentInvoice['customer_name'],
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                TextStyle(
                                                                              color: theme.colorScheme.secondary,
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            currentInvoice['mode_of_payment'],
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                TextStyle(
                                                                              color: theme.colorScheme.secondary,
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            numberFormat('idr_fixed',
                                                                                currentInvoice['paid_amount']),
                                                                            style:
                                                                                TextStyle(
                                                                              color: theme.colorScheme.secondary,
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Divider(
                                                                height: 1.0,
                                                                thickness: 1.0,
                                                                color: theme
                                                                    .colorScheme
                                                                    .outline,
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    if (invoiceDisplay.isEmpty)
                                                      Container(
                                                        width: double.infinity,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: theme
                                                                    .colorScheme
                                                                    .surface),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  8.0,
                                                                  4.0,
                                                                  8.0,
                                                                  4.0),
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
                                          SizedBox(
                                            width: double.infinity,
                                            height: 30.0,
                                            // decoration: BoxDecoration(
                                            //     color:
                                            //         theme.colorScheme.surface),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      8.0, 4.0, 8.0, 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Total',
                                                    style: TextStyle(
                                                      color: theme.colorScheme
                                                          .secondary,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    numberFormat('idr_fixed',
                                                        totalAmountInvoice),
                                                    style: TextStyle(
                                                      color: theme.colorScheme
                                                          .secondary,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0,
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
                            ),
                          ),
                          Container(
                            width: 1.0,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.outline,
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
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            8.0, 24.0, 8.0, 4.0),
                                    child: Text(
                                      'Payments:',
                                      style: TextStyle(
                                        color: theme.colorScheme.secondary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Padding(
                                    padding: const EdgeInsetsDirectional
                                        .fromSTEB(8.0, 12.0, 8.0, 16.0),
                                    child: Builder(
                                      builder: (context) {
                                        final paymentDisplay = paymentSession;
                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (paymentDisplay.isNotEmpty)
                                              ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: paymentDisplay.length,
                                                itemBuilder: (context, index) {
                                                  final currentPayment = paymentDisplay[index];
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            currentPayment['mode_of_payment'],
                                                            style:
                                                                TextStyle(
                                                              color: theme.colorScheme.secondary,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                          Text(
                                                            numberFormat('idr_fixed', currentPayment['amount']),
                                                            style:
                                                                TextStyle(
                                                              color: theme.colorScheme.secondary,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                        ]
                                                      ),
                                                      const SizedBox(height: 4.0),
                                                    ]
                                                  );
                                                }
                                              )
                                          ]
                                        );
                                      },
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
                        child: CustomElevatedButton(
                          text: "Close Cashier",
                          buttonTextStyle: TextStyle(
                            color: theme.colorScheme.primaryContainer,
                          ),
                          buttonStyle: CustomButtonStyles.primary,
                          onPressed: () {
                            // addToCart(
                            //   context,
                            //   widget.dataMenu,
                            //   selectedVarian,
                            //   selectedAddon,
                            //   notesController.text,
                            //   int.parse(qtyController.text),
                            // );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getMetodePayment(List<dynamic> payments) {
    String tmp = '';
    // Filter items dengan `amount` > 0
    var filteredItems = payments.where((item) => item["amount"] > 0).toList();

    // Gabungkan menjadi teks dengan delimiter koma
    var result = filteredItems
        .map((item) => item['mode_of_payment'].toString())
        .join(", ");

    return result;
  }

  reinitSession() {
    List<dynamic> defaultMethod = AppState().configPosProfile['payments'];
    List<dynamic> payments = [];
    List<dynamic> invoice = widget.dataSession.map((item) {
      return {
        "name": item["name"],
        "customer_name": item["customer_name"],
        "paid_amount": item["paid_amount"],
        "mode_of_payment": getMetodePayment(item['payments']),
      };
    }).toList();

    for (var method in defaultMethod) {
      payments.add({
        'mode_of_payment': method['mode_of_payment'],
        'amount': 0,
      });
    }

    for (var pay in payments) {
      String mode = pay['mode_of_payment'];
      double totalAmount = 0;

      for (var invoice in widget.dataSession) {
        for (var payGroup in invoice['payments']) {
          // print('paygroup ${payGroup.runtimeType}');
          // print('paygroup ${payGroup}');
          // for (var paym in payGroup) {
          if (payGroup['mode_of_payment'] == mode) {
            totalAmount += payGroup['amount'];
          }
          // }
        }
      }

      pay['amount'] = totalAmount;
    }

    setState(() {
      invoiceSession = invoice;
      paymentSession = payments;
    });
    // print('check payments, ${payments}');
    // print('check invoice, ${invoice}');
  }
}
