import 'package:flutter/material.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';

import 'package:kontena_pos/core/api/frappe_thunder_pos/opening_cashier.dart'
    as FrappeFetchOpeningCashier;
import 'package:kontena_pos/core/api/frappe_thunder_pos/create_opening_entry.dart'
    as FrappeFetchCreateOpeningEntry;
import 'package:kontena_pos/core/api/frappe_thunder_pos/create_closing_entry.dart'
    as FrappeFetchCreateClosingEntry;
import 'package:kontena_pos/core/api/frappe_thunder_pos/entry_closing.dart'
    as FrappeFetchEntryClosing;
import 'package:kontena_pos/core/utils/alert.dart';
import 'package:kontena_pos/core/utils/datetime_ui.dart';
import 'package:kontena_pos/widgets/session_closing.dart';

class TopBar extends StatefulWidget {
  TopBar({
    super.key,
    this.isSelected,
    this.onTapRefresh,
  });

  final String? isSelected;
  final VoidCallback? onTapRefresh;

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  // double smallButtonWidth = 40.0;
  // double buttonWidth = 40.0;
  double menuWidth = 240.0;
  double iconWidth = 48.0;
  bool isClosing = false;

  List<dynamic> sessionInvoiceCashier = [];

  List<dynamic> paymentOpening = [];

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    // onCallOpeCashier();
  }

  @override
  void initState() {
    super.initState();
    onCallSessionCashier();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 40.0,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 50.0,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: theme.colorScheme.outline,
                      width: 1.0,
                    ),
                    // bottom: BorderSide(
                    //   color: theme.colorScheme.surface,
                    //   width: 1.0,
                    // ),
                  ),
                  // color: theme.colorScheme.secondary,
                ),
                child: MaterialButton(
                  height: 48.0,
                  child: Icon(
                    Icons.refresh,
                    color: theme.colorScheme.secondary,
                  ),
                  onPressed: widget.onTapRefresh,
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.15,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: theme.colorScheme.outline,
                      width: 1.0,
                    ),
                    // bottom: BorderSide(
                    //   color: theme.colorScheme.surface,
                    //   width: 1.0,
                    // ),
                  ),
                ),
                child: MaterialButton(
                  height: 50,
                  onPressed: () {
                    // Define the action for the Order button
                    onTapOrder(context);
                  },
                  child: Text(
                    'Order',
                    style: TextStyle(
                      color: widget.isSelected == 'order'
                          ? theme.colorScheme.primary
                          : theme.colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // if (isWideScreen) ...[
              Container(
                width: MediaQuery.sizeOf(context).width * 0.15,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: theme.colorScheme.outline,
                      width: 1.0,
                    ),
                    // bottom: BorderSide(
                    //   color: theme.colorScheme.surface,
                    //   width: 1.0,
                    // ),
                  ),
                ),
                child: MaterialButton(
                  height: 51,
                  onPressed: () {
                    // Define the action for the Invoice button
                    onTapInvoice(context);
                  },
                  child: Text(
                    'Invoice',
                    style: TextStyle(
                      color: widget.isSelected == 'invoice'
                          ? theme.colorScheme.primary
                          : theme.colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.15,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: theme.colorScheme.outline,
                      width: 1.0,
                    ),
                    // bottom: BorderSide(
                    //   color: theme.colorScheme.surface,
                    //   width: 1.0,
                    // ),
                  ),
                ),
                child: MaterialButton(
                  height: 51,
                  onPressed: () {
                    // Define the action for the History button
                    onTapHistoryInvoice(context);
                  },
                  child: Text(
                    'History',
                    style: TextStyle(
                      color: widget.isSelected == 'history'
                          ? theme.colorScheme.primary
                          : theme.colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.15,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: theme.colorScheme.outline,
                      width: 1.0,
                    ),
                    // bottom: BorderSide(
                    //   color: theme.colorScheme.surface,
                    //   width: 1.0,
                    // ),
                  ),
                ),
                child: MaterialButton(
                  height: 51,
                  onPressed: () {
                    // Define the action for the History button
                    // onTapHistoryInvoice(context);
                    // onCallOpeCashier();
                    if (isClosing == true) {
                      onCloseCashier();
                    } else {
                      onOpenCashier();
                    }
                  },
                  child: Text(
                    isClosing ? 'Close Cashier' : 'Open Cashier',
                    style: TextStyle(
                      color: isClosing
                          ? theme.colorScheme.error
                          : theme.colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // ],
            ],
          ),
          Row(
            children: [
              // if (isWideScreen)
              Container(
                // width: double.infinity,
                height: 51,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: theme.colorScheme.outline,
                      width: 1.0,
                    ),
                    // bottom: BorderSide(
                    //   color: theme.colorScheme.surface,
                    //   width: 1.0,
                    // ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      AppState().configPosProfile['name'],
                      style: TextStyle(
                        color: theme.colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 51,
                height: 51,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: theme.colorScheme.outline,
                      width: 1.0,
                    ),
                    // bottom: BorderSide(
                    //   color: theme.colorScheme.surface,
                    //   width: 1.0,
                    // ),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    // Define the action for the MaterialButton
                    onTapSetting(context);
                  },
                  child: Icon(
                    Icons.settings,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
              Container(
                height: 51,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: theme.colorScheme.outline,
                      width: 1.0,
                    ),
                    // bottom: BorderSide(
                    //   color: theme.colorScheme.surface,
                    //   width: 1.0,
                    // ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: theme.colorScheme.secondary,
                    ),
                    const SizedBox(width: 8), // Space between text and icon
                    Text(
                      AppState().configUser['name'],
                      style: TextStyle(
                        color: theme.colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 51,
                height: 51,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: theme.colorScheme.outline,
                      width: 1.0,
                    ),
                    // bottom: BorderSide(
                    //   color: theme.colorScheme.surface,
                    //   width: 1.0,
                    // ),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    // Define the action for the MaterialButton
                    onLogOut(context);
                  },
                  child: Icon(
                    Icons.logout,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
//
  // @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  onTapInvoice(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.invoiceScreen,
      (route) => false,
    );
  }

  onTapHistoryInvoice(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.historyInvoiceScreen,
      (route) => false,
    );
  }

  onTapOrder(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.orderScreen,
      (route) => false,
    );
  }

  onTapSetting(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.settingScreen,
      (route) => false,
    );
  }

  onLogOut(BuildContext context) async {
    // await myMe.removeStoredUser();
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.loginScreen,
      (route) => false,
    );
  }

  onOpenCashier() async {
    print('state opening');
    List<dynamic> payment = AppState().configPosProfile['payments'];
    List<dynamic> tmp = [];
    for (var pay in payment) {
      if (pay['mode_of_payment'].toString().toLowerCase() == 'cash') {
        tmp.add({
          'mode_of_payment': pay['mode_of_payment'],
          'opening_amount': 0,
        });
      }
    }
    setState(() {
      paymentOpening = tmp;
    });

    // print('check, ${AppState().configPosProfile['payments']}');
    await onCallCreateOpeningEntry();
  }

  onCloseCashier() async {
    // print('state closing');
    // print('state closing, ${AppState().sessionCashier}');
    await onCallEntryClosingInvoice();
    // await onCallCreateClosingEntry();

    // if (sessionInvoiceCashier) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: const Color(0x8A000000),
      barrierColor: const Color(0x00000000),
      context: context,
      builder: (context) {
        return SessionClosing(
          dataSession: sessionInvoiceCashier,
        );
      },
    ).then(
      (value) => {
        // setState(() {
        //   tableNumber = AppState().tableNumber;
        // }),
        // print('check table number , $tableNumber')
      },
    );
    // }
  }

  onCallSessionCashier() async {
    final FrappeFetchOpeningCashier.OpeningCashier request =
        FrappeFetchOpeningCashier.OpeningCashier(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters:
          '[["status","=","Open"],["user","=","${AppState().configUser['name']}"],["pos_profile","=","${AppState().configPosProfile['name']}"]]',
      limit: 20,
    );

    try {
      final callRequest =
          await FrappeFetchOpeningCashier.request(requestQuery: request);

      // print('result call opening cashier, ${callRequest}');
      if (callRequest.isNotEmpty) {
        setState(() {
          isClosing = callRequest.length > 0 ? true : false;
        });
        AppState().update(() {
          AppState().sessionCashier = callRequest[0];
        });
      }
    } catch (error) {
      print('error call data openig, $error');
      if (context.mounted) {
        // alertError(context, error.toString());
      }
    }
  }

  onCallCreateOpeningEntry() async {
    final FrappeFetchCreateOpeningEntry.CreateOpeningEntry request =
        FrappeFetchCreateOpeningEntry.CreateOpeningEntry(
      cookie: AppState().setCookie,
      periodStart:
          '${dateTimeFormat('date', null).toString()} ${timeFormat('time_full', null).toString()}',
      postingDate: dateTimeFormat('date', null).toString(),
      company: AppState().configCompany['name'],
      posProfile: AppState().configPosProfile['name'],
      user: AppState().configUser['name'],
      balance: paymentOpening,
    );

    try {
      final callApi =
          await FrappeFetchCreateOpeningEntry.request(requestQuery: request);
      if (callApi.isNotEmpty) {}
    } catch (error) {
      if (context.mounted) {
        alertError(context, error.toString());
      }
    }
  }

  onCallCreateClosingEntry() async {
    final FrappeFetchCreateClosingEntry.CreateClosingEntry request =
        FrappeFetchCreateClosingEntry.CreateClosingEntry(
      cookie: AppState().setCookie,
      periodStart: AppState().sessionCashier['period_start_date'],
      periodEnd:
          '${dateTimeFormat('date', null).toString()} ${timeFormat('time_full', null).toString()}',
      postingDate: dateTimeFormat('date', null).toString(),
      posOpeningId: AppState().sessionCashier['name'],
      company: AppState().configCompany['name'],
      posProfile: AppState().configPosProfile['name'],
      user: AppState().configUser['name'],
    );

    try {
      final callApi =
          await FrappeFetchCreateClosingEntry.request(requestQuery: request);
      if (callApi.isNotEmpty) {
        // print('response, ${callApi}');
      }
    } catch (error) {
      if (context.mounted) {
        alertError(context, error.toString());
      }
    }
  }

  onCallEntryClosingInvoice() async {
    final FrappeFetchEntryClosing.EntryClosing request =
        FrappeFetchEntryClosing.EntryClosing(
      cookie: AppState().setCookie,
      periodStart: AppState().sessionCashier['period_start_date'],
      periodEnd:
          '${dateTimeFormat('date', null).toString()} ${timeFormat('time_full', null).toString()}',
      postingDate: dateTimeFormat('date', null).toString(),
      posOpeningId: AppState().sessionCashier['name'],
      company: AppState().configCompany['name'],
      posProfile: AppState().configPosProfile['name'],
      user: AppState().configUser['name'],
    );

    try {
      final callApi =
          await FrappeFetchEntryClosing.request(requestQuery: request);
      if (callApi.isNotEmpty) {
        // print('response, ${callApi}');
        setState(() {
          sessionInvoiceCashier = callApi;
        });
      }
    } catch (error) {
      if (context.mounted) {
        alertError(context, error.toString());
      }
    }
  }
}
