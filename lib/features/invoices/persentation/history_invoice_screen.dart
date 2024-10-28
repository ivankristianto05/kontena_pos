import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/app_export.dart';
import 'package:kontena_pos/core/theme/custom_text_style.dart';
import 'package:kontena_pos/core/utils/alert.dart';
import 'package:kontena_pos/core/utils/datetime_ui.dart';
import 'package:kontena_pos/core/utils/number_ui.dart';
import 'package:kontena_pos/widgets/list_cart.dart';
import 'package:kontena_pos/widgets/searchbar.dart';
import 'package:kontena_pos/widgets/top_bar.dart';
import 'package:kontena_pos/core/api/frappe_thunder_pos/pos_invoice.dart'
    as FrappeFetchDataGetInvoice;
// import 'package:kontena_pos/core/functions/cart.dart';

class HistoryInvoiceScreen extends StatefulWidget {
  const HistoryInvoiceScreen({Key? key}) : super(key: key);

  @override
  _HistoryInvoiceScreenState createState() => _HistoryInvoiceScreenState();
}

class _HistoryInvoiceScreenState extends State<HistoryInvoiceScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<dynamic> tempPosOrder = [];

  dynamic invoiceSelected;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    onTapRefresh();
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
            TopBar(
              isSelected: 'history',
              onTapRefresh: () {
                onTapRefresh();
              },
            ),
            Expanded(
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    // crossAxisAlignment: CrossAxisAlignment.left,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Searchbar(
                                  onCompleted: () {},
                                ),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 120.0, 8.0, 0.0),
                                child: Align(
                                  alignment: AlignmentDirectional(0.00, 0.00),
                                  child: SingleChildScrollView(
                                    child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        if (isLoading == false)
                                        AlignedGridView.count(
                                          crossAxisCount: 1,
                                          mainAxisSpacing: 6,
                                          crossAxisSpacing: 6,
                                          shrinkWrap: true,
                                          itemCount: tempPosOrder.length,
                                          itemBuilder: (context, index) {
                                            final order = tempPosOrder[index];
                                            return InkWell(
                                              onTap: () {
                                                onTapAction(context, order);
                                              },
                                              child: Card(
                                                elevation: 2,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                        16.0,
                                                        16.0,
                                                        16.0,
                                                        10.0,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                order['name'],
                                                                style: theme
                                                                    .textTheme
                                                                    .titleMedium,
                                                              ),
                                                              Text(
                                                                'Table ${order['table']}',
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(
                                                            height: 5.0,
                                                            thickness: 0.5,
                                                            color: theme
                                                                .colorScheme
                                                                .outline,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                order['customer_name']
                                                                    .toString(),
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                              Text(
                                                                'Total: ${numberFormat('idr_fixed', order['grand_total'])}',
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium,
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
                                                              4.0,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      dateTimeFormat(
                                                                        'dateui',
                                                                        order[
                                                                            'posting_date'],
                                                                      ).toString(),
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall,
                                                                    ),
                                                                    Text(
                                                                      ' | ${timeFormat(
                                                                        'time_simple',
                                                                        order[
                                                                            'posting_time'],
                                                                      ).toString()}',
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelSmall,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  'Paid: ${numberFormat('idr_fixed', order['paid_amount'])}',
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
                                            );
                                          },
                                        ),
                                      if (isLoading == true)
                                           Container(
                                              width: double.infinity,
                                              height: 48.0,
                                              decoration: BoxDecoration(
                                                color: theme.colorScheme.primary,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    EdgeInsetsDirectional.fromSTEB(
                                                        8.0, 0.0, 8.0, 0.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                        width: 23,
                                                        height: 23,
                                                        child:
                                                            CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                            Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              10.0, 0.0, 8.0, 0.0),
                                                      child: Text(
                                                        'Loading...',
                                                        style: TextStyle(
                                                            color: theme.colorScheme
                                                                .primaryContainer),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.25,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          border: Border.all(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 15.0, 15.0, 15.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Detail Invoice',
                                style: TextStyle(
                                  color: theme.colorScheme.secondary,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (invoiceSelected != null)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 16.0, 0.0, 0.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          invoiceSelected['name'],
                                          style: TextStyle(
                                            color: theme.colorScheme.secondary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${invoiceSelected['customer_name']}',
                                          style: TextStyle(
                                            color: theme.colorScheme.secondary,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${dateTimeFormat('dateui', invoiceSelected['posting_date'])} | ${timeFormat('time_simple', invoiceSelected['posting_time'])}',
                                          style: TextStyle(
                                            color: theme.colorScheme.secondary,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Divider(
                                          height: 14.0,
                                          thickness: 1.0,
                                          color: theme.colorScheme.outline,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    '${invoiceSelected['payments'][0]['mode_of_payment']}'
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 24.0,
                                              child: VerticalDivider(
                                                thickness: 1.0,
                                                color:
                                                    theme.colorScheme.outline,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    '${invoiceSelected['status']}',
                                                    style: TextStyle(
                                                      color: () {
                                                        if (invoiceSelected['status'] == 'Paid') {
                                                          return theme.colorScheme.onSecondary;
                                                        } else if (invoiceSelected['status'] == 'Cancelled') {
                                                          return theme.colorScheme.error;
                                                        } else {
                                                          return theme.colorScheme.onPrimaryContainer;
                                                        }
                                                      }(), 
                                                    )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 14.0,
                                          thickness: 1.0,
                                          color: theme.colorScheme.outline,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Total',
                                            ),
                                            Text(
                                              '${numberFormat('idr_fixed', invoiceSelected['grand_total'])}'
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Pay',
                                            ),
                                            Text(numberFormat('idr_fixed', invoiceSelected['paid_amount']))
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Change',
                                            ),
                                            Text((invoiceSelected['paid_amount'] >= invoiceSelected['grand_total']) ? numberFormat('idr_fixed', (invoiceSelected['paid_amount'] - invoiceSelected['grand_total'])) : numberFormat('idr_fixed', 0))
                                          ],
                                        ),
                                        Divider(
                                          height: 14.0,
                                          thickness: 1.0,
                                          color: theme.colorScheme.outline,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: invoiceSelected['items'].length,
                                              itemBuilder: (context, index) {
                                                final itemData = invoiceSelected['items'][index];
                                                print('item data, ${itemData['qty']}');
                                                print('item data, ${itemData['rate']}');
                                                return ListCart(
                                                  title:
                                                      "${itemData['item_name']} (${itemData['qty'].floor()})",
                                                  subtitle:
                                                      itemData['item_name'] ?? '-',
                                                  // addon: addon2,
                                                  // addons: addons,
                                                  qty: itemData['qty'].floor().toString(),
                                                  catatan: '',
                                                  titleStyle: CustomTextStyles
                                                      .labelLargeBlack,
                                                  price: itemData['rate'].toString(),
                                                  total: numberFormat(
                                                      'idr',
                                                      (itemData['qty'] *
                                                          itemData['rate'])),
                                                  priceStyle: CustomTextStyles
                                                      .labelLargeBlack,
                                                  labelStyle: CustomTextStyles
                                                      .bodySmallBluegray300,
                                                  editLabelStyle: TextStyle(
                                                    color:
                                                        theme.colorScheme.primary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  padding: EdgeInsets.all(8),
                                                  note: '',
                                                  lineColor: appTheme.gray200,
                                                  secondaryStyle: CustomTextStyles
                                                      .bodySmallGray,
                                                  isEdit: false,
                                                  onTap: () => {},
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTapRefresh() async {
    print('yes');
    setState((){
      isLoading = true;
    });
    await onCallDataPosOrder();
    setState((){
      // isLoading = false;
    });
  }


  onTapAction(BuildContext context, dynamic item) async {
    print('yes click');
    // setState(() {
    //   invoiceSelected = item;
    // });
    await onCallDataPosInvoiceDetail(item);
  }
  onCallDataPosOrder() async {
    final FrappeFetchDataGetInvoice.PosInvoiceRequest request =
        FrappeFetchDataGetInvoice.PosInvoiceRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: '[["docstatus","=",1]]',
      orderBy: 'posting_date desc',
      limit: 2000,
    );

    try {
      final callRequest =
          await FrappeFetchDataGetInvoice.request(requestQuery: request);

      if (callRequest.isNotEmpty) {
        setState(() {
          tempPosOrder = callRequest;
          isLoading = false;
        });
        print('check ata, $tempPosOrder');
      }
    } catch (error) {
      print('error call data pos order, $error');
      if (context.mounted) {
        alertError(context, error.toString());
      }
    }
  }

  onCallDataPosInvoiceDetail(dynamic invoice) async {
    final FrappeFetchDataGetInvoice.PosInvoiceRequest reqPosInvoiceDetail = FrappeFetchDataGetInvoice.PosInvoiceRequest(cookie: AppState().setCookie, id: invoice['name']);

    try {
      final request = await FrappeFetchDataGetInvoice.requestDetail(
          requestQuery: reqPosInvoiceDetail);

      if (request.isNotEmpty) {
        setState(() {
          invoiceSelected = request;
        });
      }

      print('check detail, $request');

      // if (context.mounted) {
      //   Navigator.of(context).pushNamedAndRemoveUntil(
      //     AppRoutes.invoiceScreen,
      //     (route) => false,
      //   );
      // }
    } catch (error) {
      // isLoading = false;
      if (error is TimeoutException) {
        // Handle timeout error
        // _bottomScreenTimeout(context);
      } else {
        if (context.mounted) {
          alertError(context, error.toString());
        }
      }
      return;
    }
  }
}
