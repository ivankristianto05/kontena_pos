import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/app_export.dart';
import 'package:kontena_pos/core/utils/alert.dart';
import 'package:kontena_pos/core/utils/datetime_ui.dart';
import 'package:kontena_pos/core/utils/number_ui.dart';
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
                                                          Divider(
                                                            height: 5.0,
                                                            thickness: 0.5,
                                                            color: theme
                                                                .colorScheme
                                                                .outline,
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
                      Column(
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.25,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              border: Border(
                                left: BorderSide(
                                  color: theme.colorScheme.outline,
                                ),
                              ),
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
}
