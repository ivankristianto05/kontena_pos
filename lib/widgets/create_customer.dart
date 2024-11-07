import 'package:flutter/material.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';

class CreateCustomerWidget extends StatefulWidget {
  CreateCustomerWidget({Key? key}) : super(key: key);

  @override
  _CreateCustomerState createState() => _CreateCustomerState();
}

class _CreateCustomerState extends State<CreateCustomerWidget> {
  TextEditingController customerName = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                width: MediaQuery.sizeOf(context).width * 0.25,
                height: MediaQuery.sizeOf(context).height * 0.4,
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
                              'Create a New Customer',
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              Navigator.of(context).pop(false);
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
                                    color: theme.colorScheme.secondary,
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
                      // width: double.infinity,
                      // height: 48.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 6.0, 16.0, 6.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name',
                                  style: TextStyle(
                                    color: theme.colorScheme.secondary,
                                  ),
                                ),
                                const SizedBox(height: 6.0),
                                Container(
                                  // width: 280.0,
                                  height: 51.0,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primaryContainer,
                                    border: Border.all(
                                      color: theme.colorScheme.outline,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: TextField(
                                    controller: customerName,
                                    decoration: InputDecoration(
                                      hintText: 'Enter customer name',
                                      hintStyle: TextStyle(
                                        color: theme
                                            .colorScheme.onPrimaryContainer,
                                        fontSize: 14.0,
                                      ),
                                      // filled: true,
                                      // fillColor: Colors.white,
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.all(12.0),
                                    ),
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8.0, 8.0, 8.0, 8.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                // onTapDone(context);
                              },
                              child: Container(
                                width: double.infinity,
                                height: 48.0,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                alignment:
                                    const AlignmentDirectional(0.00, 0.00),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      4.0, 4.0, 4.0, 4.0),
                                  child: Text(
                                    'Add Customer',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: theme.colorScheme.primaryContainer,
                                    ),
                                  ),
                                ),
                              ),
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
        ],
      ),
    );
  }
}
