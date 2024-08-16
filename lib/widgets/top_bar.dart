import 'package:flutter/material.dart';
import 'package:kontena_pos/constants.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/routes/app_routes.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final double smallButtonWidth;
  final double buttonWidth;
  // final bool isWideScreen;

  const TopBar({
    super.key,
    required this.smallButtonWidth,
    required this.buttonWidth,
    // required this.isWideScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: smallButtonWidth,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: theme.colorScheme.surface,
                    width: 1.0,
                  ),
                  // bottom: BorderSide(
                  //   color: theme.colorScheme.surface,
                  //   width: 1.0,
                  // ),
                ),
                color: theme.colorScheme.primaryContainer,
              ),
              child: MaterialButton(
                height: 51,
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
              width: buttonWidth,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: theme.colorScheme.surface,
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
                    color: theme.colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // if (isWideScreen) ...[
            Container(
              width: buttonWidth,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: theme.colorScheme.surface,
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
                    color: theme.colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: buttonWidth,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: theme.colorScheme.surface,
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
                    color: theme.colorScheme.secondary,
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
              width: buttonWidth,
              height: 51,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: theme.colorScheme.surface,
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
              width: smallButtonWidth,
              height: 51,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: theme.colorScheme.surface,
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
                    color: theme.colorScheme.surface,
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
                  Text(
                    'Administrator',
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8), // Space between text and icon
                  Icon(
                    Icons.person,
                    color: theme.colorScheme.secondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
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
