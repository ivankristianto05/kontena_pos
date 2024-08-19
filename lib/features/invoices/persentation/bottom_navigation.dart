import 'package:flutter/material.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';

class BottomNavigationInvoice extends StatelessWidget {
  final double dataContentWidth;

  const BottomNavigationInvoice({
    Key? key,
    required this.dataContentWidth,
  }) : super(key: key);

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
              color: theme.colorScheme.secondaryContainer,
              border: Border.all(
                // right: BorderSide(
                color: theme.colorScheme.primary,
                width: 2.0,
                // ),
                // bottom: BorderSide(
                //   color: theme.colorScheme.surface,
                //   width: 1.0,
                // ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Produk',
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.07,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Voucher',
                  style: TextStyle(color: theme.colorScheme.secondary),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: dataContentWidth,
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
                              style: theme.textTheme.labelLarge,
                            ),
                            Text(
                              '0 item',
                              style: theme.textTheme.labelSmall,
                            ),
                          ],
                        ),
                        Text(
                          'IDR 0',
                          style: theme.textTheme.labelLarge,
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
