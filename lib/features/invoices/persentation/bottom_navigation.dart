import 'package:flutter/material.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';

class BottomNavigationInvoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.07,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Produk',
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.07,
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Voucher',
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.sizeOf(context).width * 0.3,
          height: MediaQuery.sizeOf(context).height * 0.07,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bayar',
                              style: theme.textTheme.labelMedium,
                            ),
                            Text(
                              '0 item',
                              style: theme.textTheme.labelSmall,
                            ),
                          ],
                        ),
                        Text(
                          'IDR 0',
                          style: theme.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
