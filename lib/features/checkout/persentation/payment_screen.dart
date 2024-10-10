import 'package:flutter/material.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/functions/cart.dart';
import 'package:kontena_pos/core/functions/payment_prediction.dart';
import 'package:kontena_pos/core/theme/custom_text_style.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/core/utils/number_ui.dart';
import 'package:kontena_pos/data/mode_payment.dart';
import 'package:kontena_pos/models/cartitem.dart';
import 'package:kontena_pos/widgets/custom_elevated_button.dart';
import 'package:kontena_pos/widgets/custom_outlined_button.dart';
import 'package:kontena_pos/widgets/numpad.dart';
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
  String paymentMethod = 'CASH';
  double bill = 0.0;
  bool loading = false;
  late List<dynamic> cardListMethod;
  late List<dynamic> digitalListMethod;
  Cart cart = Cart(AppState());
  late List<CartItem> cartData;

  @override
  void initState() {
    super.initState();

    setState(() {
      bill = AppState().totalPrice;
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
        top: false,
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
                                                AppState().totalPrice,
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
                                          0.0, 150.0, 0.0, 16.0),
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
                                                // setState(() {
                                                //   _model.payment = _model.bill;
                                                //   _model.subMethod = 'CASH';
                                                //   _model.ref = null;
                                                // });
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
                                                            onTap: () async {},
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
                          children: [
                            NumPad(
                              onResult: (value) {
                                print('value, $value');
                                setState(() {
                                  payment = double.parse(value);
                                });
                              },
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 24, 16.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CustomOutlinedButton(
                                    height: 48.0,
                                    text: "Pay",
                                    buttonTextStyle: TextStyle(
                                        color:
                                            theme.colorScheme.primaryContainer),
                                    buttonStyle: CustomButtonStyles.primary,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  Expanded(
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
                                                      if (!paymentStatus)
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
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 15.0,
                                                                0.0, 0.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            4.0),
                                                                child: Text(
                                                                  '${itemCartItem.name} (${itemCartItem.qty})',
                                                                  style: CustomTextStyles
                                                                      .labelLargeBlack,
                                                                ),
                                                              ),
                                                              Divider(
                                                                height: 2.0,
                                                                thickness: 0.5,
                                                                color: theme
                                                                    .colorScheme
                                                                    .surface,
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        4.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              itemCartItem.name,
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                '${itemCartItem.qty} X ${numberFormat('idr', itemCartItem.price)}',
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                              Text(
                                                                '${numberFormat('idr', itemCartItem.qty * (itemCartItem.price + totalAddon))}',
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
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
                                        onPressed: () {},
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
                                        onPressed: () {},
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
                                            color: theme
                                                .colorScheme.primaryContainer),
                                        buttonStyle:
                                            CustomButtonStyles.primaryButton,
                                        onPressed: () {},
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
}
