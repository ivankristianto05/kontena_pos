import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/functions/invoice.dart';
import 'package:kontena_pos/core/functions/payment_prediction.dart';
import 'package:kontena_pos/core/utils/print.dart';
import 'package:kontena_pos/core/theme/custom_text_style.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/core/utils/alert.dart';
import 'package:kontena_pos/core/utils/datetime_ui.dart';
import 'package:kontena_pos/core/utils/number_ui.dart';
import 'package:kontena_pos/data/mode_payment.dart';
import 'package:kontena_pos/widgets/custom_elevated_button.dart';
import 'package:kontena_pos/widgets/custom_outlined_button.dart';
import 'package:kontena_pos/widgets/list_cart.dart';
import 'package:kontena_pos/widgets/numpad.dart';

import 'package:http/http.dart' as http;
import 'package:kontena_pos/core/utils/alert.dart' as alert;

import 'package:kontena_pos/core/api/frappe_thunder_pos/create_pos_invoice.dart'
    as frappeFetchDataInvoice;

import 'package:kontena_pos/core/api/send_printer.dart' as sendToPrinter;

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
  String paymentMethod = 'CASH';
  double bill = 0.0;
  bool loading = false;
  late List<dynamic> cardListMethod;
  late List<dynamic> digitalListMethod;
  InvoiceCart cart = InvoiceCart();
  late List<InvoiceCartItem> cartData;
  dynamic invoice;

  @override
  void initState() {
    super.initState();

    setState(() {
      dynamic recapCart = cart.recapCart();
      bill = recapCart['totalPrice'] * 1.0;
      cardListMethod = card;
      digitalListMethod = digital;
      cartData = cart.getAllItemCart();
    });
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
        top: true,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 45.0,
              decoration: BoxDecoration(color: theme.colorScheme.surface),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment',
                      style: TextStyle(
                        color: theme.colorScheme.secondary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
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
                          color: theme.colorScheme.secondary,
                          size: 24.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1.0,
              thickness: 1,
              color: theme.colorScheme.outline,
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      // height: 600.0,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 10.0, 10.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 16.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              numberFormat(
                                                'idr',
                                                bill,
                                              ),
                                              style: TextStyle(
                                                color:
                                                    theme.colorScheme.onPrimary,
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Total Tagihan',
                                              style: theme.textTheme.labelLarge,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  Divider(
                                    height: 5.0,
                                    thickness: 0.5,
                                    color: theme.colorScheme.outline,
                                  ),
                                  // payment cash
                                  if (paymentMethod == 'CASH')
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 50.0, 0.0, 16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              setState(() {
                                                paymentMethod = '';
                                              });
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 0.0, 16.0),
                                                  child: Text(
                                                    'CASH',
                                                    style: theme
                                                        .textTheme.titleSmall,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons
                                                      .keyboard_arrow_up_rounded,
                                                  color: theme
                                                      .colorScheme.secondary,
                                                  size: 24.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            height: 5.0,
                                            thickness: 0.5,
                                            color: theme.colorScheme.outline,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 16.0, 0.0, 16.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                setState(() {
                                                  //   _model.payment = _model.bill;
                                                  //   _model.subMethod = 'CASH';
                                                  //   _model.ref = null;
                                                  // paymentMethod = 'Cash';
                                                  payment = bill;
                                                });
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: (payment == bill)
                                                      ? theme
                                                          .colorScheme.primary
                                                      : theme.colorScheme
                                                          .primaryContainer,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  border: Border.all(
                                                    color: theme
                                                        .colorScheme.primary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 16.0,
                                                          16.0, 16.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Uang Pas',
                                                        style: TextStyle(
                                                          color: payment == bill
                                                              ? theme
                                                                  .colorScheme
                                                                  .primaryContainer
                                                              : theme
                                                                  .colorScheme
                                                                  .primary,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Builder(
                                                  builder: (context) {
                                                    final paymentRecommendation =
                                                        paymentPrediction(bill)
                                                            .toList();

                                                    return GridView.builder(
                                                      padding: EdgeInsets.zero,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        crossAxisSpacing: 5.0,
                                                        mainAxisSpacing: 5.0,
                                                        childAspectRatio: 3.0,
                                                      ),
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          paymentRecommendation
                                                              .length,
                                                      itemBuilder: (context,
                                                          paymentRecommendationIndex) {
                                                        final paymentRecommendationItem =
                                                            paymentRecommendation[
                                                                paymentRecommendationIndex];
                                                        return Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: (payment == paymentRecommendationItem)
                                                                ? theme
                                                                    .colorScheme
                                                                    .primary
                                                                : theme
                                                                    .colorScheme
                                                                    .primaryContainer,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0),
                                                            border: Border.all(
                                                              color: theme
                                                                  .colorScheme
                                                                  .primary,
                                                              width: 2.0,
                                                            ),
                                                          ),
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
                                                            onTap: () async {
                                                              setState(() {
                                                                payment =
                                                                    paymentRecommendationItem;
                                                              });
                                                            },
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  numberFormat(
                                                                    'idr',
                                                                    paymentRecommendationItem,
                                                                  ),
                                                                  style: TextStyle(
                                                                      color: (payment ==
                                                                              paymentRecommendationItem)
                                                                          ? theme
                                                                              .colorScheme
                                                                              .primaryContainer
                                                                          : theme
                                                                              .colorScheme
                                                                              .primary),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (paymentMethod != 'CASH')
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 150.0, 0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          setState(() {
                                            paymentMethod = 'CASH';
                                          });
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 16.0, 0.0, 16.0),
                                              child: Text(
                                                'CASH',
                                                style: TextStyle(
                                                    color: theme
                                                        .colorScheme.primary),
                                              ),
                                            ),
                                            Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color:
                                                  theme.colorScheme.secondary,
                                              size: 24.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                  // payment card
                                  if (paymentMethod == 'CARD')
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              setState(() {
                                                paymentMethod = '';
                                              });
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 0.0, 16.0),
                                                  child: Text(
                                                    'CARD',
                                                    style: theme
                                                        .textTheme.titleSmall,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons
                                                      .keyboard_arrow_up_rounded,
                                                  color: theme
                                                      .colorScheme.secondary,
                                                  size: 24.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                  cardListMethod.length,
                                                  (methodsIndex) {
                                                    final methodsItem =
                                                        cardListMethod[
                                                            methodsIndex];
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  10.0,
                                                                  0.0,
                                                                  10.0),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {},
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: theme
                                                                .colorScheme
                                                                .primary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0),
                                                            border: Border.all(
                                                              color: theme
                                                                  .colorScheme
                                                                  .primary,
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        16.0,
                                                                        16.0,
                                                                        16.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  methodsItem[
                                                                      'mode_of_payment'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: theme
                                                                        .colorScheme
                                                                        .primaryContainer,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (paymentMethod != 'CARD')
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        setState(() {
                                          paymentMethod = 'CARD';
                                        });
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 16.0, 0.0, 16.0),
                                            child: Text(
                                              'CARD',
                                              style: TextStyle(
                                                  color: theme
                                                      .colorScheme.primary),
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: theme.colorScheme.secondary,
                                            size: 24.0,
                                          ),
                                        ],
                                      ),
                                    ),

                                  // payment digital
                                  if (paymentMethod == 'DIGITAL')
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              setState(() {
                                                paymentMethod = '';
                                              });
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 0.0, 16.0),
                                                  child: Text(
                                                    'DIGITAL',
                                                    style: theme
                                                        .textTheme.titleSmall,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons
                                                      .keyboard_arrow_up_rounded,
                                                  color: theme
                                                      .colorScheme.secondary,
                                                  size: 24.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                  digitalListMethod.length,
                                                  (methodsIndex) {
                                                    final methodsItem =
                                                        digitalListMethod[
                                                            methodsIndex];
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  10.0,
                                                                  0.0,
                                                                  10.0),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {},
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: theme
                                                                .colorScheme
                                                                .primary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0),
                                                            border: Border.all(
                                                              color: theme
                                                                  .colorScheme
                                                                  .primary,
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        16.0,
                                                                        16.0,
                                                                        16.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  methodsItem[
                                                                      'mode_of_payment'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: theme
                                                                        .colorScheme
                                                                        .primaryContainer,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (paymentMethod != 'DIGITAL')
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        setState(() {
                                          paymentMethod = 'DIGITAL';
                                        });
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 16.0, 0.0, 16.0),
                                            child: Text(
                                              'DIGITAL',
                                              style: TextStyle(
                                                  color: theme
                                                      .colorScheme.primary),
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: theme.colorScheme.secondary,
                                            size: 24.0,
                                          ),
                                        ],
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
                  Expanded(
                    flex: 2,
                    child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          border: Border(
                            left: BorderSide(
                              color: theme.colorScheme.outline,
                              width: 1.0,
                            ),
                            right: BorderSide(
                              color: theme.colorScheme.outline,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NumPad(
                              isDisable: paymentStatus,
                              initialValue: payment,
                              onResult: (value) {
                                setState(() {
                                  payment = double.parse(value);
                                });
                              },
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 24, 16.0, 24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (paymentStatus == false)
                                    CustomOutlinedButton(
                                      height: 48.0,
                                      text: "Pay",
                                      isDisabled: payment < bill ? true : false,
                                      buttonTextStyle: TextStyle(
                                          color: theme
                                              .colorScheme.primaryContainer),
                                      buttonStyle: payment < bill
                                          ? CustomButtonStyles
                                              .onPrimaryContainer
                                          : CustomButtonStyles.primary,
                                      onPressed: () {
                                        onTapPay(context);
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 10.0, 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    AppState().typeTransaction,
                                                    textAlign: TextAlign.center,
                                                    style: theme
                                                        .textTheme.bodyMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              height: 5.0,
                                              thickness: 0.5,
                                              color: theme.colorScheme.outline,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        paymentMethod != ''
                                                            ? paymentMethod
                                                            : '-',
                                                        style: theme.textTheme
                                                            .bodyMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 50.0,
                                                  child: VerticalDivider(
                                                    width: 5.0,
                                                    thickness: 0.5,
                                                    color: theme
                                                        .colorScheme.outline,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      if (paymentStatus ==
                                                          false)
                                                        Text(
                                                          'Belum dibayar',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: theme
                                                                .colorScheme
                                                                .onError,
                                                          ),
                                                        ),
                                                      if (paymentStatus)
                                                        Text(
                                                          'Sudah dibayar',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: theme
                                                                .colorScheme
                                                                .primary,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              height: 5.0,
                                              thickness: 0.5,
                                              color: theme.colorScheme.outline,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
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
                                                          'Dibayar',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: theme.textTheme
                                                              .bodyMedium,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          numberFormat(
                                                              'idr', payment),
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: theme.textTheme
                                                              .bodyMedium,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                          'Kembalian',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: theme.textTheme
                                                              .bodyMedium,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        if ((payment - bill) >=
                                                            0)
                                                          Text(
                                                            numberFormat(
                                                              'idr',
                                                              (payment - bill),
                                                            ),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium,
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
                                    ],
                                  ),
                                  Divider(
                                    height: 5.0,
                                    thickness: 0.5,
                                    color: theme.colorScheme.outline,
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Builder(
                                            builder: (context) {
                                              final itemCart = cartData;
                                              int totalAddon = 0;
                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: itemCart.length,
                                                itemBuilder:
                                                    (context, itemCartIndex) {
                                                  final itemCartItem =
                                                      itemCart[itemCartIndex];
                                                  return ListCart(
                                                    title:
                                                        "${itemCartItem.itemName} (${itemCartItem.qty})",
                                                    subtitle:
                                                        itemCartItem.itemName ??
                                                            '-',
                                                    // addon: addon2,
                                                    // addons: addons,
                                                    qty: itemCartItem.qty
                                                        .toString(),
                                                    // catatan: itemCartItem.preference,
                                                    titleStyle: CustomTextStyles
                                                        .labelLargeBlack,
                                                    price: itemCartItem.price
                                                        .toString(),
                                                    total: numberFormat(
                                                        'idr',
                                                        itemCartItem.qty *
                                                            (itemCartItem
                                                                    .price +
                                                                totalAddon)),
                                                    priceStyle: CustomTextStyles
                                                        .labelLargeBlack,
                                                    labelStyle: CustomTextStyles
                                                        .bodySmallBluegray300,
                                                    editLabelStyle: TextStyle(
                                                      color: theme
                                                          .colorScheme.primary,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    padding: EdgeInsets.all(16),
                                                    note: itemCartItem.notes ??
                                                        '',
                                                    lineColor: appTheme.gray200,
                                                    secondaryStyle:
                                                        CustomTextStyles
                                                            .bodySmallGray,
                                                    isEdit: false,
                                                    // onTap: () => onTapEditItem(
                                                    //     context,
                                                    //     itemData,
                                                    //     index),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (paymentStatus)
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Divider(
                                    height: 5.0,
                                    thickness: 0.5,
                                    color: theme.colorScheme.outline,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        CustomOutlinedButton(
                                          height: 48.0,
                                          text: "Reprint Invoice",
                                          buttonTextStyle: TextStyle(
                                              color: theme.colorScheme.primary),
                                          buttonStyle:
                                              CustomButtonStyles.outlinePrimary,
                                          onPressed: () {
                                            onPrintInvoice(true);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        CustomOutlinedButton(
                                          height: 48.0,
                                          text: "Reprint Checker",
                                          buttonTextStyle: TextStyle(
                                              color: theme.colorScheme.primary),
                                          buttonStyle:
                                              CustomButtonStyles.outlinePrimary,
                                          onPressed: () {
                                            onPrintChecker();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 24.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        CustomElevatedButton(
                                          text: "Done",
                                          buttonTextStyle: TextStyle(
                                              color: theme.colorScheme
                                                  .primaryContainer),
                                          buttonStyle:
                                              CustomButtonStyles.primaryButton,
                                          onPressed: () {
                                            onTapDone(context);
                                          },
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
                  ),
                ],
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

  onTapPay(BuildContext context) async {
    onCallPosInvoice();
  }

  onTapDone(BuildContext context) async {
    setState(() {
      AppState.resetInvoiceCart();
      AppState().typeTransaction = 'dine-in';
    });
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.invoiceScreen,
      (route) => false,
    );
  }

  onCallPosInvoice() async {
    List<dynamic> tempItem = [];
    List<dynamic> tempPayment = [];

    for (var element in cartData) {
      tempItem.add({
        'item_code': element.name,
        // 'item_name': element.itemName,
        // 'description': element.description,
        // 'uom': element.uom,
        // 'conversion_factor': 1,
        'qty': element.qty,
        // 'rate': element.price,
        // 'amount': element.totalPrice,
        // 'base_rate': element.price,
        // 'base_amount': element.totalPrice,
        // 'income_account': AppState().configCompany['default_income_account'],
        // 'cost_center': AppState().configCompany['cost_center'],
        // 'pos_cart': element.cartId,
        'pos_order': element.id.contains('CORD') ? element.id : null,
      });
    }

    // print('check config payment, ${AppState().configCompany}');

    // for (var methodPay in AppState().configCompany['payments']) {
    //   print('check, $methodPay');
    // }
    tempPayment.add({
      'mode_of_payment': 'Cash',
      'amount': payment,
      'account': '110-10-002 - Petty Cash G.Cashier (Rp) - KTN001'
    });

    final frappeFetchDataInvoice.CreatePosInvoiceRequest request =
        frappeFetchDataInvoice.CreatePosInvoiceRequest(
      cookie: AppState().setCookie,
      customer: '0',
      customerName: 'Guest',
      company: AppState().configCompany['name'],
      postingDate: dateTimeFormat('date', null).toString(),
      postingTime: timeFormat('time_full', 'now'),
      outlet: AppState().configPosProfile['name'],
      currency: AppState().configPosProfile['currency'],
      conversionRate: 1,
      sellingPriceList: AppState().configPosProfile['selling_price_list'],
      priceListCurrency: AppState().configPosProfile['currency'],
      plcConversionRate: 1,
      debitTo: AppState().configCompany['default_receivable_account'],
      costCenter: AppState().configCompany['cost_center'],
      items: tempItem,
      baseNetTotal: bill,
      baseGrandTotal: bill,
      grandTotal: bill,
      payments: tempPayment,
      basePaidAmount: payment,
      paidAmount: payment,
    );

    try {
      print('check request, ${request}');
      final callRespon =
          await frappeFetchDataInvoice.request(requestQuery: request);
      print('call respon, ${callRespon}');
      if (callRespon != null) {
        setState(() {
          paymentStatus = true;
          invoice = callRespon;
        });

        onPrintInvoice(false);
        onPrintChecker();
      }
    } catch (error) {
      print('error pos invoice, ${error}');
      if (context.mounted) {
        alert.alertError(context, error.toString());
      }
    }
  }

  onPrintInvoice(bool reprint) async {
    dynamic docPrint = await printInvoice(
        reprint ? 'reprint' : null,
        invoice,
        AppState().configPrinter,
        AppState().configCompany,
        AppState().configPosProfile,
        AppState().configUser);

    print('print invoce, $docPrint');

    final sendToPrinter.ToPrint request =
        sendToPrinter.ToPrint(doc: docPrint, ipAddress: '127.0.0.1');
    try {
      final callRespon = await sendToPrinter.request(requestQuery: request);
      // print('call respon, ${callRespon}');
      if (callRespon != null) {
        // setState((){
        //   paymentStatus = true;
        //   invoice = callRespon;
        // });
      }
    } catch (error) {
      // print('error pos invoice, ${error}');
      if (context.mounted) {
        alert.alertError(context, error.toString());
      }
    }
  }

  onPrintChecker() async {
    dynamic docPrint = await printChecker(
      invoice,
      AppState().configPrinter,
    );

    // print('print invoce, $docPrint');

    final sendToPrinter.ToPrint request =
        sendToPrinter.ToPrint(doc: docPrint, ipAddress: '127.0.0.1');
    try {
      final callRespon = await sendToPrinter.request(requestQuery: request);
      print('call respon, ${callRespon}');
      if (callRespon != null) {
        // setState((){
        //   paymentStatus = true;
        //   invoice = callRespon;
        // });
      }
    } catch (error) {
      print('error pos invoice, ${error}');
      if (context.mounted) {
        alert.alertError(context, error.toString());
      }
    }
  }
}
