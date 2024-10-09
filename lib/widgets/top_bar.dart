import 'package:flutter/material.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  // final double smallButtonWidth;
  // final double buttonWidth;
  // final bool isWideScreen;
  final String? isSelected;

  TopBar({super.key, this.isSelected});
  // double smallButtonWidth = 40.0;
  // double buttonWidth = 40.0;
  double menuWidth = 240.0;
  double iconWidth = 48.0;

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
                width: iconWidth,
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
                  onPressed: () {
                    // Define the action for the refresh button
                  },
                ),
              ),
              Container(
                width: menuWidth,
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
                    // Define the action for the Order button
                    onTapOrder(context);
                  },
                  child: Text(
                    'Order',
                    style: TextStyle(
                      color: isSelected == 'order'
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
                width: menuWidth,
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
                      color: isSelected == 'invoice'
                          ? theme.colorScheme.primary
                          : theme.colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: menuWidth,
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
                      color: isSelected == 'history'
                          ? theme.colorScheme.primary
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
                      'Shokudo Restaurant',
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
                width: iconWidth,
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
                      'Administrator',
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
                width: iconWidth,
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
}
